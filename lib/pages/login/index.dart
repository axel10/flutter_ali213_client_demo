import 'package:flutter/material.dart';
import 'package:youxia/model/user.dart';
import 'package:youxia/service/userService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginWidgetState();
  }
}

class LoginWidgetState extends State<LoginWidget> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    Widget createRow({@required Widget child}) => new Container(
          padding: EdgeInsets.only(top: 15),
          child: child,
        );

    return new Scaffold(
      appBar: Utils.createYXAppBar(),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(15),
            child: new Column(
              children: <Widget>[
                new Container(
                  // logo
                  height: 100,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Image.asset('assets/logo.png')],
                  ),
                ),
                createRow(
                    child: new Form(
                  key: _formKey,
                  child: new Column(
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: '用户名',
                        ),
                        onSaved: (val) {
                          _username = val;
                        },
                        validator: (val) => val.isEmpty ? '用户名不能为空' : null,
                      ),
                      new TextFormField(
                        obscureText: true,
                        decoration: new InputDecoration(
                          labelText: '密码',
                        ),
                        onSaved: (val) {
                          _password = val;
                        },
                        validator: (val) => val.isEmpty ? '密码不能为空' : null,
                      ),
                    ],
                  ),
                )),
                createRow(
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: _submit,
                          child: new Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4)),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  '登陆',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _submit() async {
    var _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      var json =
          await UserService.login(username: _username, password: _password);
      // 如果成功
      if (json.status == 1) {
        var model = UserModel.of(context);
        var userInfo = json.data.userinfo;
//        model.setLoginUserInfo(userInfo);
        //存储token到模型
        model.setToken(json.data.token);
        //存储头像到模型
        model.setAvatar(userInfo.avatar);
        var prefs = await SharedPreferences.getInstance();
        //存储token到本地
        prefs.setString(Config.USER_TOKEN_KEY, json.data.token);
        //存储头像到本地
        prefs.setString(Config.USER_AVATAR_KEY, userInfo.avatar);
        Fluttertoast.showToast(
            msg: '登陆成功',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: json.msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    }
  }
}
