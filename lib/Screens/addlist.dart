import 'package:dutch_pay_it/Screens/takercp.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class AddList extends StatefulWidget {
  const AddList({Key? key}) : super(key: key);

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  String restaurant = '';
  final TextEditingController _editingController = TextEditingController();
  final List<TextEditingController> _controllers = [];
  final List<TextField> _fields = [];
  List<String> peopleList = [];
  String inputText = '';
  String id = '';

  // 디바이스 id 추출
  Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    late String deviceId;

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor!;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.androidId!;
    } else {
      deviceId = 'null';
    }
    print(deviceId);
    id = deviceId;
    return id;
  }

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
      title: const Icon(Icons.add),
      onTap: () {
        var controller = TextEditingController();
        final field = TextField(
          onChanged: (text) {
            inputText = text;
          },
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "구성원 ${_controllers.length + 1}",
          ),
        );
        setState(() {
          _controllers.add(controller);
          print(_controllers.length);
          _fields.add(field);
        });
      },
    );
  }

  Widget _removeTile() {
    return ListTile(
      title: const Icon(Icons.remove),
      onTap: () {
        setState(() {
          peopleList.removeLast();
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
          margin: const EdgeInsets.all(5),
          child: _fields[index],
        );
      },
    );
  }

  Widget _okButton() {
    return ElevatedButton(
      onPressed: () async {
        String text = _controllers
            .where((element) => element.text != "")
            .fold("", (acc, element) => acc += "${element.text}\n");
        final alert = AlertDialog(
          title: Text("인원수: ${_controllers.length}명"),
          content: Text(text.trim()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
        await showDialog(
          context: context,
          builder: (BuildContext context) => alert,
        );
        setState(() {});
      },
      child: const Text("OK"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('목록 추가'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
        child: Center(
          child: Column(
            children: [
              const Text(
                '식당 이름을 입력해주세요.',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _editingController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: '식당 이름',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                '구성원 이름을 입력해주세요.',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: _listView()
              ),
              _addTile(),
              _removeTile(),
              _okButton(),
              const SizedBox(
                height: 1,
              ),
              ElevatedButton(
                onPressed: () async{
                  setState(() {
                    restaurant = _editingController.text;   // 입력받은 식당 이름을 문자열 형태로 변환하여 저장
                    print('_controllers.length값 ${_controllers.length}');
                    for (int i = 0; i < _controllers.length; i++) {
                      print('_controller 리스트 값 ${_controllers[i].text}');
                      peopleList.add(_controllers[i].text);
                      print('peoplelist.length개수 ${peopleList.length}');
                    }
                  });
                  sendData();         // 유저키값, 식당이름, 구성원 리스트 서버로 POST
                  Get.to(TakeRcp(peoplelist:peopleList, key_name:id, shop:_editingController.text));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, minimumSize: const Size(250, 40)),
                child: const Text(
                  '영수증 촬영하기',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> sendData() async {
    final url = Uri.parse('http://15.164.45.247:8080/user/create');

    Map<String, String> headers = {
      'Content-Type' : 'application/json'
    };

    final map = jsonEncode({
      'name': id,
      'shop': _editingController.text,
      'nameList': peopleList,
    });

    http.Response response = await http.post(
        url,
        headers: headers,
        body: map
    );
  }
}