import 'package:flutter/material.dart';
import 'package:flutter_web_demo_trip/page/provider/multi/provider_example_multi_page2.dart';
import 'package:provider/provider.dart';

import 'muti_number_increase.dart';

class ProviderExampleMultiPage1 extends StatefulWidget {
  const ProviderExampleMultiPage1({super.key});

  @override
  State<ProviderExampleMultiPage1> createState() =>
      _ProviderExampleMultiPage1State();
}

class _ProviderExampleMultiPage1State extends State<ProviderExampleMultiPage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider(
        create: (BuildContext context) {
          MultiNumberIncreaseProvider();
        },
        child: Center(
          child: Consumer<MultiNumberIncreaseProvider>(
            builder: (BuildContext context,
                MultiNumberIncreaseProvider numberIncreaseProvider,
                Widget? child) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<MultiNumberIncreaseProvider>(context,
                              listen: false)
                          .increase();
                    },
                    child: Text(
                      '数字+1',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '自增数字的结果=> ${numberIncreaseProvider.Value}',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const ProviderExampleMultiPage2(),
                          ),
                        );
                      },
                      child: Text('跳到页面2'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class NumberIncreaseProvider extends ChangeNotifier {
  int value = 0;

  int get Value {
    return value;
  }

  void increase() {
    value++;
    notifyListeners();
  }
}
