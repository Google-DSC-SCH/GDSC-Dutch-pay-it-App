import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dutch_pay_it/Screens/home.dart';

class Calculate extends StatelessWidget {
  Calculate({Key? key}) : super(key: key);
  var nameLabel = ['지영', '현수', '윤섭', '재원'];
  var count = 0;
  var menuItem = [
    {
      "name": "지영",
      "menu": [
        {"name": "닭발", "price":"4000"},
        {"name": "참이슬", "price":"4500"},
        {"name": "계란말이", "price":"7750"}
      ],
      "sum" : "16250"
    },
    {
      "name": "민혁",
      "menu": [
        {"name": "카스", "price":"4500"},
        {"name": "오돌뼈&주먹밥", "price":"8000"},
        {"name": "계란말이", "price":"7750"}
      ],
      "sum" : "15750"
    },
    {
      "name": "윤섭",
      "menu": [
        {"name": "카스", "price":"4500"},
        {"name": "오돌뼈&주먹밥", "price":"8000"},
        {"name": "닭발", "price":"4000"}
      ],
      "sum" : "16500"
    },
    {
      "name": "하늘",
      "menu": [
        {"name": "참이슬", "price":"4500"},
        {"name": "오돌뼈&주먹밥", "price":"8000"},
        {"name": "카스", "price":"4500"}
      ],
      "sum" : "16500"
    },
    {
      "name": "채민",
      "menu": [
        {"name": "참이슬", "price":"4500"},
        {"name": "닭발", "price":"4000"}
      ],
      "sum" : "8500"
    }
  ];
  var menuInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Text('정산서 발행'),
          centerTitle: true,
        ),
        body: Center(
          //padding: const EdgeInsets.all(8.0),
          child: Column(
            children:  [
              Flexible(
                flex: 8,
                child: Card(
                  margin: const EdgeInsets.all(30),
                  child: listBox(count:count, nameLabel:nameLabel, menuItem:menuItem),
                ),
              ),
              Flexible(
                flex: 1,
                child: buttonBox(),
              ),
            ],
          ),
        )
    );
  }
}

class listBox extends StatelessWidget {
  listBox({Key? key, this.menuItem, this.count, this.nameLabel}) : super(key: key);
  var count;
  var nameLabel;
  var menuItem;
  var sum = 0;

  addAmount(sum, menuInfo) {        // 총 금액 계산
    for (var i = 0; i < menuInfo.length; i++) {
      sum += menuInfo[i][2];
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: menuItem.length,
      itemBuilder: (context, i) {
        return ListTile(
            title: Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${menuItem[i]["name"]}'),
                    Text('${menuItem[i]["sum"]}'),
                  ],
                )
            ),
            subtitle: calculateMenu(menuItem:menuItem[i]["menu"])
        );
      }, separatorBuilder: (BuildContext context, int index) { return const Divider(); },
    );
  }
}

class calculateMenu extends StatelessWidget {
  calculateMenu({Key? key, this.menuItem}) : super(key: key);
  var count;
  var menuInfo;
  var menuCount = 0;
  var menuItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: menuItem.length,
        itemBuilder: (context, i) {
          getCount(menuCount, menuInfo) {   // 인당 메뉴별 정산금액 계산
            for (int j = 0; j < i+1; j++) {
              menuCount = menuInfo[j][2]/count;
            }
            return menuCount;
          }
          return Row(
              children:[
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text('${menuItem[i]["name"]}', style: const TextStyle(fontSize: 12),)),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text('${menuItem[i]["price"]}')),
              ]
          );
        }
    );
  }
}

class calculateItem extends StatelessWidget {
  const calculateItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(10, 2, 8, 10),
        itemCount: 5,
        itemBuilder: (BuildContext ctx, int idx) {
          return Text('메뉴 ${idx+1}', style: TextStyle(fontSize: 13, color: Color(0xff888888)),);
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
            child: const Text('공유하기', style: TextStyle(color: Colors.black),),
          ),
          ElevatedButton(
            child: Text("확인"),
            onPressed: () {
              Get.offAll(() => HomePage(title: ''));
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(90, 35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}