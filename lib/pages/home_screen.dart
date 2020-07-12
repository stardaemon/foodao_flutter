import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    getShared();
  }

  Future getShared() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  // 展示桌号输入弹窗
  void _dineIn() {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          titlePadding: EdgeInsets.fromLTRB(0, 40.0, 0, 30.0),
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 20.0),
          title: Text(
            'INPUT TABLE NUMBER',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                color: Color(0xff000000),
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w300),
          ),
          children: <Widget>[
            new SimpleDialogOption(
              child: TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 27.0,
                    color: Color(0xff000000),
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w700),
                onChanged: _inputNumber,
                keyboardType: TextInputType.number,
                cursorWidth: 4.0,
                maxLength: 4,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new SimpleDialogOption(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 15.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffC2A77D), width: 2.0),
                  borderRadius: new BorderRadius.circular(20.0),
                  shape: BoxShape.rectangle,
                ),
                child: Text(
                  'CONFIRM',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xff000000),
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () {
                this.prefs.setString('methodFirst', 'TABLE');
                this.prefs.setString('methodSecond', 'NUMBER');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuScreen(),
                  ),
                );
              },
            ),
            new SimpleDialogOption(
              child: Container(
                // margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 15.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffC2A77D), width: 2.0),
                  borderRadius: new BorderRadius.circular(20.0),
                  shape: BoxShape.rectangle,
                ),
                child: Text(
                  'BACK',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xff000000),
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

  void _takeAway() {
    this.prefs.setString('methodFirst', 'TAKE');
    this.prefs.setString('methodSecond', 'AWAY');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuScreen(),
      ),
    );
  }

  void _inputNumber(String tableNumber) {
    this.prefs.setString('tableNum', tableNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.cover)),
            child: Column(children: <Widget>[
              //Container(height: 50),
              Container(
                  height: 172,
                  width: 142,
                  margin: EdgeInsets.only(top: 170),
                  child: Image(
                      image: AssetImage("assets/logo.png"), fit: BoxFit.fill)),
              Container(
                  height: 20,
                  width: 300,
                  margin: EdgeInsets.only(top: 170),
                  child: Text(
                    "Let's help you discover",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xffC2A77D),
                      fontFamily: 'Gotham',
                    ),
                  )),
              Container(
                  height: 50,
                  width: 200,
                  child: Text(
                    "something to order",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xffC2A77D),
                      fontFamily: 'Gotham',
                    ),
                  )),
              Row(
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 200,
                      margin: EdgeInsets.only(top: 30),
                      child: ConstrainedBox(
                          constraints: BoxConstraints.expand(),
                          child: FlatButton(
                              onPressed: _dineIn,
                              padding: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                              child: Image.asset('assets/dineIn.png')))),
                  Container(
                    height: 100,
                    width: 200,
                    margin: EdgeInsets.only(top: 30),
                    child: ConstrainedBox(
                        constraints: BoxConstraints.expand(),
                        child: FlatButton(
                            onPressed: _takeAway,
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
                            child: Image.asset('assets/takeAway.png'))),
                  )
                ],
              )
            ])));
  }
}
