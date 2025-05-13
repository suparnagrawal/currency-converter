import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget{
  const ConverterPage({super.key});

  @override
  State createState() => _CurrencyConv();
}

class _CurrencyConv extends State{
  TextEditingController textEditingControllerfrom = TextEditingController();
  double value = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Currency Converter App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Select Currency to Convert From:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: textEditingControllerfrom,
              keyboardType: TextInputType.numberWithOptions(decimal:true),
              style: TextStyle(
                fontSize: 20,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.currency_rupee), 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextButton(
              onPressed: (){
                setState(() {
                  value = double.parse(textEditingControllerfrom.text)*10;
                });
              },
               style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 20),
                textStyle: TextStyle(fontSize: 20)
               ),
               child: Text(
                'Convert',
               ),
               ),
          ),
          Text(
            'Result: ${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 25,
            ),
          )
        ],
      ),
      
    );
  }
}