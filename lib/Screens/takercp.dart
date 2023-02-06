import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dutch_pay_it/Screens/addInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dutch_pay_it/Model/object.dart';

// 영수증 촬영 페이지

class TakeRcp extends StatefulWidget {
  var key_name;
  var shop;

  TakeRcp({Key? key, required this.peoplelist, this.key_name, required this.shop}) : super(key: key);
  List<String> peoplelist;   // addlist에서 입력받은 구성원 리스트 (_controller)

  @override
  State<TakeRcp> createState() => _TakeRcpState();
}

class _TakeRcpState extends State<TakeRcp> {

  @override
  void initState() {
    // List<String> peopleName = widget.peoplelist;  // 구성원 리스트 from addlist
    // var peopleCount = widget.peoplelist.length;   // 총인원수 from addlist
  }

  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path);
    });
  }

  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('영수증 촬영'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xfff4f3f9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 25.0),
          showImage(),
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                child: Icon(Icons.add_a_photo),
                tooltip: '촬영하기',
                onPressed: () {
                  getImage(ImageSource.camera);
                },
              ),
              FloatingActionButton(
                child: Icon(Icons.wallpaper),
                tooltip: '선택하기',
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              postRequest();
              Get.to(MenuList(peoplelist:widget.peoplelist, shopname:widget.shop));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue
            ),
            child: const Text(
              '사진 저장',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  // 이미지 전송 POST 오류
  Future<void> postRequest() async {
    File imageFile = File(_image!.path);
    //List<int> imageBytes = imageFile.readAsBytesSync();
    //String base64Image = base64Encode(imageBytes);
    //print(base64Image);
    print("이미지파일은 ${imageFile}");
    Uri url = Uri.parse('http://cjw7155.iptime.org:8080/menu/send/image');

    var headers = {
      'Content-Type' : 'application/json'
    };

    final body = {
      'request': {'key_name': 1, 'shop': '지짐이'},
      'image' : 'assets/images/image.jpg'
    };

    http.Response response = await http.post(
        url,
        headers: headers,
        body: json.encode(body)
    );
    print(response.body);
  }

}