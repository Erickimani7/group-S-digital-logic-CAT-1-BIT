import 'package:flutter/material.dart';

void main() {
  runApp(const ConverterApp());
}

class ConverterApp extends StatelessWidget {
  const ConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number System Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConverterScreen(),
    );
  }
}

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController fromBaseController = TextEditingController();
  final TextEditingController toBaseController = TextEditingController();

  String result = "";

  static const String digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  int toDecimal(String numStr, int base) {
    numStr = numStr.trim().toUpperCase();
    int value = 0;
    for (var ch in numStr.split('')) {
      int digit = digits.indexOf(ch);
      if (digit < 0 || digit >= base) {
        throw Exception("Invalid digit '$ch' for base $base");
      }
      value = value * base + digit;
    }
    return value;
  }

  String fromDecimal(int number, int base) {
    if (number == 0) return "0";
    String res = "";
    int n = number;
    while (n > 0) {
      res = digits[n % base] + res;
      n ~/= base;
    }
    return res;
  }

  String convert(String numStr, int fromBase, int toBase) {
    int decimalValue = toDecimal(numStr, fromBase);
    return fromDecimal(decimalValue, toBase);
  }

  void doConvert() {
    try {
      String number = numberController.text;
      int fromBase = int.parse(fromBaseController.text);
      int toBase = int.parse(toBaseController.text);

      String converted = convert(number, fromBase, toBase);
      setState(() {
        result = "Result: $converted";
      });
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number System Converter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: "Enter number"),
            ),
            TextField(
              controller: fromBaseController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "From base (2–36)"),
            ),
            TextField(
              controller: toBaseController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "To base (2–36)"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: doConvert,
              child: const Text("Convert"),
            ),
            const SizedBox(height: 16),
            Text(
              result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
