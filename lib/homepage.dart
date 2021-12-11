import 'dart:convert';
import 'dart:developer';
// import 'dart:ffi';
import 'dart:io';

import 'package:covid19/apiservice.dart';
import 'package:covid19/dcl.dart';
import 'package:covid19/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';

import 'dart:math';

class Homepage extends StatefulWidget {
  http.Client client = new http.Client(); // create a client to make api calls

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var token;

  DclModel dclModel = DclModel();

  String apiresult2 = "";
  Apiservice api = new Apiservice();
  List<Report> searchList = [];
  // var reports;

  // @override
  // void initState() {
  //   token = Apiservice().getToken();

  //   Apiservice().getdclData(token);
  //   // getRes();
  //   //

  //   super.initState();
  // }

  // bool isLoadig = false;
  // getRes() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   token = api.getToken();
  //   // dclCodeList = dclList;
  //   setState(() {
  //     isLoadig = false;
  //   });
  //   getData();
  //   // return token;
  // }

  // Future<DclModel> getData() async {
  //   // await getRes();

  //   setState(() {
  //     isLoading = true;
  //   });
  //   // filteredList = <String>[];

  //   print("Token Received");
  //   // await getData();
  //   // searchList = jsonResponse.map((e, f) => searchList.addAll(e)).toList();
  //     // dclModel = dclModelFromJson(response.body);
  //     // // jsonResponse.forEach((element) {
  //     // searchList.forEach((element) {
  //     //   searchList.add(element);
  //     // });
  //     // //   searchList.add(element);
  //     // // });
  //     //   tempList.add(dclModel.reports![index].jotformTestDclCode
  //     //       .toString()
  //     //       .toUpperCase());
  //     // });
  //     // var reportz = jsonResponse['reports'];

  //     // for (var dcls in reportz) {}
  //     print("DCL MODEL Length :" + dclModel.reports!.length.toString());
  //     // for (int i = 0; i < dclModel.reports!.length; i++) {
  //     //   tempList[i] = dclModel.reports![i].jotformTestDclCode.toString();
  //     // }
  //     // DclModel searchModel = DclModel();

  //     // for (int i = 0; i < dclModel.reports!.length; i++) {
  //     // //   tempList[i] = dclModel.reports![i].jotformTestDclCode.toString();
  //     // // cardList[i] = dclModel.reports![i];

  //     // // filteredList.add(dclModel.reports![i].jotformTestDclCode.toString());
  //     // }
  //     // setState(() {
  //     //    dclCodeList = filteredList;
  //     // });
  //     // searchList.forEach((element) {
  //     // for (int i in dclModel) {
  //     //   searchList.add(dclModel[i]);
  //     // }
  //     // // dclModel.reports[]
  //     // print("templist :" + filteredList[0]);
  //     // debugPrint("Report length : " + filteredList.length.toString());
  //     // debugPrint("Report first: " +
  //     //     dclModel.reports![0].jotformTestDclCode.toString());
  //     setState(() {
  //       isLoading = false;
  //     });
  //     // print("SearchList:  " +
  //     //     searchList[0].reports![0].jotformTestDclCode.toString());
  //     return dclModel;

  //     // return jsonResponse.map((job) => new DclModel.fromJson(job)).toList();
  //   } else {
  //     return dclModel;
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
        title: Center(
          child: Text("Covid19 App"),
        ),
      ),
      body: Container(
        child: FutureBuilder<List<Report>>(
            future: api.getToken(),
            builder: (context, snapshot) {
              var data = snapshot.data!;
              // searchList.addAll(data);
              var reports = data;
              searchList.addAll(reports);
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  var report = reports[index];
                  return Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.purple[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "${report.jotformTestDclCode.toString()}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "${report.patient.toString()}",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${report.patientEmail.toString()}",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              debugPrint("Pressed Positive");
                              api.sendResult(report, token, "POSITIVE");
                            },
                            child: Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.purple[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "POSITIVE",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              debugPrint("Pressed Negative");
                              api.sendResult(report, token, "POSITIVE");
                            },
                            child: Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.purple[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "NEGATIVE",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
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
            }),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.search_outlined),
      //   onPressed: () {
      //     // showSearch(context: context, delegate: NameSearch(token, searchList));
      //   },
      // ),
    );
  }

