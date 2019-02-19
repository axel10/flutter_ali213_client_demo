import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/main/model/news.dart';
import 'package:youxia/pages/main/types/newsItem.dart';
import 'package:youxia/utils/utils.dart';

class MainSwiper extends StatefulWidget {
  MainSwiper(this._key);

  final String _key;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainSwiperState(_key);
  }
}

class MainSwiperState extends State<MainSwiper> {
  MainSwiperState(this._key);

  String _key;

  PageController _pageController;

  int _currentIndex = 0;
  double _contentHeight = 180;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant(
      builder: (context, child, NewsModel model) {
        List<Flash> list = model.categoryData[_key] == null
            ? []
            : model.categoryData[_key].flashList;
        return list.length > 0
            ? new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Container(
                    height: _contentHeight,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: <Widget>[
                        new PageView(
                          controller: _pageController,
                          children: list.map((o) {
                            return new Container(
                              child: Utils.getCacheImage(
                                imageUrl: o.pic.isEmpty
                                    ? 'http://via.placeholder.com/350x150'
                                    : o.pic,
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                        ),
                        new Container(
                          height: 20,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          color: Color.fromARGB(140, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 260,
                                child: Text(
                                  list.length > 0
                                      ? list[_currentIndex].title
                                      : '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: list.map((o) {
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Material(
                                        type: MaterialType.circle,
                                        color: list.indexOf(o) == _currentIndex
                                            ? Colors.white
                                            : Colors.grey,
                                        child: Container(
                                          width: 6,
                                          height: 6,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              )
            : new Container(
                height: 0,
              );
      },
    );
  }
}
