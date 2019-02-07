import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/components/YXButton.dart';
import 'package:youxia/model/user.dart';
import 'package:youxia/pages/login/index.dart';
import 'package:youxia/pages/user/collection/index.dart';
import 'package:youxia/pages/user/settings.dart';
import 'package:youxia/service/userService.dart';
import 'package:youxia/type/UserInfo.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserPageState();
  }
}

class UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    /// 水平填充

    Widget createCategoryIcon(
        {@required Icon icon,
        @required String label,
        @required WidgetBuilder toPage}) {
      return new InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: toPage));
        },
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 40,
              height: 40,
              child: icon,
              padding: EdgeInsets.only(bottom: 10),
            ),
            new Text(label)
          ],
        ),
      );
    }

    Widget createSection({@required Widget child}) {
      return new Container(
        child: child,
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 5),
      );
    }

    /// 创建第三大行内的小行
    Widget createRow(
        {@required Widget child, @required GestureTapCallback onTap}) {
      return new InkWell(
        child: new Container(
          padding: EdgeInsets.symmetric(horizontal: Config.horizontalPadding),
          child: child,
        ),
        onTap: onTap,
      );
    }

//    var model = UserModel.of(context);
    return new ScopedModelDescendant(
      builder: (ctx, child, UserModel model) {
        UserInfo userData = model.userInfo??Utils.getDefaultUser();
        return new Scaffold(
          body: SafeArea(
              child: new Container(
            color: Color.fromARGB(255, 230, 230, 230),
            child: new Column(
              children: <Widget>[
                // 第一行 用户头像等
                createSection(
                  child: new Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: 30, horizontal: Config.horizontalPadding),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new InkWell(
                          // 用户名以及用户头像
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: model.avatar != null
                                    ? Image.network(
                                        model.avatar,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/user_default_header.png'),
                                margin: EdgeInsets.only(right: 10),
                              ),
                              Text(
                                userData.username,
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                ctx,
                                MaterialPageRoute(
                                    builder: (ctx) => new LoginWidget()));
                          },
                        ),
                        new YXButton(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: new Row(
                            children: <Widget>[
                              Icon(Icons.date_range),
                              Text('签到')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // 第二行 栏目图标
                createSection(
                    child: new Container(
                  padding: EdgeInsets.all(20),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      createCategoryIcon(
                          toPage: (ctx) => ArticleCollection(),
                          icon: Icon(
                            Icons.star,
                            color: Colors.redAccent,
                          ),
                          label: '收藏'),
                    ],
                  ),
                )),
                createSection(
                    child: createRow(
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.settings,
                              color: Colors.grey,
                              size: 16,
                            ),
                            new Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('设置'),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              ctx,
                              MaterialPageRoute(
                                  builder: (ctx) => new SettingsWidget()));
                        })),
                new Expanded(
                  child: new Container(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    var model = UserModel.of(context);
/*    UserService.getUserInfo().then((user) {
      if (user != null) {
        model.setUserInfo(user);
      }
    });
    Utils.getLocalStorage(Config.USER_AVATAR_KEY).then((avatar) {
      model.setAvatar(avatar);
    });
    Utils.getLocalStorage(Config.USER_TOKEN_KEY);*/
    Future.wait([Utils.getLocalStorage(Config.USER_AVATAR_KEY),Utils.getLocalStorage(Config.USER_TOKEN_KEY)]).then((List results){
      var avatar = results[0];
      var token = results[1];
      if (token != null) {
        model.setAvatar(avatar);
        model.setToken(token);
      }
    });
  }
}
