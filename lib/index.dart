import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/model/user.dart';
import 'package:youxia/pages/main/index.dart';
import 'package:youxia/pages/main/model/detail.dart';
import 'package:youxia/pages/main/model/news.dart';
import 'package:youxia/pages/user/index.dart';
import 'package:youxia/service/userService.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // 初始化登陆状态
    var model = UserModel.of(context);
    Utils.getLocalStorage(Config.USER_TOKEN_KEY).then((token) {
      if (token != null) {
        UserService.updateToken(oldToken: token).then((d) {
          model.setToken(d.token);
          print('token更新成功 ' + d.token);
        });
        UserService.getUserInfo().then((d) {
          model.setUserInfo(d);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [NewsPage(), UserPage()];
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
/*            body:new NestedScrollView(headerSliverBuilder: (BuildContext ctx,bool innerBoxIsScrolled){
              return <Widget>[
                new SliverAppBar(
                  title: new Text('title'),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                )
              ];
            }, body: pages[_currentIndex])*/
          appBar: new AppBar(),
          body:pages[_currentIndex]
          /*Container(
            child: new Column(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        '头条',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('游戏库'),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[Icon(Icons.search,size: 16,)],
                      )
                    ],
                  ),
                ),
                new Expanded(child: new ListView(
                  shrinkWrap: true,
                  children: <Widget>[

                  ],
                ))
              ],
            ),
          )*/,
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              currentIndex: _currentIndex,
              items: [
                new BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Container(
                      height: 0,
                    )),
                new BottomNavigationBarItem(
                    icon: Icon(Icons.headset),
                    title: Container(
                      height: 0,
                    ))
              ]),
        ));
  }
}

//void main() => runApp(MyApp());
void main() {
  return runApp(new ScopedModel(
      model: new NewsModel(),
      child: ScopedModel(
          model: new NewsDetailModel(),
          child: new ScopedModel(
            model: new UserModel(),
            child: MyApp(),
          ))));
}
