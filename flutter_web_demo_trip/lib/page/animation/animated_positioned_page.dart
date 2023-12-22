import 'package:flutter/material.dart';

class AnimatedPositionedPage extends StatefulWidget {
  const AnimatedPositionedPage({super.key});

  @override
  State<AnimatedPositionedPage> createState() => _AnimatedPositionedPageState();
}

class _AnimatedPositionedPageState extends State<AnimatedPositionedPage>
    with SingleTickerProviderStateMixin {
  var rocketBottom = -40.0;
  var rocketWidth = 160.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 15,
              )),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            setState(() {
              rocketBottom = MediaQuery.of(context).size.height;
            });
          },
          child: Text('点击发送'),
        ),
        body: Center(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.cyan,
              ),
              AnimatedPositioned(
                child: Image.asset(
                  'image/home/rocket.gif',
                  fit: BoxFit.fitWidth,
                ),
                bottom: rocketBottom,
                width: rocketWidth,
                left: MediaQuery.of(context).size.width / 2,
                duration: Duration(seconds: 3),
                curve: Curves.easeInCubic,
                onEnd: () {
                  setState(() {
                    rocketBottom = -40.0;
                    rocketWidth = 160.0;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
