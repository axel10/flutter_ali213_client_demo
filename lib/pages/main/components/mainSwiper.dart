

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MainSwiper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        new Expanded(
            child: new Container(
              height: 200,
              child: new Swiper(
                control: new SwiperControl(),
                pagination: new SwiperPagination(),
                itemCount: 2,
                itemBuilder: (BuildContext ctx, int index) {
                  return new Image.network(
                    "http://via.placeholder.com/350x150",
                    fit: BoxFit.cover,
                  );
                },
              ),
            ))
      ],
    );
  }

}