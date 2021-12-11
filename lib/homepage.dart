import 'dart:convert';
import 'dart:developer';
// import 'dart:ffi';
import 'dart:io';

import 'package:covid19/dcl.dart';
import 'package:covid19/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'dart:math';

// import 'card.dart';

String loginurl = 'https://dlcserver.xyz/api/v1/auth/login';
// Map cred = {"username": "algonquin", "password": "QV2658rapids"};
String apiresult2 = "";

class Homepage extends StatefulWidget {
  http.Client client = new http.Client(); // create a client to make api calls

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var token;
  // List<String> dclCodeList = <String>[];
  // List<String> filteredList = <String>[];
  bool isLoading = false;

  DclModel dclModel = DclModel();

  List<Report> searchList = [];
  // List<int> list = [];
  // int get count => list.length;

  // List<String> dclCodes = [];

  var reports;
  int reportsLength = 0;
  var credentials = {"username": "algonquin", "password": "QV2658rapids"};
  bool loading1 = false, allLoaded = false;
  TextEditingController editingController = TextEditingController();
  // var dclList = <String>[];

  getDate() {
    var now1 = new DateTime.now();
    var formatter = new DateFormat('yyyy/MM/dd');
    String formattedDate = formatter.format(now1);
    formattedDate = '2021/12/08';
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();

    getRes();
  }

  bool isLoadig = false;
  getRes() async {
    setState(() {
      isLoading = true;
    });

    var response = await http.post(Uri.parse(loginurl),
        body: jsonEncode(credentials),
        headers: {'Content-Type': 'application/json'});
    debugPrint(response.body.toString());
    debugPrint(response.statusCode.toString());
    // await Future.delayed(Duration(seconds: 2));
    // list = jsonDecode(response.body);
    token = jsonDecode(response.body)['token'].toString();
    token == null
        ? apiresult2 = "Not received Token ${response.statusCode.toString()}"
        : apiresult2 = "received Token ${response.statusCode.toString()}";

    // dclCodeList = dclList;
    setState(() {
      isLoadig = false;
    });
    getData();
    // return token;
  }

  Future<DclModel> getData() async {
    // await getRes();

    setState(() {
      isLoading = true;
    });
    // filteredList = <String>[];

    print("Token Received");
    // await getData();

    String dataurl =
        "https://dlcserver.xyz/api/v1/jotform/getbetween/" + getDate();
    print("Data url:" + dataurl.toString());

    var response = await http.get(Uri.parse(dataurl), headers: {
      'x-auth-token': '${token.toString()}',
      'Content-Type': 'application/json',
      // 'Connection': 'keep-alive'
    });

    // debugPrint(response.body.toString());
    debugPrint("GetData : " + response.statusCode.toString());
    // print("Length:" reports.length.toString());

    if (response.statusCode == 200) {
      // dclModel = dclModelFromJson((response.body));

      // searchList.addAll(dclModel as List<DclModel>);
      // searchList.addAll(dclModelFromJson(response.body) as List<DclModel>);
      //print("Length:" + response.body.toString());

      var jsonResponse = jsonDecode(response.body);
      // searchList = jsonResponse.map((e, f) => searchList.addAll(e)).toList();
      dclModel = dclModelFromJson(response.body);
      // // jsonResponse.forEach((element) {
      searchList.forEach((element) {
        searchList.add(element);
      });
      // //   searchList.add(element);
      // // });
      //   tempList.add(dclModel.reports![index].jotformTestDclCode
      //       .toString()
      //       .toUpperCase());
      // });
      // var reportz = jsonResponse['reports'];

      // for (var dcls in reportz) {}
      print("DCL MODEL Length :" + dclModel.reports!.length.toString());
      // for (int i = 0; i < dclModel.reports!.length; i++) {
      //   tempList[i] = dclModel.reports![i].jotformTestDclCode.toString();
      // }
      // DclModel searchModel = DclModel();

      // for (int i = 0; i < dclModel.reports!.length; i++) {
      // //   tempList[i] = dclModel.reports![i].jotformTestDclCode.toString();
      // // cardList[i] = dclModel.reports![i];

      // // filteredList.add(dclModel.reports![i].jotformTestDclCode.toString());
      // }
      // setState(() {
      //    dclCodeList = filteredList;
      // });
      // searchList.forEach((element) {
      // for (int i in dclModel) {
      //   searchList.add(dclModel[i]);
      // }
      // // dclModel.reports[]
      // print("templist :" + filteredList[0]);
      // debugPrint("Report length : " + filteredList.length.toString());
      // debugPrint("Report first: " +
      //     dclModel.reports![0].jotformTestDclCode.toString());
      setState(() {
        isLoading = false;
      });
      // print("SearchList:  " +
      //     searchList[0].reports![0].jotformTestDclCode.toString());
      return dclModel;

      // return jsonResponse.map((job) => new DclModel.fromJson(job)).toList();
    } else {
      return dclModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Covid19 App"),
        ),
      ),
      body: isLoadig == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(apiresult2),
                  // _searchBar(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: dclWidget(dclModel),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search_outlined),
        onPressed: () {
          showSearch(context: context, delegate: NameSearch(token, searchList));
        },
      ),
    );
  }

  Widget dclWidget(DclModel dclModel) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Expanded(
            child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              // itemCount: model.reports!.length,
              shrinkWrap: true,
              //                   var newresult = report.result.toString();
              //                   newresult = newresult.replaceAll("Result.", "");
              // itemCount: dclModel.reports!.length,
              itemCount: 2,
              itemBuilder: (context, index) {
                var report = dclModel.reports![index];
                // var reportsList = dclSnap.data[index];
                // var report = model.reports![index];
                // dclList.add(report.jotformTestDclCode.toString());

                var newresult = report.result.toString();
                newresult = newresult.replaceAll("Result.", "");
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.125,
                  child: Card(
                    margin: EdgeInsets.all(3),
                    color: newresult == "POSITIVE" || newresult == "NEGATIVE"
                        ? Colors.deepOrange[200]
                        : Colors.cyan[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment:
                          //     MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(report.jotformTestDclCode.toString()),
                                Text(newresult),
                                // Text(report.patientEmail.toString()),
                              ],
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.purple[400]),
                              onPressed: () async {
                                print("Positive");
                                apiresult2 =
                                    await sendResult(report, token, "POSITIVE");
                                // apiresult2 = " SENT POSITIVE";

                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        report.jotformTestDclCode.toString() +
                                            ": " +
                                            apiresult2.toString())));
                              },
                              child: Text("Positive"),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.purple[400]),
                              onPressed: () async {
                                print("Negative");

                                apiresult2 =
                                    await sendResult(report, token, "NEGATIVE");
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        report.jotformTestDclCode.toString() +
                                            ": " +
                                            apiresult2.toString())));
                              },
                              child: Text("Negative"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // child: Column(
                    //   children: <Widget>[
                    //     // Text("data : " +
                    //     //     model.reports![index].patient.toString()),
                    //     Container(
                    //         height: MediaQuery.of(context).size.height * 0.1,
                    //         child: dclCard(model.reports![index], token)),
                    //   ],
                    // ),
                  ),
                );
              },
            ),
          );
  }
}

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

