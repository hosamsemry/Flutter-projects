import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/chart/chart.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_app/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _list = [
    Expense(
      title: 'course',
      amount: 25.555555,
      category: Category.work,
      date: DateTime.now(),
    ),
    Expense(
      title: 'football',
      amount: 35,
      category: Category.play,
      date: DateTime.now(),
    ),
    Expense(
      title: 'travel',
      amount: 140,
      category: Category.travel,
      date: DateTime.now(),
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _list.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _list.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          'Expenses App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (c) => NewExpense(onAddExpense: _addExpense),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: width<600? Column(
        children: [
          Expanded(child: Chart(expenses: _list)),
          Expanded(
            child: ExpensesList(list: _list, onRemoveExpense: _removeExpense),
          ),
        ],
      ):Row(
        children: [
          Expanded(child: Chart(expenses: _list)),
          Expanded(
            child: ExpensesList(list: _list, onRemoveExpense: _removeExpense),
          ),
        ],
      ),
    );
  }
}
