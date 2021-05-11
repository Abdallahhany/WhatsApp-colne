import 'package:chatapp/widgets/statusWidgets/headOwnStatus.dart';
import 'package:chatapp/widgets/statusWidgets/othersStatus.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              onPressed: () {},
              elevation: 8,
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            child: Icon(Icons.camera_alt),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeadOwnStatus(),
            label("Recent Updates"),
            OthersStatus(name: "Balram Rathore",time: "10.45",image: "1.png",isSeen: false,statusNum: 10,),
            OthersStatus(name: "Dev Stack",time: "11.15",image: "3.jpg",isSeen: false,statusNum: 2,),
            OthersStatus(name: "Kishor",time: "10.45",image: "4.jpg",isSeen: false,statusNum: 3,),
            OthersStatus(name: "Collins",time: "10.45",image: "5.jpg",isSeen: false,statusNum: 4,),
            label("Viewed Updates"),
            OthersStatus(name: "Balram Rathore",time: "10.45",image: "1.png",isSeen: true,statusNum: 1,),
            OthersStatus(name: "Dev Stack",time: "11.15",image: "3.jpg",isSeen: true,statusNum: 2,),
          ],
        ),
      ),
    );
  }
  Widget label(String labelName){
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child: Text(
          labelName,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
