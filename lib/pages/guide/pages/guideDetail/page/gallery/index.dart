import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/guideImgItem.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/sectionContent.dart';
import 'package:youxia/pages/guide/pages/guideDetail/page/guideArticle/index.dart';
import 'package:youxia/pages/guide/types/GuideDetail.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class GalleryPage extends StatefulWidget {
  final GuideImgData data;

  const GalleryPage({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GalleryPageState(data);
  }
}

class GalleryPageState extends State<GalleryPage>
    with TickerProviderStateMixin {
  final GuideImgData data;

  GalleryPageState(this.data);

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: data.mkdata.length);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.createYXAppBar(),
      body: Column(
        children: <Widget>[
          SectionContentTitle(title: data.mkname,),
          Theme(
            data: ThemeData(splashColor: Colors.transparent),
            child: TabBar(
              indicator: BubbleTabIndicator(
                  indicatorColor: Colors.red
              ),
//            indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              isScrollable: true,
              controller: _tabController,
              tabs: data.mkdata.map((group) {
                return Tab(
                  child: Text(
                    group.title,
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
              child: TabBarView(
                controller: _tabController,
                children: data.mkdata.map((group) {
                  return GridView.count(
                    childAspectRatio: 2/1.5,
                    crossAxisSpacing: 5,
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.horizontalPadding),
                    children: group.children.map((item) {
                      return GuideImgItemWidget(
                        height: 90,
                        id: item.id,
                        title: item.title,
                        imgUrl: item.pic,
                        onTap: (){
                          Navigator.of(context).push(Utils.getRouter(builder: (ctx){
                            return GuideArticlePage(articleId: item.id,);
                          }));
                        },
                      );
                    }).toList(),
                  );
                }).toList(),
              )),
        ],
      )
    );
  }
}
