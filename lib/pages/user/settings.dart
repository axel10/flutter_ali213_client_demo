import 'package:flutter/material.dart';
import 'package:youxia/model/user.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class SettingsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SettingsWidgetState();
  }
}

class SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
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

    return new Scaffold(
      appBar: Utils.createYXAppBar(title: '设置'),
      body: createSection(
          child: createRow(
              child: new Row(
                children: <Widget>[
                  new Text(
                    '退出登录',
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              onTap: handleLogout)),
    );
  }

  handleLogout() async {
    if (await showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: Text('是否退出登录？'),
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text('是'),
                  ),
                  new SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('否'),
                  )
                ],
              )
            ],
          );
        })) {
      var model = UserModel.of(context);
      Utils.setLocalStorage(Config.USER_TOKEN_KEY, null);
      model.setToken(null);
      model.setUserInfo(Utils.getDefaultUser());
    }
  }
}
