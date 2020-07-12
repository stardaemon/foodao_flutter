import 'package:flutter/material.dart';
import './menu_screen.dart';
import './cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DishDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DishDetailState();
  }
}

class _DishDetailState extends State<DishDetailScreen> {
  String _first = '';
  String _second = '';
  String _tableNum = '';

  @override
  void initState() {
    super.initState();
    _getShared();
  }

  Future _getShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _first = prefs.get('methodFirst');
      _second = prefs.get('methodSecond');
      _tableNum = prefs.get('tableNum');
    });
  }

  String _displayedMethodFirst() {
    return this._first;
  }

  String _displayedMethodSecond() {
    return this._second;
  }

  String _tableNumber() {
    if (this._first != 'TAKE') return this._tableNum;
    return 'N/A';
  }

  String _amountMoney() {
    return "\$10";
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
                leading: Container(
                    height: 50,
                    width: 100,
                    child: ConstrainedBox(
                        constraints: BoxConstraints.expand(),
                        child: FlatButton(
                            child: Image.asset('assets/back.png'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuScreen()),
                              );
                            }))),
                backgroundColor: Colors.white,
                actions: <Widget>[
                  new Container(
                      width: 85,
                      height: 50,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              width: 100,
                              child: Text(
                                _displayedMethodFirst(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                softWrap: true,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xff000000),
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              width: 100,
                              child: Text(
                                _displayedMethodSecond(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                softWrap: true,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xff000000),
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ])),
                  new Container(
                    margin: EdgeInsets.only(right: 30),
                    child: Center(
                      child: new Text(
                        _tableNumber(),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xff000000),
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(30, 35, 30, 30),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xff000000), width: 2.0),
                        shape: BoxShape.circle),
                  ),
                ]),
            preferredSize: Size.fromHeight(70)),
        floatingActionButton: Container(
          width: double.infinity,
          height: 100,
          margin: EdgeInsets.fromLTRB(10, queryData.size.height * 0.9, 10, 0),
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/cart.png"), fit: BoxFit.fitWidth)),
          child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    queryData.size.width * 0.55, 50, 10, 20),
                child: Text(_amountMoney(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xffffffff),
                      fontFamily: 'Gotham',
                    )),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.cover)),
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: queryData.size.height * 0.5),
                child: null,
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      '\$10 ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Color(0xff000000),
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    child: Text(
                      '/each ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xff000000),
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  width: queryData.size.width * 0.9,
                  child: Text(
                    'addfs fgd sgdsg fd g dsh ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xff000000),
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w400),
                  )),
              InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: 70),
                    padding: EdgeInsets.fromLTRB(40.0, 35.0, 40.0, 15.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffC2A77D), width: 2.0),
                      borderRadius: new BorderRadius.circular(20.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Color(0xff000000),
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ))
            ])));
  }
}
