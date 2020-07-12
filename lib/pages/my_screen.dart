import 'package:flutter/material.dart';
import './register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final _formKey = GlobalKey<FormState>();
  String _phone, _password;
  bool _isObscure = true;
  Color _eyeColor;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  Future _isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 22.0),
        children: <Widget>[
          SizedBox(
            height: kToolbarHeight,
          ),
          buildLogo(),
          //buildTitle(),
          //buildTitleLine(),
          SizedBox(height: 70.0),
          buildPhoneTextField(),
          SizedBox(height: 30.0),
          buildPasswordTextField(context),
          //buildForgetPasswordText(context),
          SizedBox(height: 60.0),
          buildLoginButton(context),
          SizedBox(height: 30.0),
          //buildOtherLoginText(),
          //buildOtherMethod(context),
          buildRegisterText(context),
        ],
      ),
    ));
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Don\'t have an account?'),
            GestureDetector(
              child: Text(
                ' Register here',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                //TODO 跳转到注册页面
                print('去注册');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ButtonBar buildOtherMethod(BuildContext context) {
  //   return ButtonBar(
  //     alignment: MainAxisAlignment.center,
  //     children: _loginMethod
  //         .map((item) => Builder(
  //               builder: (context) {
  //                 return IconButton(
  //                     icon: Icon(item['icon'],
  //                         color: Theme.of(context).iconTheme.color),
  //                     onPressed: () {
  //                       //TODO : 第三方登录方法
  //                       Scaffold.of(context).showSnackBar(new SnackBar(
  //                         content: new Text("${item['title']}登录"),
  //                         action: new SnackBarAction(
  //                           label: "取消",
  //                           onPressed: () {},
  //                         ),
  //                       ));
  //                     });
  //               },
  //             ))
  //         .toList(),
  //   );
  // }

  // Align buildOtherLoginText() {
  //   return Align(
  //       alignment: Alignment.center,
  //       child: Text(
  //         '其他账号登录',
  //         style: TextStyle(color: Colors.grey, fontSize: 14.0),
  //       ));
  // }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            'Login',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              //TODO 执行登录方法
              print('phone:$_phone , password:$_password');
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  // Padding buildForgetPasswordText(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8.0),
  //     child: Align(
  //       alignment: Alignment.centerRight,
  //       child: FlatButton(
  //         child: Text(
  //           '忘记密码？',
  //           style: TextStyle(fontSize: 14.0, color: Colors.grey),
  //         ),
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //       ),
  //     ),
  //   );
  // }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Plwase input the password';
        }
      },
      decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField buildPhoneTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Phone Number',
      ),
      validator: (String value) {
        // var emailReg = RegExp(
        //     r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        // if (!emailReg.hasMatch(value)) {
        //   return '请输入正确的邮箱地址';
        // }
      },
      onSaved: (String value) => _phone = value,
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  Center buildLogo() {
    return Center(
        child: Container(
            height: 200,
            width: 200,
            child: Image(image: AssetImage("assets/logo.png"))));
  }
}
