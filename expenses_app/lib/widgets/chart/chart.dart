import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(allExpenses: expenses, category: Category.work),
      ExpenseBucket.forCategory(allExpenses: expenses, category: Category.food),
      ExpenseBucket.forCategory(allExpenses: expenses, category: Category.travel),
      ExpenseBucket.forCategory(allExpenses: expenses, category: Category.play),
    ];
  }

  double get maxTotalExpense {
    double maxTotal = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotal) {
        maxTotal = bucket.totalExpenses;
      }
    }
    return maxTotal;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint){
        return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: constraint.maxHeight,
        decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(6), bottom: Radius.circular(0)), color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ]),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final bucket in buckets)
                    ChartBar(fill: bucket.totalExpenses / maxTotalExpense),
                ],
              ),
            ),
            // SizedBox(height: 12),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: buckets
                    .map(
                      (bucket) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            bucket.category.name,
                            style: TextStyle(color: const Color.fromARGB(255, 0, 68, 255)),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(height: 12),
            Expanded(child: Row(children: [
      
                ],
              )),
          ],
        ),
      );
      },
    );
  }
}
