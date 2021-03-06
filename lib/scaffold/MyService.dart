import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dnadetec/models/detail_Model.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
// Field
  List<DetailModel> detailModels = List();

// Method
  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    String url = 'http://infobizplus.com/DNA/getAllProduct.php';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);

    for (var map in result) {
      DetailModel detailModel = DetailModel.fromJson(map);
      setState(() {
        detailModels.add(detailModel);
      });
    }
  }

  Widget showImage(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Image.network(detailModels[index].imgDNA),
    );
  }
  Widget showText(int index){
    return Text(detailModels[index].name);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลการวิเคราะห์'),
      ),
      body: ListView.builder(
        itemCount: detailModels.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              showImage(index),showText(index),
            ],
          );
        },
      ),
    );
  }
}
