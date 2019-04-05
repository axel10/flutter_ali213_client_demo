import 'package:flutter/material.dart';
import 'package:youxia/utils/utils.dart';

class GuideImgItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  final double width;
  final double height;
  final double maskHeight;
  final Color maskColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
//        margin: EdgeInsets.only(right: 10),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Row(children: <Widget>[Expanded(child: Utils.getCacheImage(imageUrl: imgUrl, fit: BoxFit.contain,width: width,height: height),)],),
            Container(
              child: Center(child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),),
              height: maskHeight,
              color: maskColor,
            )
          ],
        ),
      ),
    );
  }

  GuideImgItemWidget(
      {@required this.id,
       @required this.title,
       @required this.imgUrl,
       this.width,
       this.height,
       this.maskHeight=30,
       this.maskColor=Colors.transparent,
       this.onTap});
}
