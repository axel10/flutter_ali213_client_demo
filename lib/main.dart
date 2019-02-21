import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:youxia/components/Stars.dart';
import 'package:youxia/model/ui.dart';
import 'package:youxia/model/user.dart';
import 'package:youxia/pages/guide/index.dart';
import 'package:youxia/pages/guide/model/guide.dart';
import 'package:youxia/pages/guide/pages/guideDetail/model/guideDetail.dart';
import 'package:youxia/pages/guide/pages/guideDetail/page/guideArticle/model/guideArticle.dart';
import 'package:youxia/pages/main/index.dart';
import 'package:youxia/pages/search/complexSearch.dart';
import 'package:youxia/pages/search/model/search.dart';
import 'package:youxia/pages/main/model/detail.dart';
import 'package:youxia/pages/main/model/news.dart';
import 'package:youxia/pages/user/index.dart';
import 'package:youxia/service/userService.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  int _currentIndex = 0;
  final key = GlobalKey();

  AnimationController _indexAnimationCtl;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 初始化登陆状态
    var model = UserModel.of(context);
    //从本地获取token并入userModel
    var token = Utils.getLocalStorage(Config.USER_TOKEN_KEY);
    if (token != null) {
      UserService.updateToken(oldToken: token).then((d) {
        model.setToken(d.token);
      }).catchError((e) {});
    }

    _indexAnimationCtl = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation = new Tween(begin: 50.0, end: 0.0).animate(_indexAnimationCtl);
    _animation.addListener(() {
      setState(() {});
    });
    _indexAnimationCtl.forward();

    var uiModel = UIModel.of(context);
    uiModel.setIndexScrollController(_indexAnimationCtl);
    uiModel.expandIndexAppbar();
  }

  @override
  void dispose() {
    super.dispose();
    _indexAnimationCtl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [NewsPage(), GuidePage(), UserPage()];
    var uiModel = UIModel.of(context);

    var navbar = BottomNavigationBar(
      fixedColor: Colors.red,
        key: key,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex != 0) {
              uiModel.foldIndexAppbar();
            } else {
              uiModel.expandIndexAppbar();
            }
          });
        },
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('首页')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.view_carousel), title: Text('攻略')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.headset), title: Text('我的'))
        ]);


    return new MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: SafeArea(
              child: Container(
            child: new Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                new Column(
                  children: <Widget>[
                    //顶部栏
                    new Container(
                      height: _animation.value,
//            padding: EdgeInsets.fromLTRB(12, 24, 12, 8),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: new Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '头条',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    '游戏库',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                            new Expanded(
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      onPressed: (){
                                        Navigator.of(context).push(Utils.getRouter(builder: (ctx){
                                          return ComplexSearchPage();
                                        }));
                                      },
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    //主体
                    new Expanded(
                      child: new Container(
//              height: height,
                        child: pages[_currentIndex],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
          bottomNavigationBar: navbar,
        ));
  }

}

//GuideDetailModel
//void main() => runApp(MyApp());
void main() async {
  await Utils.init();
//  GuideArticleModel
  return runApp(new ScopedModel(
      model: SearchModel(),
      child: ScopedModel(
          model: GuideArticleModel(),
          child: new ScopedModel(
              model: GuideDetailModel(),
              child: new ScopedModel(
                  model: new UIModel(),
                  child: new ScopedModel(
                      model: new NewsModel(),
                      child: ScopedModel(
                          model: new NewsDetailModel(),
                          child: new ScopedModel(
                            model: new UserModel(),
                            child: new ScopedModel(
                                model: GuideModel(),
                                child: MaterialApp(
                                  home: MyApp(),
                                )),
                          ))))))));
}
