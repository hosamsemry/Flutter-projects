
import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';


class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required List<Expense> list, required this.onRemoveExpense,
  }) : _list = list;

  final List<Expense> _list;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context, i){
        return Dismissible(
          background: Container(
            color: Colors.red,
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
          ),
          key: ValueKey(_list[i]),
          onDismissed: (direction)=> onRemoveExpense(_list[i]),
          child: ExpensesItem(expense:_list[i] )
          );
      },
      
    );
  }
}