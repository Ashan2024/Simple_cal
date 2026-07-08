import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Dark theme එක calculator එකට ලස්සනයි
      home: const CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  // මේවා තමයි අපේ display එකේ පේන variables
  String history = "";
  String expression = "0";

  // Button එකක් click කරාම වැඩ කරන function එක (දැනට නිකන් තියෙන්නේ)
  void numClick(String text) {
    setState(() {
      expression = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 1. Display Area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    history,
                    style: const TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    expression,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Divider එකක් දාමු display එකයි buttons යි වෙන් වෙන්න
          const Divider(height: 1),

          // 2. Buttons Grid
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                buildButtonRow(["C", "+/-", "%", "/"]),
                buildButtonRow(["7", "8", "9", "x"]),
                buildButtonRow(["4", "5", "6", "-"]),
                buildButtonRow(["1", "2", "3", "+"]),
                buildButtonRow(["0", "00", ".", "="]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Row එකක් ඇතුලේ buttons ටික පිළිවෙලට හදන helper function එකක්
  Widget buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((text) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            width: 75,
            height: 75,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), // රවුම් buttons
                backgroundColor: _getBtnColor(text),
              ),
              onPressed: () => numClick(text),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // Button එකේ හැඩය අනුව පාට වෙනස් කරන්න
  Color _getBtnColor(String text) {
    if (text == "C" || text == "+/-" || text == "%") return Colors.grey;
    if (["/", "x", "-", "+", "="].contains(text)) return Colors.orange;
    return Colors.grey[800]!;
  }
}
