import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dutch_pay_it/Screens/calculate.dart';
import 'package:dutch_pay_it/Model/object.dart';

class AddInfo extends StatefulWidget {
  AddInfo({Key? key}) : super(key: key);


  @override
  State<AddInfo> createState() => _AddInfoState();
}


class _AddInfoState extends State<AddInfo> {
  var dropdownValue = '재원';
  List<String> nameList = ['재원', '채민', '하늘','민혁'];
  var selectedName;
  List<String> nameLabel = ['지영'];     // 이름 라벨 리스트
  var count = 0;
  var itemcount = 0;
  List<dynamic> menuInfo = [['소주', 6, 30000], ['안주', 1, 20000], ['맥주', 1, 5000]];
  String shop = '식당이름';

  //List<String> peopleList =

  List<MenuList> menulist = [
    MenuList('식당1', '소주', 6, 30000, '지영', 1),
    MenuList("식당1", "안주", 1, 20000, "현수", 1),
    MenuList("식당1", "맥주", 1, 5000, "민혁", 1),
  ];

  List<String> list1 = ['지영', '윤섭', '채민'];
  List<String> list2 = ['지영', '민혁'];
  List<String> list3 = ['민혁', '윤섭', '채민', '하늘'];

  printmenu() {
    for (int i = 0; i < 3; i++) {
      print(menulist[i].menuName);
    }
  }


  addCount() {
    setState(() {
      count++;
    });
  }


  @override
  Widget build(BuildContext context) {
    itemcount = count;
    return Scaffold(
        appBar: AppBar(
          title:Text('정보 입력'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body:
        Center(
          //padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 5),
              Flexible(
                flex: 1,
                child: Text("${shop}",
                  style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Flexible(
                flex: 12,
                child: menuList(menuInfo:menuInfo, addCount:addCount, dropdownValue:dropdownValue, nameList: nameList, selectedName:selectedName, nameLabel:nameLabel, count:count, menulist:menulist),
                //child: listBox(nameList: nameList, selected:selected),
              ),
              SizedBox(height: 20),
              buttonBox(count:itemcount, nameLabel:nameLabel, menuInfo:menuInfo),
            ],
          ),
        )
    );
  }
}

class menuList extends StatefulWidget {
  menuList({Key? key, required this.menuInfo, required this.addCount, required this.dropdownValue, required this.nameList, required this.selectedName, required this.nameLabel, required this.count, required this.menulist}) : super(key: key);
  final addCount;
  var dropdownValue;
  List<String> nameList;
  var selectedName;
  List<String> nameLabel;
  var count;
  var menuInfo;
  var menulist;

  @override
  State<menuList> createState() => _menuListState();
}

class _menuListState extends State<menuList> {

  TextEditingController _menuController = new TextEditingController(text: '픔목');
  TextEditingController _priceController = new TextEditingController(text: '10000' + '원');
  TextEditingController _countController = new TextEditingController(text: '1' + '개');

  // var dropdownValue = widget.dropdownValue;
  // var nameList = widget.nameList;
  // var selectedName = widget.selectedName;
  // var nameLabel = widget.nameLabel;
  // var count = widget.count;

  @override
  Widget build(BuildContext context) {
    //widget.count = 0;
    return ListView.builder(
        //itemCount: widget.menuInfo.length,
        itemCount: 3,
        itemBuilder: (BuildContext ctx, i) {
          return Card(
              elevation: 4.0,
              color: Color(0xffFFFFFF),
              margin: EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Container(
                //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                margin: EdgeInsets.fromLTRB(3, 5, 3, 5),
                child: Column(
                  children: [

                    Container(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                        child: Row(
                          children: [
                            Container(
                                width: 40,
                                //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                child: Center(child: Text('품목'))),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 20,
                                width: 100,
                                child: Flexible(
                                  child: TextField(textAlign: TextAlign.center,
                                    controller: new TextEditingController(text: '${widget.menulist[i].menuName}'),
                                  ),
                                ),
                              ),
                            ),
                            // Expanded(flex: 1,
                            //     //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                            //     child: Center(child: Text('${widget.menuInfo[i][0]}', style: TextStyle(color: Colors.grey),))),
                            Container(
                                width: 40,
                                //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                child: Center(child: Text('수량'))),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 20,
                                width: 100,
                                child: Flexible(
                                  child: TextField(textAlign: TextAlign.center,
                                    controller: new TextEditingController(text: '${widget.menulist[i].menuCount}'),
                                  ),
                                ),
                              ),
                            ),
                            // Expanded(flex: 1,
                            //     //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                            //     child: Center(child: Text('${widget.menuInfo[i][1]}', style: TextStyle(color: Colors.grey),)))
                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                        child: Row(
                            children: [
                              Container(
                                  width: 40,
                                  //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                  child: Center(child: Text('가격'))),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 20,
                                  width: 100,
                                  child: Flexible(
                                    child: TextField(textAlign: TextAlign.center,
                                      controller: new TextEditingController(text: '${widget.menulist[i].price}'),
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //     width: 180,
                              //     //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                              //     child: Center(child: Text('${widget.menuInfo[i][2]}', style: TextStyle(color: Colors.grey),)))
                            ]
                        )
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                        child: Row(
                          children: [
                            Container(
                              //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                width: 40,
                                child: Center(child: Text('이름'))),
                            Expanded(flex: 6,
                              //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                              //height: 20,
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                  height: 20.0,
                                  width:10,
                                  child: addnameLabel(count:widget.count, nameLabel:widget.nameLabel)
                              ),
                            ),
                            Container(
                              //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              width: 20,
                              height: 20,
                              child: ElevatedButton(
                                  onPressed: () {
                                    addDialog();
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
    );
  }
  void addDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              children: <Widget>[
                new Text("추가할 사람을 선택해주세요"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 150,

                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: widget.dropdownValue,
                      items: widget.nameList
                          .map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (newvalue) {
                        setState(() {
                          widget.dropdownValue = newvalue!;
                          print(widget.dropdownValue);

                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                child: new ElevatedButton(
                  child: new Text("선택하기"),
                  onPressed: () {
                    widget.addCount();
                    widget.selectedName = widget.dropdownValue;   // 드롭다운 메뉴에서 선택한 이름 저장
                    print('selected Name : ${widget.selectedName}');
                    setState((){widget.nameLabel.add(widget.selectedName);});
                    print('count: ${widget.count}');
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        });
  }
// @override
// void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//   super.debugFillProperties(properties);
//   properties.add(DiagnosticsProperty('dropdownValue', dropdownValue));
// }
}

class addnameLabel extends StatelessWidget {
  addnameLabel({Key? key, this.count, this.nameLabel}) : super(key: key);
  var count;
  var nameLabel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: count+1,
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
                  child: Text('${nameLabel[i]}', style: TextStyle(color: Colors.white, fontSize: 11),))
          );
        }
    );
  }
}


class buttonBox extends StatelessWidget {
  buttonBox({Key? key, this.count, this.nameLabel, this.menuInfo}) : super(key: key);
  var count;
  var nameLabel;
  var menuInfo;

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
              print(count);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Calculate(count:count, nameLabel:nameLabel, menuInfo:menuInfo)),
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
