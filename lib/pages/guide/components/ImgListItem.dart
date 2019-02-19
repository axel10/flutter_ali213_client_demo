import 'package:flutter/material.dart';
import 'package:youxia/utils/utils.dart';

class ImgListItem extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String id;
  final double width;
  final double height;
  final void Function(String id) onTap;

  ImgListItem(
      {@required this.imgUrl,
      @required this.title,
      @required this.id,
      this.width,
      this.height, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        onTap(id);
        /* () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return GuideDetailPage(id);
        }));
      }*/
      },
      child: Container(
        height: height,
        width: width,
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            Utils.getCacheImage(imageUrl: imgUrl,fit: BoxFit.fill),
            Row(
              children: <Widget>[Expanded(
                child: Container(
                  color: Color.fromARGB(80, 0, 0, 0),
                  height: 30,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )],
            )
          ],
        ),
      ),
    );
  }
}
