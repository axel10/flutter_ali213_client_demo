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
    /// 创建第三大行内的小行
    return new Scaffold(
      appBar: Utils.createYXAppBar(title: '设置'),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: handleLogout,
                  child: new Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        '退出登录',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
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
                      Navigator.pop(ctx, true);
                    },
                    child: Text('是'),
                  ),
                  new SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(ctx, false);
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
      model.setLoginUserInfo(Utils.getDefaultLoginUserInfo());
    }
  }
}
