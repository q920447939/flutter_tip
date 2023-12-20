import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'muti_number_increase.dart';

class ProviderExampleMultiPage2 extends StatefulWidget {
  const ProviderExampleMultiPage2({super.key});

  @override
  State<ProviderExampleMultiPage2> createState() =>
      _ProviderExampleMultiPage2State();
}

class _ProviderExampleMultiPage2State extends State<ProviderExampleMultiPage2> {
  @override
  Widget build(BuildContext context) {
    int value = Provider.of<MultiNumberIncreaseProvider>(context).value;
    return Consumer(builder: (BuildContext context,
        MultiNumberIncreaseProvider numberIncreaseProvider, Widget? child) {
      return Container(
        child: Center(
          child: Column(
            children: [
              Text(
                'Page2 Value is ${value}',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<MultiNumberIncreaseProvider>(context,
                          listen: false)
                      .reduce();
                },
                child: Text(
                  '点击减少1',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
