import 'package:flutter/material.dart';

///线性缩放大小
class ScaleAnimationDemo1 extends StatefulWidget {
  const ScaleAnimationDemo1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaleAnimationDemoState1();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationDemoState1 extends State<ScaleAnimationDemo1>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //没有指定Curve，过程是线性的，从100变到300
    animation = Tween(begin: 100.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 120)),
        TextButton(
          child: const Text(
            '线性缩放大小',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () => setState(() {
            //重置动画
            controller.reset();
            //启动动画(正向执行)
            controller.forward();
          }),
        ),
        Icon(Icons.access_alarm, size: animation.value)
      ],
    );
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

///弹簧效果Curve缩放大小
class ScaleAnimationDemo2 extends StatefulWidget {
  const ScaleAnimationDemo2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaleAnimationDemoState2();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationDemoState2 extends State<ScaleAnimationDemo2>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //指定弹簧效果Curve
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    animation = Tween(begin: 100.0, end: 300.0).animate(animation)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 120)),
        TextButton(
          child: const Text(
            '弹簧效果Curve缩放大小',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () => setState(() {
            //重置动画
            controller.reset();
            //启动动画(正向执行)
            controller.forward();
          }),
        ),
        Icon(Icons.access_alarm, size: animation.value)
      ],
    );
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

///AnimatedWidget类封装了调用setState()的细节，并允许将 widget 分离出来
///利用 AnimatedWidget 创建一个可以重复使用运行动画的widget。
class ScaleAnimationWidget extends AnimatedWidget {
  const ScaleAnimationWidget({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Icon(Icons.access_alarm, size: animation.value);
  }
}

class ScaleAnimationDemo3 extends StatefulWidget {
  const ScaleAnimationDemo3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaleAnimationDemoState3();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationDemoState3 extends State<ScaleAnimationDemo3>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //指定弹簧效果Curve
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    animation = Tween(begin: 100.0, end: 300.0).animate(animation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 120)),
        TextButton(
          child: const Text(
            '弹簧效果Curve缩放大小',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () => setState(() {
            //重置动画
            controller.reset();
            //启动动画(正向执行)
            controller.forward();
          }),
        ),
        ScaleAnimationWidget(animation: animation)
      ],
    );
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

///动画状态监听
class ScaleAnimationDemo4 extends StatefulWidget {
  const ScaleAnimationDemo4({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaleAnimationDemoState4();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationDemoState4 extends State<ScaleAnimationDemo4>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 100.0, end: 300.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 120)),
        TextButton(
          child: const Text(
            '缩放大小',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () => setState(() {
            //启动动画(正向执行)
            controller.forward();
          }),
        ),
        ScaleAnimationWidget(animation: animation)
      ],
    );
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

///使用AnimatedBuilder重构
class ScaleAnimationDemo5 extends StatefulWidget {
  const ScaleAnimationDemo5({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaleAnimationDemoState5();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationDemoState5 extends State<ScaleAnimationDemo5>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 100.0, end: 300.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 120)),
        TextButton(
          child: const Text(
            '缩放大小',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () => setState(() {
            //重置动画
            controller.reset();
            //启动动画(正向执行)
            controller.forward();
          }),
        ),
        AnimatedBuilder(
          animation: animation,
          builder: (BuildContext ctx, child) {
            return Icon(Icons.access_alarm, size: animation.value);
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

///复合补间动画
class ScaleAnimationDemo6 extends StatefulWidget {
  const ScaleAnimationDemo6({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaleAnimationDemoState6();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationDemoState6 extends State<ScaleAnimationDemo6>
    with SingleTickerProviderStateMixin {
  late Tween<double> sizeTween;
  late Tween<double> opacityTween;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    sizeTween = Tween(begin: 100.0, end: 300.0);
    opacityTween = Tween(begin: 0.1, end: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 120)),
        TextButton(
          child: const Text(
            '缩放大小同时透明度增加',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () => setState(() {
            //重置动画
            controller.reset();
            //启动动画(正向执行)
            controller.forward();
          }),
        ),
        AnimatedBuilder(
          animation: controller,
          builder: (BuildContext ctx, child) {
            return Opacity(
              opacity: opacityTween.evaluate(controller),
              child: Icon(Icons.access_alarm,
                  size: sizeTween.evaluate(controller)),
            );
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
