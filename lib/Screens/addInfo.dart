import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dutch_pay_it/Screens/calculate.dart';
import 'package:dutch_pay_it/Screens/addName.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Menu {
  String shop;
  String name;
  int count;
  int price;
  List<String>? people = [];

  Menu({required this.shop, required this.name, required this.count, required this.price});
}

Future<List<Menu>> fetchMenu() async {
  final response = await http.get(Uri.parse('https://d07f5c54-2324-4048-8b65-02874f67c035.mock.pstmn.io/allmenulist'));

  if (response.statusCode == 200) {
    final menus = json.decode(response.body);

    List<Menu> menuMap = [];
    for(var user in menus) {
      menuMap.add(Menu(
        shop: user['shop'],
        name: user['name'],
        count: user['count'],
        price: user['price'],
      ));
    }
    return menuMap;
  }
  throw Exception('데이터 수신 실패!');
}

class MenuList extends StatefulWidget {
  MenuList({Key? key, required this.peopleList, this.shopname}) : super(key: key);
  List<String> peopleList;
  var shopname;

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  var count = 0;
  late Future<List<Menu>> Menuapi;

  addCount() {
    setState(() {
      count++;
    });
  }

  @override
  void initState() {
    super.initState();
    Menuapi = fetchMenu() as Future<List<Menu>>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Text('정보 입력'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 5),
              Flexible(
                flex: 1,
                child: Text("${widget.shopname}",
                  style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              FutureBuilder(// Menu 배열 반환
                future: Menuapi,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Menu>? MenuArray = snapshot.data as List<Menu>?;   // 정확한 형식으로 변환
                    return Flexible(
                        flex: 12,
                        child: ListView.builder(
                            itemCount: MenuArray?.length,
                            itemBuilder: (context, index) {
                              List<String>? peopleLabel = MenuArray![index].people;
                              addPeople(a) { setState(() { peopleLabel?.add(a); }); }
                              return Card(
                                  elevation: 4.0,
                                  color: const Color(0xffFFFFFF),
                                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(3, 5, 3, 5),
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                    width: 40,
                                                    child: Center(child: Text('품목'))),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    height: 20,
                                                    width: 100,
                                                    child: Flexible(
                                                        child: Text(MenuArray[index].name)),
                                                  ),
                                                ),
                                                const SizedBox(
                                                    width: 40,
                                                    child: Center(child: Text('수량'))),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    height: 20,
                                                    width: 100,
                                                    child: Flexible(
                                                        child: Text(MenuArray[index].count.toString())),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        Container(
                                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                            child: Row(
                                                children: [
                                                  const SizedBox(
                                                      width: 40,
                                                      child: Center(child: Text('가격'))),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: SizedBox(
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
                                                const SizedBox(
                                                    width: 40,
                                                    child: Center(child: Text('이름'))),
                                                Expanded(flex: 6,
                                                  child: Container(
                                                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                                    height: 20.0,
                                                    width:10,
                                                    child: addnameLabel(peopleLabel, index),
                                                  ),
                                                ),
                                                // 구성원 추가 버튼
                                                Container(
                                                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                  width: 20,
                                                  height: 20,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => addName(peopleList:widget.peopleList, peopleLabel:peopleLabel, addnameLabel:addnameLabel, addCount:addCount, addPeople:addPeople)));
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        primary: const Color(0xffEEEEEE),
                                                        padding: EdgeInsets.zero,
                                                        shadowColor: Colors.grey,// 버튼 여백 제거
                                                      ),
                                                      child: const Center(child: Icon(Icons.add, size: 14, color: Colors.black,))
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
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 20),
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
  addnameLabel(List<String>? peopleLabel, int index) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: peopleLabel!.length,
        itemBuilder: (c,i){
          return Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 2, 0),
              width: 35,
              decoration: BoxDecoration(
                color: const Color(0xff37b067),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                  child: Text(
                    peopleLabel[i],
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  )
              )
          );
        }
    );
  }
}

class buttonBox extends StatelessWidget {
  const buttonBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      width: double.infinity,
      height: 50,
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(90, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Colors.grey.shade300
            ),
            child: const Text('수정하기', style: TextStyle(color: Colors.black),),
          ),
          ElevatedButton(
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
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }
}