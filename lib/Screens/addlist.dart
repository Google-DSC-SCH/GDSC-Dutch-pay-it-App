

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/object.dart';
import 'addInfo.dart';

class AddList extends StatefulWidget {
  const AddList({Key? key}) : super(key: key);

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {


  String restaurant = '';
  TextEditingController _editingController = TextEditingController();
  List<TextEditingController> _controllers = [];
  List<TextField> _fields = [];
  List<String> peoplelist = [];
  String inputText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _addTile() {
    return ListTile(
      title: Icon(Icons.add),
      onTap: () {
        var controller = TextEditingController();
        final field = TextField(
          onChanged: (text) {
            inputText = text;
          },
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "구성원 ${_controllers.length + 1}",
          ),
        );
        setState(() {
          _controllers.add(controller);
          //peoplelist.add(_controllers);
          print(_controllers.length);
          _fields.add(field);
        });
      },
    );
  }

  Widget _removeTile() {
    return ListTile(
      title: Icon(Icons.remove),
      onTap: () {
        setState(() {
          peoplelist.removeLast();
          _fields.removeLast();
        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _fields.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(5),
          child: _fields[index],
        );
      },
    );
  }

  // Widget _okButton() {
  //   return ElevatedButton(
  //     onPressed: () async {
  //       String text = _controllers
  //           .where((element) => element.text != "")
  //           .fold("", (acc, element) => acc += "${element.text}\n");
  //       final alert = AlertDialog(
  //         title: Text("Count: ${_controllers.length}"),
  //         content: Text(text.trim()),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("OK"),
  //           ),
  //         ],
  //       );
  //       await showDialog(
  //         context: context,
  //         builder: (BuildContext context) => alert,
  //       );
  //       setState(() {});
  //     },
  //     child: Text("OK"),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('목록 추가'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
        child: Center(
          child: Column(
            children: [
              Text(
                '식당 이름을 입력해주세요.',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _editingController,
                decoration: InputDecoration(
                  hintText: '식당 이름',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                '구성원 이름을 입력해주세요.',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: _listView()
              ),
              _addTile(),
              _removeTile(),
              SizedBox(
                height: 1,
              ),
              ElevatedButton(
                onPressed: () async{
                  setState(() {
                    restaurant = _editingController.text;   // 입력받은 식당 이름을 문자열 형태로 변환하여 저장
                    print('_controllers.length값 ${_controllers.length}');
                    for (int i = 0; i < _controllers.length; i++) {
                      print('_controller 리스트 값 ${_controllers[i].text}');
                      peoplelist.add(_controllers[i].text);
                      print('peoplelist.length개수 ${peoplelist.length}');
                    }
                  });
                  Get.to(MenuList());     // 구성원 리스트 전달
                  //MaterialPageRoute(builder: (context) => menuList(peoplelist:peoplelist));
                },
                child: Text(
                  '영수증 촬영하기',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, minimumSize: Size(250, 40)),
              )
            ],
          ),
        ),
      ),
    );
  }
}


