import 'package:flutter/material.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';


///封装滑动以及下标
class GuidePageViewIndicatorWidget extends StatefulWidget {
  final int pageCount;
  final double height;
  final List<Widget> children;
  final PageController pageViewController;

  const GuidePageViewIndicatorWidget(
      {Key key,
      @required this.pageCount,
      this.height,
      @required this.children,
      this.pageViewController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GuidePageViewIndicatorWidgetState();
  }
}

class GuidePageViewIndicatorWidgetState
    extends State<GuidePageViewIndicatorWidget> {
  GlobalKey _key = GlobalKey();

  double _pageViewIndicatorPosition = 0.0;

  double get _width {
    return Utils.getScreenWidth(context) - Config.horizontalPadding;
  }

  @override
  void initState() {
    super.initState();
    widget.pageViewController.addListener(syncIndicatorPosition);
  }

  void syncIndicatorPosition() {
    setState(() {
      _pageViewIndicatorPosition =
          widget.pageViewController.page * _width / widget.pageCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: _key,
      children: <Widget>[
        Container(
          constraints: BoxConstraints.tightFor(height: widget.height),
          child: PageView(
            controller: widget.pageViewController,
            children: widget.children,
          ),
        ),
        widget.pageCount > 1
            ? Stack(
                children: <Widget>[
                  Container(
                    height: 2,
                    color: Color.fromARGB(255, 230, 230, 230),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: _pageViewIndicatorPosition),
                      color: Colors.red,
                      height: 2,
                      width: _width / widget.pageCount)
                ],
              )
            : Utils.getEmptyContainer()
      ],
    );
  }
}
