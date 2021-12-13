// import 'dart:convert';
// import 'dart:developer';
// import 'dart:ffi';
// import 'dart:io';

import 'package:covid19/apiservice.dart';
import 'package:covid19/dcl.dart';
import 'package:covid19/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
// import 'package:loadmore/loadmore.dart';

// import 'dart:math';

class Homepage extends StatefulWidget {
  // Homepage({Key? key, required this.token}) : super(key: key);

  // final String token;
  http.Client client = new http.Client(); // create a client to make api calls

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var token;
  DateTime selectedDate = DateTime.now();

  DclModel dclModel = DclModel();

  String apiresult2 = "";
  Apiservice api = new Apiservice();

  List<Report> searchList = [];
  DateTime currentDate = Apiservice().getUSDATE();

  String formattedDate = "";
  @override
  Widget build(BuildContext context) {
    token = ModalRoute.of(context)!.settings.arguments;
    formattedDate = formatDate(currentDate);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
                // NameSearch(token, searchList);
                showSearch(
                    context: context, delegate: NameSearch(token, searchList));
              },
              icon: Icon(Icons.search)),
        ],
        title: Center(
          child: Text("Covid19 App"),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    print("");
                    selectDate(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range),
                      SizedBox(
                        width: 5,
                      ),
                      Text(formattedDate.toString()),
                    ],
                  ),
                )),
          ),
          Expanded(
            child: FutureBuilder<List<Report>>(
              future: api.getdclData(token),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    // child: Text("Loading Data..."),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Loading Data...",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  var data = snapshot.data!;
                  // searchList.addAll(data);
                  var reports = data;
                  searchList.addAll(snapshot.data);

                  return ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      var report = reports[index];
                      // print("result2::" + reports[index].result.toString());
                      //  newresult = newresult.replac
                      //eAll("Result.", "");
                      // var resultcolor = report.result![index].toString();
                      var resultcolor = report.result.toString();

                      // var resultcolor1 = report.result.toString();
                      // print("Result Color : " + resultcolor);
                      resultcolor = resultcolor.replaceAll("Result.", "");
                      // print("Result Color : " + resultcolor[0]);
                      return Card(
                        color: resultcolor == "POSITIVE"
                            ? Colors.red.shade200
                            : resultcolor == "NEGATIVE"
                                ? Colors.green.shade200
                                : Colors.white,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 45,
                                width: 75,
                                decoration: BoxDecoration(
                                  color: Colors.purple[400],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "${report.jotformTestDclCode.toString()}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("${report.patient.toString()}",
                                      style: report.patient.toString().length >
                                              15
                                          ? report.patient.toString().length >
                                                  20
                                              ? TextStyle(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w600)
                                              : TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600)
                                          : TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600)),
                                  Text(
                                    "${report.patientEmail.toString()}",
                                    style:
                                        report.patientEmail.toString().length >
                                                20
                                            ? report.patientEmail
                                                        .toString()
                                                        .length >
                                                    25
                                                ? TextStyle(
                                                    fontSize: 7,
                                                  )
                                                : TextStyle(
                                                    fontSize: 8,
                                                  )
                                            : TextStyle(
                                                fontSize: 9,
                                              ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      "SITE: " +
                                          "${report.siteLocation.toString()}",
                                      style: report.patientEmail
                                                  .toString()
                                                  .length >
                                              20
                                          ? report.patient.toString().length >
                                                  30
                                              ? TextStyle(
                                                  fontSize: 5,
                                                  color: Colors.red,
                                                )
                                              : TextStyle(
                                                  fontSize: 7,
                                                  color: Colors.red,
                                                )
                                          : TextStyle(
                                              fontSize: 9,
                                              color: Colors.red,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  debugPrint("Pressed Positive");
                                  apiresult2 =
                                      api.sendResult(report, token, "POSITIVE");

                                  apiresult2 =
                                      "${report.jotformTestDclCode.toString() + "POSITIVE"}" +
                                          apiresult2;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(apiresult2)));
                                },
                                child: Container(
                                  height: 40,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.purple[400],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "POSITIVE",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  debugPrint("Pressed Negative");
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return WillPopScope(
                                        onWillPop: () async => false,
                                        child: AlertDialog(
                                          title: Text('Title'),
                                          content: Text('This is Demo'),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Go Back'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  // apiresult2 =    api.sendResult(report, token, "NEGATIVE");
                                  apiresult2 =
                                      "${report.jotformTestDclCode.toString() + "NEGATIVE"}" +
                                          apiresult2;

                                  //     SnackBar(content: Text(apiresult2)));

                                  new AlertDialog(
                                      title: new Text('Test'),
                                      content: Column(
                                        children: [
                                          Container(
                                            color: Colors.purple,
                                            child: Column(
                                              children: [
                                                Text("Are you sure?"),
                                                Text(""),
                                                Text(
                                                    "STOP - before finalizing this Rapid result, verify that the patient belongs to the correct site location. If not, please cancel and try again."),
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Text("Patient E-Mail	"),
                                                      Text("Patient E-Mail	"),
                                                      Text("Patient E-Mail	"),
                                                      Text("Patient E-Mail	"),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ));
                                },
                                child: Container(
                                  height: 40,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.purple[400],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "NEGATIVE",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
      formattedDate = formatDate(currentDate);
      setState(() {});
    }
  }

  String formatDate(DateTime currentDate) {
    var formatter = new DateFormat('yyyy/MM/dd');
    String formatDate = formatter.format(currentDate);

    return formatDate;
  }
}
