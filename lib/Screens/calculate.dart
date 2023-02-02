import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dutch_pay_it/Screens/home.dart';

class Calculate extends StatelessWidget {
  Calculate({Key? key, this.menuInfo, this.count, this.nameLabel, this.menuItem}) : super(key: key);
  var count;
  var nameLabel;
  var menuItem;
  var menuInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text('정산서 발행'),
          centerTitle: true,
        ),
        body: Center(
          //padding: const EdgeInsets.all(8.0),
          child: Column(
            children:  [
              Flexible(
                flex: 8,
                child: Card(
                  margin: EdgeInsets.all(30),
                  //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                  child: listBox(count:count, nameLabel:nameLabel, menuInfo:menuInfo),
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
  listBox({Key? key, this.menuInfo, this.count, this.nameLabel}) : super(key: key);
  var count;
  var nameLabel;
  var menuInfo;
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
      itemCount: count+1,
      itemBuilder: (context, i) {
        return Container(
          child: ListTile(
              title: Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(child: Text('${nameLabel[i]}')),
                      Container(child: Text('${addAmount(sum, menuInfo)}')),
                    ],
                  )
              ),
              subtitle: Container(
                  child: Container(child: calculateMenu(count:count, menuInfo:menuInfo,))
              )
          ),
        );
      }, separatorBuilder: (BuildContext context, int index) { return Divider(); },
    );
  }
}

class calculateMenu extends StatelessWidget {
  calculateMenu({Key? key, this.count, this.menuInfo}) : super(key: key);
  var count;
  var menuInfo;
  var menuCount = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: menuInfo.length,
        itemBuilder: (context, i) {
          getCount(menuCount, menuInfo) {   // 인당 메뉴별 정산금액 계산
            for (int j = 0; j < i+1; j++) {
              menuCount = menuInfo[j][2]/count;
            }
            return menuCount;
          }


          return Container(
              child: Row(
                  children:[
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                        child: Text('${menuInfo[i][0]}', style: TextStyle(fontSize: 12),)),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                        child: Text('${getCount(menuCount, menuInfo)}')),
                  ]
              )
          );
        }
    );
  }
}



class listBox6 extends StatelessWidget {
  const listBox6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(50, 30, 50, 30),
      scrollDirection:
      Axis.vertical,
      itemCount: 6, // 임시
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          height: 70,

          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 8, 0, 5),
                      child: Text('이름', style: TextStyle(fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 8, 10, 5),
                      child: Text('정산금액'),
                    ),
                  ],
                ),
              ),
              Expanded(child: calculateItem()),
            ],
          ),
        );
      }, separatorBuilder: (BuildContext context, int index) { return Divider(); },
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
      //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      width: double.infinity,
      height: 50,
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('공유하기', style: TextStyle(color: Colors.black),),
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(90, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Colors.grey.shade300
            ),
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
              //primary: Colors.grey.shade300
            ),
          ),
        ],
      ),
    );
  }
}