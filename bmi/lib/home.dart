import 'package:bmi/result.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMale = true;
  double height = 180;
  int weight = 70;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator")),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  m1Expanded(context, 'male'),
                  SizedBox(width: 10),
                  m1Expanded(context, 'female'),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 192, 192, 192),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Height', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(height.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Text('cm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                        ],
                    ),
                    Slider(
                      value: height,
                      divisions: 140,
                      onChanged: (value) {
                        setState(() {
                          height = value;
                        });
                      },
                      min: 80,
                      max: 220,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  m2Expanded(context, 'weight'),
                  SizedBox(width: 10),
                  m2Expanded(context, 'age'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  final result = weight / ((height / 100) * (height / 100));
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          Result(result: result, isMale: isMale, age: age),
                    ),
                  );
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded m1Expanded(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMale = type == 'male' ? true : false;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: (type == 'male' && isMale) || (type == 'female' && !isMale)
                ? Colors.blue
                : const Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Icon(type == 'male' ? Icons.male : Icons.female, size: 80),
              SizedBox(height: 10),
              Text(
                type == 'male' ? 'Male' : 'Female',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded m2Expanded(BuildContext context, String type) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 192, 192, 192),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              type == 'age' ? 'Age' : 'Weight',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              type == 'age' ? age.toString() : weight.toString(),
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: type == 'age' ? 'age--' : 'weight--',
                  onPressed: () {
                    setState(() {
                      if (type == 'age') {
                        age--;
                      } else {
                        weight--;
                      }
                    });
                  },
                  mini: true,
                  child: Icon(Icons.remove),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: type == 'age' ? 'age++' : 'weight++',
                  onPressed: () {
                    setState(() {
                      if (type == 'age') {
                        age++;
                      } else {
                        weight++;
                      }
                    });
                  },
                  mini: true,
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
