import 'package:flutter/material.dart';
import './menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List _selectedDished = List();
  String _first = '';
  String _second = '';
  String _tableNum = '';

  @override
  void initState() {
    super.initState();
    _selectedDished = [0, 1];
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

    Widget _dishDivider = Divider(
      color: Colors.black,
    );

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
                    image: AssetImage("assets/cart.png"),
                    fit: BoxFit.fitWidth)),
            child: Container(
              margin:
                  EdgeInsets.fromLTRB(queryData.size.width * 0.45, 50, 10, 20),
              child: Text(_amountMoney(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xffffffff),
                    fontFamily: 'Gotham',
                  )),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(10),
                  child: ListView.separated(
                      physics: new NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(children: <Widget>[
                          InkWell(
                              onTap: () {},
                              child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 50,
                                  width: 50,
                                  child: Icon(Icons.remove))),
                          Container(
                              height: 75,
                              width: 75,
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Image(
                                  image: AssetImage("assets/logo.png"),
                                  fit: BoxFit.fill)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[
                                Container(
                                    height: 30,
                                    margin: EdgeInsets.only(top: 20),
                                    child: Text("11111",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xff000000),
                                          fontFamily: 'Gotham',
                                        ))),
                                Container(
                                    height: 25,
                                    margin: EdgeInsets.fromLTRB(
                                        queryData.size.width * 0.2, 40, 30, 20),
                                    child: Text("\$10",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000),
                                          fontFamily: 'Gotham',
                                        ))),
                              ]),
                              Container(
                                height: 20,
                                child: Text("x1",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xff000000),
                                      fontFamily: 'Gotham',
                                    )),
                              )
                            ],
                          ),
                          InkWell(
                              onTap: () {},
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Icon(Icons.add))),
                        ]);
                      },
                      separatorBuilder: (context, child) {
                        return _dishDivider;
                      },
                      itemCount: this._selectedDished.length)),
              Divider(color: Colors.black),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(queryData.size.width * 0.1, 20,
                        queryData.size.width * 0.5, 20),
                    child: Text(
                      "TOTAL",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xff000000),
                        fontFamily: 'Gotham',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      "\$40",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xff000000),
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black),
            ]));
  }
}
