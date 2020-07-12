import 'package:flutter/material.dart';
import 'dart:async';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  int _countdownTime = 0;
  bool isSmsAvailable = false;
  Timer _timer;
  String _name, _phone, _password, _smsCode;
  bool _isObscure = true;
  Color _eyeColor;

  @override
  void initState() {
    super.initState();
  }

  String handleCodeAutoSizeText() {
    if (_countdownTime > 0) {
      return '$_countdownTime\s re-send';
    } else
      return 'Get SMS Code';
  }

  //倒计时方法
  startCountdown() {
    //倒计时时间
    _countdownTime = 60;
    final call = (timer) {
      if (_countdownTime < 1) {
        _timer.cancel();
      } else {
        setState(() {
          _countdownTime -= 1;
        });
      }
    };
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), call);
    }
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
          SizedBox(height: 70.0),
          buildNameTextFiled(),
          SizedBox(height: 30.0),
          buildPhoneTextField(),
          SizedBox(height: 30.0),
          buildSMSCodeTextField(),
          SizedBox(height: 30.0),
          buildPasswordTextField(context),
          SizedBox(height: 60.0),
          buildRegisterButton(context),
          SizedBox(height: 30.0),
          buildLoginText(context),
        ],
      ),
    ));
  }

  Center buildLogo() {
    return Center(
        child: Container(
            height: 200,
            width: 200,
            child: Image(image: AssetImage("assets/logo.png"))));
  }

  TextFormField buildNameTextFiled() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'User Name',
      ),
      onSaved: (String value) => _name = value,
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

  TextFormField buildSMSCodeTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'SMS Code',
        suffixIcon: buildSMSButton(),
      ),
      onSaved: (String value) => _smsCode = value,
    );
  }

  // 倒计时按钮
  FlatButton buildSMSButton() {
    return FlatButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      padding: EdgeInsets.only(right: 0),
      child: Text(handleCodeAutoSizeText(),
          style: TextStyle(
            color: ThemeData().primaryColor,
            fontSize: 17,
            fontFamily: 'Gotham',
          )),
      onPressed: () {
        if (_countdownTime == 0) {
          startCountdown();
        }
      },
    );
  }

  Align buildRegisterButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            'Register',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              //TODO 执行登录方法
              print(
                'phone:$_phone , password:$_password , name:$_name, ',
              );
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

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

  Align buildLoginText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Text(
                'Login',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
