import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/main/model/news.dart';
import 'package:youxia/pages/main/components/tab.dart';
import 'package:youxia/pages/main/types/category.dart';
import 'package:youxia/service/mainService.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsPageState();
  }
}

class NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;


  @override
  void initState() {
    super.initState();
    var model = NewsModel.of(context);
    //获取新闻栏目数据
    MainService.getCategorys().then((categorys){
      model.setCategorys(categorys);
//      List<Category> categorys = model.categorys;
      MainService.getNewsData(nid: categorys[0].id).then((d) {
        model.setItems(categorys[0].id, d.list, d.flash);
      });
      //初始化tab
      _tabController = new TabController(length: categorys.length, vsync: this);
      _tabController.addListener(() {
        var currentCategory = categorys[_tabController.index];
        if (model.categoryData[currentCategory.id] == null) {
          MainService.getNewsData(nid: currentCategory.id).then((d) {
            model.setItems(currentCategory.id, d.list, d.flash);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (ctx,child,NewsModel model){
        List<Category> categorys = model.categorys;
        return _tabController==null?new Scaffold():new Material(
          child: SafeArea(
            child: new Column(
              children: <Widget>[
                new TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    tabs: categorys.map((e) {
                      return Tab(
                        child: Text(
                          e.name,
//                        'kak',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList()),
                new Container(
                  child: Expanded(
                      child: TabBarView(
                          controller: _tabController,
                          children: categorys.map((e) {
                            return NewsTab(e.id);
                          }).toList())),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
