import 'package:flutter/material.dart';

class ClickWidget extends StatelessWidget {

  /// 圆角大小
  final double radius;

  /// 点击事件回调
  final Function onClick;

  /// 子布局
  final Widget child;

  /// 阴影大小
  final double elevation;

  /// 背景色
  final Color backgroundColor;

  /// 点击按钮时的渐变背景色
  final Color splashColor;

  const ClickWidget({
    Key key,
    this.radius = 0.0,
    this.onClick,
    @required this.child,
    this.splashColor,
    this.elevation = 0.0,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget w = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Material(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        elevation: 0.0,
        child: InkWell(
          child: child,
          onTap: onClick,
        ),
      ),
    );

    if (this.splashColor != null) {
      return Theme(
        data: Theme.of(context).copyWith(splashColor: this.splashColor),
        child: w,
      );
    }

    return w;
  }
}