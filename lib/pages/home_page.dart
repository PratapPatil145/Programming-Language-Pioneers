import 'dart:convert';
import 'dart:developer';

import 'package:cpl_pioneers/constants.dart';
import 'package:cpl_pioneers/models/pioneer.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' as rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPioneerIndex = 0;

  @override
  Widget build(BuildContext context) {
    Device.height = MediaQuery.of(context).size.height;
    Device.width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Programming Language Pioneers"),
      ),
      body: FutureBuilder(
        future: fetchAllPioneers(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            List<Pioneer> pioneers = data.data as List<Pioneer>;
            return Column(
              children: [
                Container(
                  // color: Colors.green,
                  height: Device.height*0.1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pioneers.length,
                    itemBuilder: (context, index) => buildChoiceChip(
                      index: index, pioneer: pioneers[index]
                    )
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: buildPioneerDetails(pioneer: pioneers[_currentPioneerIndex])
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }

  Widget buildChoiceChip({required int index, required Pioneer pioneer}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 12, 2, 12),
      child: ChoiceChip(
        onSelected: (bool value) {
          setState(() {
            _currentPioneerIndex = index;
          });
        },
        selected: index == _currentPioneerIndex,
        label: Text(
          "${pioneer.language}",
          style: TextStyle(
            color: _currentPioneerIndex == index
                ? Device.primaryColor
                : Device.primaryColor.withOpacity(0.8),
            fontSize: Device.height*0.023
          ),
        ),
        padding: EdgeInsets.all(10),
        labelStyle: TextStyle(
          color: _currentPioneerIndex == index
              ? Device.primaryColor
              : Device.primaryColor.withOpacity(0.6),
        ),
        selectedColor: Colors.lightBlueAccent.withOpacity(0.4),
      ),
    );
  }

  Widget buildPioneerDetails({required Pioneer pioneer}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: Device.height*1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image(
                height: Device.height*0.3,
                width: Device.height * 0.3,
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/${pioneer.img}"
                )
              ),
            ),
            SizedBox(height: Device.height*0.02,),
            Text(
              "${pioneer.name}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Device.height*0.04
              ),
            ),
            SizedBox(height: Device.height*0.01,),
            Text(
              "${pioneer.country}",
              style: TextStyle(
                fontSize: Device.height*0.026
              ),
            ),
            SizedBox(height: Device.height*0.02,),
            Text(
              "${pioneer.bio}",
              style: TextStyle(
                fontSize: Device.height * 0.02,
                color: Device.primaryColor.withOpacity(0.7)
              ),
            ),

            
          ],
        ),
      ),
    );
  }

  Future<List<Pioneer>> fetchAllPioneers() async {
    try {
      final jsondata = await rootBundle.rootBundle
          .loadString('assets/data/pioneer_json_data.json');
      final list = json.decode(jsondata) as List;
      List<Pioneer> pioneers = list.map((e) => Pioneer.fromJson(e)).toList();
      pioneers.sort((pioneer1, pioneer2) =>
          pioneer1.language.compareTo(pioneer2.language));
      // pioneers.forEach((pioneer) {
      //   log("${pioneer.language}");
      // });
      return pioneers;
    } catch (e) {
      log("ReadJsonData error: $e");
      return [];
    }
  }
}
