import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youxia/pages/guide/pages/guideSubject/components/guideImgItem.dart';
import 'package:youxia/pages/guide/pages/guideSubject/components/sectionContent.dart';
import 'package:youxia/pages/guide/pages/guideSubject/page/guideArticle/index.dart';
import 'package:youxia/pages/guide/types/GuideDetail.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class IllustrationPage extends StatefulWidget {
  final GuideSection data;

  const IllustrationPage({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return IllustrationPageState(data);
  }
}

class IllustrationPageState extends State<IllustrationPage> {
  final GuideSection data;

  IllustrationPageState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.createYXAppBar(),
      body: Column(
        children: <Widget>[
          SectionContentTitle(
            title: data.mkname,
            margin: EdgeInsets.only(bottom: 10),
          ),
          Expanded(
            child: GridView.count(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.horizontalPadding),
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2/1.4,
              children: data.mkdata.map((item) {
                return GuideImgItemWidget(
                  title: item.title,
                  imgUrl: item.pic,
                  id: item.id,
                  maskColor: Color.fromARGB(80, 0, 0, 0),
                  onTap: (){
                    Navigator.of(context).push(Utils.getRouter(builder: (ctx){
                      return GuideArticlePage(articleId: item.id,);
                    }));
                  },
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
