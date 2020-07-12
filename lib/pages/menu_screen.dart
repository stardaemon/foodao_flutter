import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../home_widget.dart';
import 'dart:convert';
import '../model/category_model.dart';
import './dish_detail_screen.dart';
import './cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuState();
  }
}

class _MenuState extends State<MenuScreen> {
  List _categories = List();
  List _selectedDishes = List();
  CategoryModel _selectedCategory;
  String _first = '';
  String _second = '';
  String _tableNum = '';

  @override
  void initState() {
    super.initState();
    _getCategories();
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

  // get all categories
  Future _getCategories() async {
    try {
      Response response = await Dio().get(
          "http://54.206.50.228:3000/api/genres",
          options: Options(responseType: ResponseType.plain));
      var categoryList = json.decode(response.data.toString());
      var resCategory = getCategoryModelList(categoryList);
      setState(() {
        _categories = resCategory;
        _selectedCategory = resCategory[0];
        // TODO
        _selectedDishes = [0];
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('categoryJson', response.data.toString());
    } catch (e) {
      print(e);
    }
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

  String _categoryName(String name) {
    var splitArray = name.toString().split(' ');
    if (splitArray.length == 1) {
      return ' ';
    }

    if (splitArray.length == 2) {
      return splitArray[1];
    }

    if (splitArray.length == 3) {
      return splitArray[1] + ' ' + splitArray[2];
    }

    if (splitArray.length == 4) {
      return splitArray[1] + ' ' + splitArray[2] + ' ' + splitArray[3];
    }

    return name;
  }

  String _selectedCategoryName() {
    if (this._selectedCategory != null) return this._selectedCategory.name;

    if (this._categories.length > 0) return this._categories[0].name;

    return '';
  }

  int _sectionColor(CategoryModel category) {
    if (this._selectedCategory == category) {
      return 0xffffffff;
    }

    return 0xffd3d3d3;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    // used to seperate each category
    Widget _categoryDivider = Divider(
      color: Colors.white,
    );

    // used to seperate each dish
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
                              MaterialPageRoute(builder: (context) => Home()),
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
                      border: Border.all(color: Color(0xff000000), width: 2.0),
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
              margin:
                  EdgeInsets.fromLTRB(queryData.size.width * 0.55, 50, 10, 20),
              child: Text(_amountMoney(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xffffffff),
                    fontFamily: 'Gotham',
                  )),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              height: 140,
              width: double.infinity,
              child: Image(
                image: AssetImage("assets/menuBar.png"),
                fit: BoxFit.fill,
              )),
          Expanded(
            child: Row(
              verticalDirection: VerticalDirection.down,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.topCenter,
                        height: queryData.size.height - 350,
                        color: Color(0xffd0d0d0),
                        child: ListView.separated(
                          itemCount: this._categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    this._selectedCategory =
                                        this._categories[index];
                                  });
                                },
                                child: Container(
                                  decoration: new BoxDecoration(
                                      color: Color(_sectionColor(
                                          this._categories[index]))),
                                  child: ListTile(
                                    title: Text(
                                      this._categories[index] != null
                                          ? this
                                              ._categories[index]
                                              .name
                                              .toString()
                                              .split(' ')[0]
                                          : null,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff000000),
                                        fontFamily: 'Gotham',
                                      ),
                                    ),
                                    subtitle: Text(
                                        _categoryName(
                                            this._categories[index] != null
                                                ? this
                                                    ._categories[index]
                                                    .name
                                                    .toString()
                                                : null),
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Color(0xff000000),
                                          fontFamily: 'Gotham',
                                        )),
                                  ),
                                ));
                          },
                          separatorBuilder: (context, index) {
                            return _categoryDivider;
                          },
                        ))),
                Expanded(
                    flex: 5,
                    child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          new Container(
                              height: 20,
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: Text(_selectedCategoryName(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Color(0xff000000),
                                    fontFamily: 'Gotham',
                                  ))),
                          new Container(
                              child: ListView.separated(
                                  physics: new NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DishDetailScreen()),
                                          );
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                                height: 75,
                                                width: 75,
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 20, 10, 20),
                                                child: Image(
                                                    image: AssetImage(
                                                        "assets/logo.png"),
                                                    fit: BoxFit.fill)),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                      height: 25,
                                                      margin: EdgeInsets.only(
                                                          top: 20),
                                                      child: Text("11111",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                'Gotham',
                                                          ))),
                                                  Container(
                                                      height: 15,
                                                      child: Text(
                                                          "222222222222222222222222",
                                                          overflow:
                                                              TextOverflow.clip,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                'Gotham',
                                                          ))),
                                                  Container(
                                                      height: 15,
                                                      child: Text(
                                                          "22222222222222222222222",
                                                          overflow:
                                                              TextOverflow.clip,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                'Gotham',
                                                          ))),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                          child: Text("\$10",
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff8b1a1a),
                                                                fontFamily:
                                                                    'Gotham',
                                                              ))),
                                                      Container(
                                                          width: queryData.size
                                                                      .width *
                                                                  5 /
                                                                  7 -
                                                              95 -
                                                              110),
                                                      Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: FlatButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          0),
                                                              onPressed: () {},
                                                              child: Image.asset(
                                                                  'assets/add.png')))
                                                    ],
                                                  )
                                                ])
                                          ],
                                        ));
                                  },
                                  separatorBuilder: (context, index) {
                                    return _dishDivider;
                                  },
                                  itemCount: 7)),
                          new Container(
                            height: 100,
                          )
                        ]))
              ],
            ),
          )
        ],
      ),
    );
  }
}
