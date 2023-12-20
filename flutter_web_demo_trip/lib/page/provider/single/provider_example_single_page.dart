import 'package:flutter/material.dart';
import 'package:flutter_web_demo_trip/page/provider/single/single_number_increase.dart';
import 'package:provider/provider.dart';

class ProviderExampleSinglePage extends StatefulWidget {
  const ProviderExampleSinglePage({super.key});

  @override
  State<ProviderExampleSinglePage> createState() =>
      _ProviderExampleSinglePageState();
}

class _ProviderExampleSinglePageState extends State<ProviderExampleSinglePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Consumer<SingleNumberIncreaseProvider>(
          builder: (BuildContext context,
              SingleNumberIncreaseProvider numberIncreaseProvider,
              Widget? child) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<SingleNumberIncreaseProvider>(context,
                            listen: false)
                        .increase();
                  },
                  child: Text(
                    '点击增加数字',
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
              ],
            );
          },
        ),
      ),
    );
  }
}
