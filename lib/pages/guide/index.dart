import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/components/loadMore.dart';
import 'package:youxia/pages/guide/components/ImgListItem.dart';
import 'package:youxia/pages/guide/components/searchInput.dart';
import 'package:youxia/pages/guide/model/guide.dart';
import 'package:youxia/pages/guide/pages/guideSubject/index.dart';
import 'package:youxia/pages/search/guideSubjectSearch.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class GuidePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GuidePageState();
  }
}

class GuidePageState extends State<GuidePage> {
  int _orderBy = 1;
  bool _loading = false;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();

    fetchData();
    //滚动到底部自动加载新数据
    Utils.addInfinityLoadListener(
        _scrollController, fetchData, LoadMore.height);
  }

  void fetchData() {
    if(_loading){
      return;
    }
    setState(() {
      _loading = true;
    });
    var model = GuideModel.of(context);
    MainService.getGuides(
            orderBy: _orderBy, addtime: model.getGuideListLastAddTime())
        .then((items) {
      model.addGuideList(items);
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (ctx, child, GuideModel model) {
        var guideList = model.guideList;
        return Scaffold(
          body: SafeArea(
              child: Column(
            children: <Widget>[
              //顶部搜索栏
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey))),
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.horizontalPadding, vertical: 12),
                  child: SearchInputWidget(
                    leftArea: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 18,
                    ),
                    border: Border.all(width: 1, color: Colors.grey),
                    enabled: false,
                    hintText: '',

                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(Utils.getRouter(builder: (ctx) {
                    print('tap');
                    return GuideSearchPage();
                  }));
                },
              ),
              //下拉列表行
              Container(
                height: 50,
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: Config.horizontalPadding, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: _orderBy,
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                  child: Text('按热门'),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text('按时间'),
                                  value: 0,
                                ),
                              ],
                              onChanged: handleTypeChange)),
                    )
                  ],
                ),
              ),
              //列表主体
              Expanded(
                child: GridView.count(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.horizontalPadding),
                  shrinkWrap: true,
                  childAspectRatio: 1 / 1.35,
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: guideList.map((item) {
                    return ImgListItem(
                      title: item.title,
                      imgUrl: item.img,
                      id: item.id,
                      onTap: (id) {
                        Navigator.of(context)
                            .push( Utils.getRouter(builder: (ctx) {
                          return GuideSubjectPage(id);
                        }));
                      },
                    );
                  }).toList(),
                ),
              )
            ],
          )),
        );
      },
    );
  }

  void handleTypeChange(int type) {
    this._orderBy = type;
    MainService.getGuides(orderBy: type, addtime: '').then((items) {
      GuideModel.of(context).setGuideList(items);
    });
  }
}