//   Widget dclWidget(DclModel dclModel) {
//     return isLoading
//         ? Center(child: CircularProgressIndicator())
//         : Expanded(
//             child: ListView.builder(
//               // physics: NeverScrollableScrollPhysics(),
//               // itemCount: model.reports!.length,
//               shrinkWrap: true,
//               //                   var newresult = report.result.toString();
//               //                   newresult = newresult.replaceAll("Result.", "");
//               // itemCount: dclModel.reports!.length,
//               itemCount: 2,
//               itemBuilder: (context, index) {
//                 var report = dclModel.reports![index];
//                 // var reportsList = dclSnap.data[index];
//                 // var report = model.reports![index];
//                 // dclList.add(report.jotformTestDclCode.toString());

//                 var newresult = report.result.toString();
//                 newresult = newresult.replaceAll("Result.", "");
//                 return SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.125,
//                   child: Card(
//                     margin: EdgeInsets.all(3),
//                     color: newresult == "POSITIVE" || newresult == "NEGATIVE"
//                         ? Colors.deepOrange[200]
//                         : Colors.cyan[50],
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           // mainAxisAlignment:
//                           //     MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               children: [
//                                 Text(report.jotformTestDclCode.toString()),
//                                 Text(newresult),
//                                 // Text(report.patientEmail.toString()),
//                               ],
//                             ),
//                             TextButton(
//                               style: TextButton.styleFrom(
//                                   primary: Colors.white,
//                                   backgroundColor: Colors.purple[400]),
//                               onPressed: () async {
//                                 print("Positive");
//                                 apiresult2 =
//                                     await sendResult(report, token, "POSITIVE");
//                                 // apiresult2 = " SENT POSITIVE";

//                                 Scaffold.of(context).showSnackBar(SnackBar(
//                                     content: Text(
//                                         report.jotformTestDclCode.toString() +
//                                             ": " +
//                                             apiresult2.toString())));
//                               },
//                               child: Text("Positive"),
//                             ),
//                             TextButton(
//                               style: TextButton.styleFrom(
//                                   primary: Colors.white,
//                                   backgroundColor: Colors.purple[400]),
//                               onPressed: () async {
//                                 print("Negative");

//                                 apiresult2 =
//                                     await sendResult(report, token, "NEGATIVE");
//                                 Scaffold.of(context).showSnackBar(SnackBar(
//                                     content: Text(
//                                         report.jotformTestDclCode.toString() +
//                                             ": " +
//                                             apiresult2.toString())));
//                               },
//                               child: Text("Negative"),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     // child: Column(
//                     //   children: <Widget>[
//                     //     // Text("data : " +
//                     //     //     model.reports![index].patient.toString()),
//                     //     Container(
//                     //         height: MediaQuery.of(context).size.height * 0.1,
//                     //         child: dclCard(model.reports![index], token)),
//                     //   ],
//                     // ),
//                   ),
//                 );
//               },
//             ),
//           );
//   }
// }

// Widget dclWidget() {
//   return Center(
//     child: isLoading
//         ? CircularProgressIndicator()
//         : ListView.builder(
//             itemCount: dclCodeList.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(dclCodeList[index]),
//               );
//             }),
//   );
// }

// Widget dclWidget() {
//   return Center(
//     child: isLoading
//         ? CircularProgressIndicator()
//         : Expanded(
//             child: ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   var report = dclModel.reports![index];
//                   var newresult = report.result.toString();
//                   newresult = newresult.replaceAll("Result.", "");

//                   return ListTile(
//                     tileColor:
//                         newresult == "POSITIVE" || newresult == "NEGATIVE"
//                             ? Colors.deepOrange[200]
//                             : Colors.cyan[50],
//                     trailing: Row(
//                       children: [],
//                     ),
//                     title: Column(
//                       children: [
//                         Text(dclCodeList[index]),
//                         Text(newresult),
//                       ],
//                     ),
//                   );
//                 }),
//           ),
//   );
// }

// Future<bool> _loadMore() async {
//   print("onLoadMore");
//   await Future.delayed(Duration(seconds: 0, milliseconds: 100));
//   load();
//   return true;
// }

// void load() {
//   print("load");
//   setState(() {
//     // list.addAll(List.generate(10, (v) => v));
//     // print("data count = ${list.length}");
//   });
// }

// Future<void> _refresh() async {
//   await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
//   // list.clear();
//   load();
// }
}
