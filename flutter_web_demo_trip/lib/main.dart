import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_web_demo_trip/page/provider/multi/muti_number_increase.dart';
import 'package:flutter_web_demo_trip/page/provider/single/provider_example_single_page.dart';
import 'package:flutter_web_demo_trip/page/provider/single/single_number_increase.dart';
import 'package:provider/provider.dart';

import 'page/provider/multi/provider_example_multi_page1.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: SingleNumberIncreaseProvider()),
      ChangeNotifierProvider.value(value: MultiNumberIncreaseProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        Icons.home,
        color: Colors.blueAccent,
      ),
      label: '主页',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        Icons.person,
        color: Colors.blueAccent,
      ),
      label: '个人',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            buildButton(context, (BuildContext context) {
              return ProviderExampleSinglePage();
            }, 'Provider例子（单页面）'),
            buildButton(context, (BuildContext context) {
              return ProviderExampleMultiPage1();
            }, 'Provider例子（多页面传值）'),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: 80,
              color: Colors.green,
              child: Text('Provider例子'),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.blueAccent,
          items: items,
          onTap: (idx) {
            setState(() {
              _currentIndex = idx;
            });
          },
        ),
      ),
    );
  }

  Container buildButton(
      BuildContext context, WidgetBuilder builder, String buttonName) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: 80,
      color: Colors.green,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: builder,
              ),
            );
          },
          child: Text(buttonName),
        ),
      ),
    );
  }
}
