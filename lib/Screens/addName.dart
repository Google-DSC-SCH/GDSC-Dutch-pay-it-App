import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dutch_pay_it/Screens/addInfo.dart';

class addName extends StatefulWidget {

  addName({Key? key, required this.peoplelist, required this.peopleLabel, this.addnameLabel, this.addCount, this.addPeople}) : super(key: key);
  List<String> peoplelist;
  List<String>? peopleLabel;
  var addnameLabel;
  var addCount;
  var addPeople;

  @override
  State<addName> createState() => _addNameState();
}

class _addNameState extends State<addName> {
  var dropdownValue;
  late List<String> droplist = [];
  late String selected;
  var nameLabel;
  //List<String>? peopleLabel;

  @override
  void initState() {
    super.initState();
    setState(() {
      print("전달받은 peopleLabel");
      print(widget.peopleLabel);
      print('리스트수 ${widget.peoplelist.length}');
      dropdownValue = widget.peoplelist[0];
      print('dropdown 초기 값은 ${dropdownValue}');
      for (int i=0; i<widget.peoplelist.length; i++) {
        print('부모로부터 전송받은 namelist:  ${widget.peoplelist[i]}');
      }
      for (int i = 0; i < widget.peoplelist.length; i++) {
        droplist.add(widget.peoplelist[i]);     // 전달받은 list값을 복사
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('인원 추가'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                //'Selected Value: $dropdownValue',
                '추가할 사람을 선택하세요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: 150,
                child: DropdownButton(
                    isExpanded: true,
                    value: dropdownValue,
                    items: widget.peoplelist.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                        //change(dropdownValue);   //-----여기서 오류 발생
                        //selected = dropdownValue;      // onchange를 통해 바뀐 값을 addDialog에 전달해야함
                        print(dropdownValue);
                      });
                    }
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text("선택완료"),
                onPressed: () {
                  setState(() {
                    //widget.peopleLabel!.length++;
                    //widget.addCount();
                    //widget.count++;
                    selected = dropdownValue;
                    print("추가된 selected값은 ${selected}");
                    //widget.peopleLabel?.add(selected);
                    widget.addPeople(selected);
                    //widget.addnameLabel(widget.peopleLabel);
                    print(widget.peopleLabel!);       // 오류 x
                  });
                  //change(selected);
                  Navigator.pop(context);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => MenuList(peoplelist: widget.peoplelist,)));
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
        ),
      ),
    );
  }
}