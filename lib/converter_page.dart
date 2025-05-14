import 'package:flutter/material.dart';
import 'package:forex_currency_conversion/forex_currency_conversion.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State createState() => _CurrencyConv();
}

class _CurrencyConv extends State {
  TextEditingController textEditingController1 = TextEditingController(
    text: '0.00',
  );
  TextEditingController textEditingController2 = TextEditingController(
    text: '0.00',
  );
  String dropDownValue1 = "USD";
  String dropDownValue2 = "USD";
  double usdToFirst = 1;
  double usdToSecond = 1;
  final fx = Forex();
  List<String> availableCurrencies = ['USD'];
  List<DropdownMenuItem> dropdownCurrencies = [
    DropdownMenuItem(value: 'USD', child: Text('USD')),
  ];

  void getCurrencies() async {
    availableCurrencies = await fx.getAvailableCurrencies();
    availableCurrencies.sort();
    setState(() {
      dropdownCurrencies = List.generate(
        availableCurrencies.length,
        (int index) => DropdownMenuItem(
          value: availableCurrencies[index],
          child: Text(availableCurrencies[index]),
        ),
      );
    });
  }

  void getPrice(dynamic val, int i) async {
    if (i == 1) {
      usdToFirst = await fx.getCurrencyConverted(
        destinationCurrency: val.toString(),
        sourceCurrency: "USD",
        sourceAmount: 1,
      );
      textEditingController2 = TextEditingController(
        text: (double.parse(
                  textEditingController1.text.isEmpty
                      ? '0.0'
                      : textEditingController1.text,
                ) *
                usdToSecond /
                usdToFirst)
            .toStringAsFixed(2),
      );
    }
    if (i == 2) {
      usdToSecond = await fx.getCurrencyConverted(
        destinationCurrency: val.toString(),
        sourceCurrency: "USD",
        sourceAmount: 1,
      );
      textEditingController1 = TextEditingController(
        text: (double.parse(
                  textEditingController2.text.isEmpty
                      ? '0.0'
                      : textEditingController2.text,
                ) *
                usdToFirst /
                usdToSecond)
            .toStringAsFixed(2),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  @override
  void dispose(){
    textEditingController1.dispose();
    textEditingController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Real-Time Currency Conversion',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            textAlign: TextAlign.center,
            '1 $dropDownValue1 = ${(usdToSecond / usdToFirst).toStringAsFixed(2)} $dropDownValue2',
            style: TextStyle(fontSize: 30),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    DropdownButton(
                      itemHeight: 120,
                      iconSize: 60,
                      style: TextStyle(fontSize: 50, color: Colors.black),
                      value: dropDownValue1,
                      items: dropdownCurrencies,
                      onChanged: (value1) {
                        dropDownValue1 = value1;
                        getPrice(dropDownValue1, 1);
                      },
                    ),
                    Text('  1 USD =\n $usdToFirst $dropDownValue1'),
                  ],
                ),
              ),
              Column(
                spacing: 50,
                children: [
                  SizedBox(
                    width: 275,
                    child: TextField(
                      controller: textEditingController1,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.arrow_forward_ios_sharp),
                      ),
                      onChanged: (whatever) {
                        getPrice(dropDownValue1, 1);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 275,
                    child: TextField(
                      onChanged: (whatever) {
                        getPrice(dropDownValue2, 2);
                      },
                      controller: textEditingController2,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      itemHeight: 120,
                      iconSize: 60,
                      style: TextStyle(fontSize: 50, color: Colors.black),
                      value: dropDownValue2,
                      items: dropdownCurrencies,
                      onChanged: (value2) {
                        dropDownValue2 = value2;
                        getPrice(dropDownValue2, 2);
                      },
                    ),
                    Text('  1 USD =\n $usdToSecond $dropDownValue2'),
                  ],
                ),
              ),
            ],
          ),
          Text(
            textAlign: TextAlign.center,
            '1 $dropDownValue2 = ${(usdToFirst / usdToSecond).toStringAsFixed(2)} $dropDownValue1',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
