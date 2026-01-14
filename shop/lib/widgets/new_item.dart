import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop/data/categories.dart';
import 'package:shop/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var _enterdName = '';
  var _enterdQuantity = 1;
  var _enterdCategory = categories[Categories.vegetables]!;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
      _isLoading = true; 
      });
      final url = Uri.parse(
        dotenv.env['DATABASE_URL']?? '',
      );

      final getResponse = await http.get(url);
      Map<String, dynamic> groceries = {};
      if (getResponse.statusCode == 200 && getResponse.body != 'null') {
        groceries = json.decode(getResponse.body) as Map<String, dynamic>;
      }

      String? existingKey;
      int existingQuantity = 0;

      groceries.forEach((key, value) {
        if (value['name'] == _enterdName &&
            value['category'] == _enterdCategory.title) {
          existingKey = key;
          existingQuantity = value['quantity'] is int
              ? value['quantity']
              : int.tryParse(value['quantity'].toString()) ?? 0;
        }
      });

      if (existingKey != null) {
        final updateUrl = Uri.parse(
          dotenv.env['DATABASE_URL']?? '',
        );
        final updatedQuantity = existingQuantity + _enterdQuantity;
        final patchResponse = await http.patch(
          updateUrl,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'quantity': updatedQuantity}),
        );
        if (patchResponse.statusCode == 200) {
          Navigator.of(context).pop();
        }
      } else {
        final postResponse = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'name': _enterdName,
            'quantity': _enterdQuantity,
            'category': _enterdCategory.title,
          }),
        );
        if (postResponse.statusCode == 200) {
          final responseData = json.decode(postResponse.body);
          Navigator.of(context).pop(
            GroceryItem(
              id: responseData['name'],
              name: _enterdName,
              quantity: _enterdQuantity,
              category: _enterdCategory,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Item')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onSaved: (newValue) {
                  _enterdName = newValue!;
                },
                maxLength: 50,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.trim().length <= 1) {
                    return 'Must be between 1 and 50 chracters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      onSaved: (newValue) {
                        _enterdQuantity = int.parse(newValue!);
                      },
                      maxLength: 50,
                      decoration: InputDecoration(labelText: 'Quantity'),
                      initialValue: '1',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            int.tryParse(value.trim()) == null ||
                            int.tryParse(value.trim())! < 1) {
                          return 'Must be a valid positive number.';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: DropdownButtonFormField(
                      onSaved: (newValue) {
                        setState(() {
                          _enterdCategory = newValue!;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Category'),
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  color: category.value.color,
                                ),
                                SizedBox(width: 10),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                      initialValue: _enterdCategory,
                      onChanged: (value) => {
                        setState(() {
                          _enterdCategory = value!;
                        }),
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                      foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    onPressed: () async {
                      _isLoading ? null : _saveItem();
                    },
                    child: Text(
                      _isLoading ? 'Adding...' : 'Add Item',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
