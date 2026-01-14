import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  final dateFormat = DateFormat.yMd();

  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              maxLength: 60,
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount', prefixText: '\$'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : dateFormat.format(_selectedDate!),
                ),
                IconButton(
                  onPressed: () async {
                    final DateTime now = DateTime.now();
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(now.year - 10, now.month, now.day),
                      lastDate: DateTime(now.year + 1, now.month, now.day),
                    );
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<Category>(
              initialValue: _selectedCategory,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              items: Category.values.map((category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    final enteredTitle = _titleController.text;
                    final enteredAmount = double.tryParse(_amountController.text);
                    if (enteredTitle.trim().isEmpty ||
                        enteredAmount == null ||
                        enteredAmount <= 0 ||
                        _selectedDate == null) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Invalid Input'),
                          content: Text(
                            'Please enter a valid title, amount, and date.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }else {
      
                    widget.onAddExpense(Expense(title: _titleController.text, amount: enteredAmount, category: _selectedCategory, date: _selectedDate!));
                    // final newExpense = Expense(
                    //   title: enteredTitle,
                    //   amount: enteredAmount,
                    //   date: _selectedDate!,
                    //   category: _selectedCategory,
                    // );
                    Navigator.pop(context);
                    }
                  },
                  child: Text("Save Expense"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
