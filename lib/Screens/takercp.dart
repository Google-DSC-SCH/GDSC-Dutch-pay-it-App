import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dutch_pay_it/Screens/addInfo.dart';
import 'package:dutch_pay_it/Screens/addlist.dart';
import 'package:dutch_pay_it/Model/object.dart';

// 영수증 촬영 페이지

class TakeRcp extends StatefulWidget {
  TakeRcp({Key? key, this.peoplelist}) : super(key: key);
  var peoplelist;   // addlist에서 입력받은 구성원 리스트 (_controller)

  @override
  State<TakeRcp> createState() => _TakeRcpState();
}

class _TakeRcpState extends State<TakeRcp> {

  void initState() {
    List<String> peopleName = widget.peoplelist;  // 구성원 리스트 from addlist
    var peopleCount = widget.peoplelist.length;   // 총인원수 from addlist
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
                ? Text('No image selected.')
                : Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      appBar: AppBar(
        title: Text('영수증 촬영'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xfff4f3f9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 25.0),
          showImage(),
          SizedBox(
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
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                Get.to(AddInfo());
              },
              child: Text(
                '사진 저장',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue
            ),
          )
        ],
      ),
    );
  }
}