sendResult(Report? report, String token, String result) async {
  tz.initializeTimeZones();
  var locations = tz.timeZoneDatabase.locations;

  DateTime time;
  tz.TZDateTime usatzdatetime;

  var randd_num = new Random();

  int randomNumber = (randd_num.nextInt(10000000) + 1 * 100000000000).floor();
  var reqId = randomNumber.toString();

  print("req ID : " + reqId.toString());
  String submitUrl = "https://dlcserver.xyz/api/v1/createpdf/new";
  String result2;
  String flag2;

  final DateTime now = DateTime.now();
  final cstTimezone = tz.getLocation('America/Guatemala');
  // DateTime usatzdatetime = tz.TZDateTime.from(now, cstTimezone);
  usatzdatetime = tz.TZDateTime.from(now, cstTimezone);

  // print("selected date: " + usatzdatetime.toString());

  String usatztime = usatzdatetime.toIso8601String().toString();

  String datestoSend = DateFormat("yyyy-MM-dd").format(usatzdatetime);
  debugPrint("datestoSend: " + datestoSend.toString());
  usatztime = usatztime.replaceAll("-0600", "Z");
  debugPrint("USA TIME: " + usatztime);

  // ignore: unnecessary_statements
  result == "POSITIVE"
      ? {result2 = "POSITIVE", flag2 = "ABNORMAL"}
      : {result2 = "NEGATIVE", flag2 = "NORMAL"};
  var timeOffset = "-6:00:00.000000";
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  String timetoSend = DateFormat('hh:mm a').format(DateTime.now());

  String submissionDate = (dateFormat.format(DateTime.now()).toString());
  String sex = report!.sex.toString();
  sex = sex.replaceAll("Sex.", "");
  var payload = {
    "_id": report.id.toString(),
    "createdUser": report.createdUser.toString(),
    "patientId": report.patientId.toString(),
    "pdfName": report.pdfName.toString(),
    "pdfPath": report.pdfPath.toString(),
    "cliID": report.cliId.toString(),
    "lastUser": report.lastUser.toString(),
    "reqID": reqId,
    "dob": report.dob.toString(),
    "sex": sex,
    "address_full": report.addressFull.toString(),
    "patient": report.patient.toString(),
    // "patientEmail": report.patientEmail.toString(),
    "patientEmail": "husain12121@gmail.com",

    "phone": report.phone.toString(),
    // "collectionDate": "2021-12-05",
    // "reportDate": "2021-12-05",
    "collectionDate": datestoSend,
    "reportDate": datestoSend,
    "test": "ANTIGEN COVID-19 SARS-COV19 - NP",
    "result": result2,
    "flag": flag2,
    "jotform_id": report.jotformId.toString(),
    "jotform_submission_id": report.jotformSubmissionId.toString(),
    // "jotform_submission_date": "2021-12-04 23:20:19",
    "jotform_submission_date": submissionDate,
    "jotform_test_dcl_code": report.jotformTestDclCode.toString(),
    "status": 1,
    "count_send": (report.countSend!.toInt() + 1).toString(),
    "last_send": report.lastSend.toString(),
    "isDeleted": report.isDeleted.toString(),
    "deletedAt": report.deletedAt.toString(),
    "createdTime": report.createdTime,
    // "created": "2021-12-05T04:20:28.006Z",
    "created": usatztime,
    "__v": 0,
    "locationId": "6110bc0c004d735e8420575c",
    // "time": "5:54 am"
    "time": timetoSend
  };

  debugPrint(payload.toString());
  var response = await http
      .post(Uri.parse(submitUrl), body: jsonEncode(payload), headers: {
    'Content-Type': 'application/json',
    'x-auth-token': '${token.toString()}',
  });

  // debugPrint(response.body.toString());
  // debugPrint(jsonDecode(response.body).toString());

  var submitResult = jsonDecode(response.body);
  debugPrint("SubmitResult:" + submitResult.toString());

  var message = jsonDecode(response.body)['msg'].toString();

  // var message = submitResult.toString();

  String apiResult = "msg:" + result2.toString() + message.toString();
  debugPrint("apiResult: " + apiResult);

  return apiResult;
  // debugPrint("msg:" + result2.toString() + message.toString());
}

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

