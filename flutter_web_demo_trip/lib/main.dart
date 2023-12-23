import 'package:flutter/material.dart';
import 'package:flutter_web_demo_trip/page/provider/multi/muti_number_increase.dart';
import 'package:flutter_web_demo_trip/page/provider/single/provider_example_single_page.dart';
import 'package:flutter_web_demo_trip/page/provider/single/single_number_increase.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page/animation/animated_positioned_page.dart';
import 'page/provider/multi/provider_example_multi_page1.dart';
import 'page/provider/theme/theme_provider.dart';

late SharedPreferences SP;

void main() {
  _init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: SingleNumberIncreaseProvider()),
      ChangeNotifierProvider.value(value: MultiNumberIncreaseProvider()),
      ChangeNotifierProvider.value(value: ThemeProvider()),
    ],
    child: MyApp(),
  ));
}

void _init() async {
  SP = await SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder:
        (BuildContext context, ThemeProvider themeProvider, Widget? child) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: !themeProvider.isDark()
            ? ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              )
            : ThemeData.dark(),
        home: const HomePage(),
      );
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(2, 2),
    end: const Offset(0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  bool _sliceShow = false;

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            backgroundColor: Colors.green,
            title: Text(
              'provider相关',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              buildButton(context, (BuildContext context) {
                return ProviderExampleSinglePage();
              }, 'Provider例子（单页面）'),
              buildButton(context, (BuildContext context) {
                return ProviderExampleMultiPage1();
              }, 'Provider例子（多页面传值）'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _sliceShow = true;
                    });
                    _controller.forward();
                  },
                  child: Text('浮动按钮从右下方弹出'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _sliceShow = false;
                    });
                    _controller.reset();
                  },
                  child: Text('浮动按钮隐藏'),
                ),
              ),
            ],
          ),
          Consumer<ThemeProvider>(builder: (BuildContext context,
              ThemeProvider themeProvider, Widget? child) {
            return ElevatedButton(
                onPressed: () {
                  themeProvider
                      .setDarkTheme(themeProvider.isDark() ? false : true);
                  return;
                },
                child: Text(
                  '点击切换模式',
                  style: TextStyle(fontSize: 16),
                ));
          }),
          ExpansionTile(
            title: Text(
              '动画集合',
            ),
            children: [
              buildButton(context, (BuildContext context) {
                return AnimatedPositionedPage();
              }, 'AnimatedPositioned页面'),
            ],
          )
        ],
      ),
      floatingActionButton: SlideTransition(
        position: _offsetAnimation,
        child: AnimatedOpacity(
          opacity: _sliceShow ? 1 : 0,
          duration: Duration(milliseconds: 3000),
          child: FloatingActionButton(
            backgroundColor: Colors.blue[300],
            onPressed: () {},
            child: Icon(
              FontAwesomeIcons.pen,
              size: 16,
            ),
          ),
        ),
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
      drawer: buildDrawer(),
    );
  }

  Drawer buildDrawer() {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Drawer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF94377F),
              Color(0xFFF79283),
            ],
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      image: AssetImage(
                        'image/home/default_avator.png',
                      ),
                    ),
                    color: Colors.grey),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text('签到'),
                    leading: Icon(
                      Icons.more_vert,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      BuildContext context, WidgetBuilder builder, String buttonName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: FractionallySizedBox(
        widthFactor: 1,
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
