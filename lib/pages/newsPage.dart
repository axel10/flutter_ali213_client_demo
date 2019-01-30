


import 'package:flutter/material.dart';
import 'package:youxia/pages/main/tabs/news.dart';

class NewsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewsPageState();
  }
}

class NewsPageState extends State<NewsPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
        length: 2,
        child: new Material(
            child: SafeArea(
              child: new Column(
                children: <Widget>[
                  new TabBar(
                    isScrollable: true,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          '头条',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          '头条',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    child: Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            NewsTab(),
                            Container(
                              color: Colors.red,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            )));
  }

}

