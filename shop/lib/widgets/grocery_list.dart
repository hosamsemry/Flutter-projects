import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop/data/categories.dart';
import 'package:shop/models/grocery_item.dart';
import 'package:shop/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  String? _error;

  void loadData() async {
    final url = Uri.parse(
      dotenv.env['DATABASE_URL']?? '',
    );
    try{
      
    
    final res = await http.get(url);
    if (res.statusCode >= 400) {
      setState(() {
        _error = 'Failed to fetch data. Please try again later.';
        _isLoading = false;
      });
      return;
    }

    if (res.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final Map<String,dynamic> data = json.decode(res.body);
    final List<GroceryItem> _loadedItems = [];
    for (var item in data.entries) {
      final category = categories.entries.firstWhere(
        (c) => c.value.title == item.value['category'],
      ).value;
      _loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
      setState(() {
      _groceryItems = _loadedItems;
      _isLoading = false;        
      });
    }
    }catch(e){
      setState(() {
        _error ='Something went wrong. Please try again later.';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text('No items added yet.'));
    if (_error != null) {
      content = Center(child: Text(_error!));
    }
    if(_isLoading){
      content = const Center(child: CircularProgressIndicator());
    }

    if (_groceryItems.isNotEmpty) {
      content = Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(_groceryItems[index].id),
            onDismissed: (_) {
              _removeItem(_groceryItems[index]);
            },
            child: ListTile(
              title: Text(
                _groceryItems[index].name,
                style: TextStyle(color: Colors.white),
              ),
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItems[index].category.color,
              ),
              trailing: Text(
                _groceryItems[index].quantity.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery List'),
        actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
      ),
      body: content,
    );
  }

  void _removeItem(GroceryItem item) async{

    final index = _groceryItems.indexOf(item);

    setState(() {
      _groceryItems.remove(item);

    });
  
    final deleteUrl = Uri.parse('${dotenv.env['BASE_URL']}/groceries/${item.id}.json');
    final deleteResponse = await http.delete(deleteUrl);
    if (deleteResponse.statusCode >= 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove item')),
      );
      setState(() {
      _groceryItems.insert(index, item);

    });
    }
    
  }

  void _addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => NewItem()));
    if (newItem == null) return;
    setState(() {
      _groceryItems.add(newItem);
    });
  }
}
