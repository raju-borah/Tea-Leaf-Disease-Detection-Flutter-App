import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final String str;
  final Animation<Color> valueColor;

  ProgressHUD({
    Key key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.valueColor,
    this.str="",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          // new Center(
          //   child: new CircularProgressIndicator()
          // ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: JumpingText('$str',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white
                  )),
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
