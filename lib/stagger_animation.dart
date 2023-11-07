import 'package:flutter/material.dart';

class StaggerAnimationWidget extends StatelessWidget {
  StaggerAnimationWidget({Key? key, required this.controller})
      : super(key: key) {
    height = Tween(begin: 0.0, end: 300.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0, 0.6, //间隔，前60%的动画时间
          curve: Curves.ease,
        )));
    padding = Tween(
            begin: const EdgeInsets.only(left: 0.0),
            end: const EdgeInsets.only(left: 100.0))
        .animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 1.0, //间隔，后40%的动画时间
                curve: Curves.ease)));
    color = ColorTween(begin: Colors.green, end: Colors.red).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0, 0.6, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  late final Animation<double> controller;
  late final Animation<double> height;
  late final Animation<EdgeInsets> padding;
  late final Animation<Color?> color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, child) {
          return Container(
              alignment: Alignment.bottomCenter,
              padding: padding.value,
              child: Container(
                color: color.value,
                width: 50,
                height: height.value,
              ));
        });
  }
}

class StaggerAnimationDemo extends StatefulWidget {
  const StaggerAnimationDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StaggerAnimationDemoState();
}

class _StaggerAnimationDemoState extends State<StaggerAnimationDemo>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
  }

  void _playAnimation() async {
    try {
      //先正向执行动画
      await controller.forward().orCancel;
      //再反向执行动画
      await controller.reverse().orCancel;
    } on TickerCanceled {
      //捕获异常。可能发生在组件销毁时，计时器会被取消。
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 120)),
          ElevatedButton(
            onPressed: () => _playAnimation(),
            child: const Text("start animation"),
          ),
          Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            //调用我们定义的交错动画Widget
            child: StaggerAnimationWidget(controller: controller),
          ),
        ],
      ),
    );
  }
}
