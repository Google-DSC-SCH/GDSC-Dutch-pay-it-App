import 'package:flutter/material.dart';
import 'package:dutch_pay_it/Screens/addlist.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int listcount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('목록'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   color: Colors.blueGrey[200],
          //   width: 300,
          //   height: 400,
          //   child: ListView.builder(
          //     scrollDirection: Axis.vertical,
          //     padding: EdgeInsets.all(5),
          //     itemCount: listcount+1,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Container(
          //         margin: EdgeInsets.all(3),
          //         height: 50,
          //         color: Colors.white,
          //         alignment: Alignment.center,
          //         child: Text('$listcount')
          //       );
          //     },
          //   ),
          // ),
          SizedBox(
              height: 30
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
               Get.to(AddList());
              },
              icon: Icon(Icons.add, size: 18),
              label: Text(
                '추가하기',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 100), backgroundColor: Colors.green),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(onPressed: () {}, child: Text('초기화')),
          //     SizedBox(
          //       width: 43,
          //     ),
          //     ElevatedButton(onPressed: () {}, child: Text('정산하기'))
          //   ],
          // )
        ],
      ),
    );
  }
}
