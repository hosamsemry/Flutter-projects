import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormat = DateFormat.yMd();

enum Category { food, travel, work, play }

class Expense {
  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime date;

  String formattedDate() {
    return dateFormat.format(date);
  }

  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  }) : id = uuid.v4();
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory({
    required final List<Expense> allExpenses,
    required this.category,
  }) : expenses = allExpenses.where((element) => element.category == category,).toList();

  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
