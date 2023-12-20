## Flutter使用Provider进行状态管理

provider是一个状态管理管理的框架。

区别于传统的`setState({})`更新数据，provider可以跨页面或者全局进行值更新，使用上更加轻量化。

可以简单的理解为：

​	1.一个提供者有多个消费者建立绑定关系，并注册到一个全局容器之中

​    2.当对容器内指定的数据进行修改后，通过`notify`通知所有的消费者消费数据。

​	这是典型的生产-消费者模型，等同于观察者设计模式。

![image-20231220141849212](./img\provider\design.png)



代码实操部分：

实现一个需求

​	在页面1 点击数字+1按钮后，页面1/2能够同时显示结果。

​	同时，在页面2点击数字-1按钮后，页面1/2能够同时显示结果。

1.在`pubspec.yaml`引入依赖:

​	`provider: 6.1.1`

2.消费者与提供者绑定关系：

```dart
#页面1
... 省略无关代码
class _ProviderExampleMultiPage1State extends State<ProviderExampleMultiPage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider(
        create: (BuildContext context) {
          MultiNumberIncreaseProvider();  #重点1，消费者绑定提供者，此处的消费者对应下方的Consumer
        },
        child: Center(
          child: Consumer<MultiNumberIncreaseProvider>(  #重点2，消费者具体消费逻辑
            builder: (BuildContext context,
                MultiNumberIncreaseProvider numberIncreaseProvider,
                Widget? child) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<MultiNumberIncreaseProvider>(context,
                              listen: false)
                          .increase(); #点击按钮后，将数字+1
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

#提供者
class MultiNumberIncreaseProvider extends ChangeNotifier {
  int value = 0;

  int get Value {
    return value;
  }

  void increase() {
    value++;
    notifyListeners(); #重要，通知所有消费者
  }

  void reduce() {
    value--;
    notifyListeners();  #重要，通知所有消费者
  }
}


#页面2
... 省略无关代码
class _ProviderExampleMultiPage2State extends State<ProviderExampleMultiPage2> {
  @override
  Widget build(BuildContext context) {
    int value = Provider.of<MultiNumberIncreaseProvider>(context).value; #重点，通过获取提供者的方法，获取到提供者实例中对应的属性或者方法
    return Consumer(builder: (BuildContext context,
        MultiNumberIncreaseProvider numberIncreaseProvider, Widget? child) { #消费者 与page1，同时绑定到MultiNumberIncreaseProvider上
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
                      .reduce();  #点击数字就 -1  ，并通知其他消费者
                },
                child: Text(
                  '数字-1',
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
```



2.将提供者注册到全局中：

```dart
#具体看放到什么位置，放的维度越高，影响范围越大(估摸着对性能损耗也越大)，这里我放到 main 方法中
 
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: MultiNumberIncreaseProvider()),#重要 显示将提供者放置到全局中
    ],
    child: MyApp(),
  ));
}

```

代码地址：[Flutter使用Provider进行状态管理](./flutter_web_demo_trip/lib/page/provider/multi/provider_example_multi_page1.dart)
