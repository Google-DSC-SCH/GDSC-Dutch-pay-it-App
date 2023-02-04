import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dutch_pay_it/Screens/calculate.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Menu {
  String shop;
  String name;
  int count;
  int price;
  List<String> people;

  Menu({required this.shop, required this.name, required this.count, required this.price, required this.people});
}

Future<List<Menu>> fetchMenu() async {
  final response = await http.get(Uri.parse('https://d07f5c54-2324-4048-8b65-02874f67c035.mock.pstmn.io/allmenulist'));

  if (response.statusCode == 200) {
    final menus = json.decode(response.body);

    List<Menu> menuMap = [];
    for(var menu in menus) {
      menuMap.add(Menu(
        shop: menu['shop'],
        name: menu['name'],
        count: menu['count'],
        price: menu['price'],
        people: menu['people'],
      ));
    }

    // 이름 리스트 작업중
    /*final peoples = json.decode(response.body.people)

    List<String> peopleMap = [];
    return menuMap;*/
  }
  throw Exception('데이터 수신 실패!');
}

class MenuList extends StatefulWidget {
  MenuList({Key? key}) : super(key: key);

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text('정보 입력'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 5),
              Flexible(
                flex: 1,
                child: Text("식당이름",
                  style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),
              FutureBuilder(
                future: fetchMenu(),                           // User 배열 반환
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Menu>? MenuArray = snapshot.data;   // 정확한 형식으로 변환
                    return Flexible(
                        flex: 12,
                        child: ListView.builder(
                            itemCount: MenuArray?.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  elevation: 4.0,
                                  color: Color(0xffFFFFFF),
                                  margin: EdgeInsets.fromLTRB(20, 8, 20, 8),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(3, 5, 3, 5),
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 40,
                                                    child: Center(child: Text('품목'))),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height: 20,
                                                    width: 100,
                                                    child: Flexible(
                                                        child: Text(MenuArray![index].name)),
                                                  ),
                                                ),
                                                Container(
                                                    width: 40,
                                                    child: Center(child: Text('수량'))),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height: 20,
                                                    width: 100,
                                                    child: Flexible(
                                                        child: Text(MenuArray![index].count.toString())),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        Container(
                                            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                                            child: Row(
                                                children: [
                                                  Container(
                                                      width: 40,
                                                      child: Center(child: Text('가격'))),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      height: 20,
                                                      width: 100,
                                                      child: Flexible(
                                                          child: Text(MenuArray![index].price.toString())),
                                                    ),
                                                  ),
                                                ]
                                            )
                                        ),
                                        Container(
                                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 40,
                                                    child: const Center(child: Text('이름'))),
                                                Expanded(flex: 6,
                                                  child: Container(
                                                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                                      height: 20.0,
                                                      width:10,
                                                      child: Text("이름라벨") //: addnameLabel(),
                                                  ),
                                                ),
                                                // 구성원 추가 버튼
                                                Container(
                                                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                  width: 20,
                                                  height: 20,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        /*Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => addName(peoplelist:widget.peoplelist, count:count, nameLabel:nameLabel, namelist:namelist, selected:selected, addCount:addCount)),
                                                );*/
                                                      },
                                                      child: Center(child: Icon(Icons.add, size: 14, color: Colors.black,)),
                                                      style: ElevatedButton.styleFrom(
                                                        primary: Color(0xffEEEEEE),
                                                        padding: EdgeInsets.zero,
                                                        shadowColor: Colors.grey,// 버튼 여백 제거
                                                      )
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  )
                              );
                            }
                        )
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // 데이터를 로딩하는 동안 표시되는 인디케이터
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(height: 20),
              buttonBox(),
            ],
          ),
        )
    );
  }

 @override
 void debugFillProperties(DiagnosticPropertiesBuilder properties) {
   super.debugFillProperties(properties);
      //properties.add(DiagnosticsProperty('dropdownValue', dropdownValue));
 }

  // 수정해야함 (작업중)
  addnameLabel() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (c,i){
          return Container(
              margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
              width: 35,
              decoration: BoxDecoration(
                color: Color(0xff37b067),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                  child: Text(
                    '이름들어갈공간',
                    //'${count+1}',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  )
              )
          );
        }
    );
  }
}

class buttonBox extends StatelessWidget {
  buttonBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      width: double.infinity,
      height: 50,
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('수정하기', style: TextStyle(color: Colors.black),),
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(90, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Colors.grey.shade300
            ),
          ),
          ElevatedButton(
            child: Text("확인", ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Calculate()),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(90, 35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              primary: Colors.blueGrey
            ),
          ),
        ],
      ),
    );
  }
}


