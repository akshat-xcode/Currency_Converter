import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  double result = 0;
  final TextEditingController amountController = TextEditingController();

  String fromCurrency = 'USD';
  String toCurrency = 'INR';

  final Map<String, double> exchangeRates = {
    'USD': 1.0,
    'INR': 86.50,
    'EUR': 0.92,
    'GBP': 0.79,
    'JPY': 155.20,
    'CAD': 1.39,
    'AUD': 1.56,
    'AED': 3.67,
  };

  void convert() {
    setState(() {
      final amount = double.tryParse(amountController.text) ?? 0.0;
      final fromRate = exchangeRates[fromCurrency] ?? 1.0;
      final toRate = exchangeRates[toCurrency] ?? 1.0;
      result = (amount / fromRate) * toRate;
    });
  }

  void swap() {
    setState(() {
      final temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
      convert();
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
        color: Colors.black,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(5),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  result != 0
                      ? '$toCurrency ${result.toStringAsFixed(2)}'
                      : '0',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 252, 252, 252),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        value: fromCurrency,
                        dropdownColor: Colors.blueGrey[800],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        items: exchangeRates.keys.map((String curr) {
                          return DropdownMenuItem<String>(
                            value: curr,
                            child: Text(curr),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              fromCurrency = val;
                              convert();
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: swap,
                        icon: const Icon(Icons.swap_horiz, color: Colors.white, size: 30),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: toCurrency,
                        dropdownColor: Colors.blueGrey[800],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        items: exchangeRates.keys.map((String curr) {
                          return DropdownMenuItem<String>(
                            value: curr,
                            child: Text(curr),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              toCurrency = val;
                              convert();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter the amount in $fromCurrency',
                      hintStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 163, 157, 157),
                      focusedBorder: border,
                      enabledBorder: border,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: convert,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Convert'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
