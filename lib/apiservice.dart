import 'dart:convert';
import 'dart:math';

import 'package:covid19/dcl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Apiservice {
  List<Report> data = [];
  DclModel results = DclModel();
  List<Report> result2 = [];
  List<Report> rep = [];
  String token = "";
  getToken(String username, password) async {
    String loginurl = 'https://dlcserver.xyz/api/v1/auth/login';
    // var credentials = {"username": "algonquin", "password": "QV2658rapids"};
    var credentials = {"username": username, "password": password};

    var response = await http.post(Uri.parse(loginurl),
        body: jsonEncode(credentials),
        headers: {'Content-Type': 'application/json'});
    debugPrint(response.body.toString());
    debugPrint(response.statusCode.toString());

    // await Future.delayed(Duration(seconds: 2));
    // list = jsonDecode(response.body);
    token = jsonDecode(response.body)['token'].toString();
    print("inside API Call: " + token.toString());
    return token;
    // return token;

    // getdclData(token);
  }

  Future<List<Report>> getdclData(String token) async {
    String dataurl =
        "https://dlcserver.xyz/api/v1/jotform/getbetween/" + getDate();
    print("Data url:" + dataurl.toString());

    var response = await http.get(Uri.parse(dataurl), headers: {
      'x-auth-token': '${token.toString()}',
      'Content-Type': 'application/json',
    });

    debugPrint("GetData : " + response.statusCode.toString());
    try {
      if (response.statusCode == 200) {
        print("inside");
        // data = json.decode(response.body);
        // print(data[0]);

        // result2 = data.map((e) => DclModel.fromJson(json.decode(response.body);
        // result2 = Report.fromJson(response.body.);
        // print("abc: " + dclModelFromJson(response.body).reports![0].toString());
        results = dclModelFromMap(response.body);
        // print(results.reports![0].toString());
        // result2.addAll(results.reports!);

        // var jsonData = json.decode(response.body);

        // for (var u in jsonData) {
        //   Report reportz = Report(
        //     id: u['_id'],
        //     addressFull: u["address_full"],
        //     cliId: u["cliID"],
        //     collectionDate: u["collectionDate"],
        //     countSend: u["count_send"],
        //     created: u["created"],
        //     createdTime: u["createdTime"],
        //     createdUser: u["createdUser"],
        //     deletedAt: u["deletedAt"],
        //     dob: u["dob"],
        //     flag: u["flag"],
        //     isDeleted: u["isDeleted"],
        //     jotformId: u["jotform_id"],
        //     jotformSubmissionDate: u["jotform_submission_date"],
        //     jotformSubmissionId: u["jotform_submission_id"],
        //     jotformTestDclCode: u["jotform_test_dcl_code"],
        //     lastSend: u["last_send"],
        //     lastUser: u["lastUser"],
        //     patient: u["patient"],
        //     patientEmail: u["patientEmail"],
        //     patientId: u["patientId"],
        //     pdfName: u["pdfName"],
        //     pdfPath: u["pdfPath"],
        //     phone: u["phone"],
        //     reportDate: u["reportDate"],
        //     reqId: u["reqID"],
        //     result: u["result"],
        //     sex: u["sex"],
        //     status: u["status"],
        //     test: u["test"],
        //     v: u["__v"],
        //   );
        //   rep.add(reportz);
        // }

        result2 = results.reports!.toList();
        print("results: ${result2[0].toString()}");
        // results = data.map((e) => DclModel.fromJson(e)).toList();

        // result2 = dclModelFromJson(response.body).reports!.toList();

        // results = dclModelFromJson(data);
        print("Get New Data : " + result2.length.toString());
      } else {
        print("Api Error");
      }
    } on Exception catch (e) {
      print("Error: $e");
    }
    return result2;
  }

  String getDate() {
    var now1 = new DateTime.now();
    var formatter = new DateFormat('yyyy/MM/dd');
    String formattedDate = formatter.format(now1);
    // formattedDate = '2021/12/10';
    return formattedDate;
  }

  String getUSADate() {
    // tz.initializeTimeZones();
    // var locations = tz.timeZoneDatabase.locations;

    // DateTime time;
    // tz.TZDateTime usatzdatetime;

    // final DateTime now = DateTime.now();
    // final cstTimezone = tz.getLocation('America/Guatemala');
    // // DateTime usatzdatetime = tz.TZDateTime.from(now, cstTimezone);
    // usatzdatetime = tz.TZDateTime.from(now, cstTimezone);

    DateTime usDate = getUSDATE();
    var formatter = new DateFormat('yyyy/MM/dd');
    String formattedDate = formatter.format(usDate);

    print("USA DATE: " + formattedDate.toString());
    return formattedDate.toString();
  }

  DateTime getUSDATE() {
    tz.initializeTimeZones();
    // var locations = tz.timeZoneDatabase.locations;

    DateTime time;
    tz.TZDateTime usatzdatetime;

    final DateTime now = DateTime.now();
    final cstTimezone = tz.getLocation('America/Guatemala');
    // DateTime usatzdatetime = tz.TZDateTime.from(now, cstTimezone);
    usatzdatetime = tz.TZDateTime.from(now, cstTimezone);

    return usatzdatetime;
  }

  sendResult(Report report, String token, String result) async {
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
    // String sex = report!.sex.toString();
    String sex = report.sex.toString();
    sex = sex.replaceAll("Sex.", "");
    var payload = {
      // "_id": report.sId.toString(),
      "_id": report.id.toString(),
      "createdUser": report.createdUser.toString(),
      "patientId": report.patientId.toString(),
      "pdfName": report.pdfName.toString(),
      "pdfPath": report.pdfPath.toString(),
      // "cliID": report.cliID.toString(),
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
      "site_location": report.siteLocation.toString(),
      "site_code": report.siteCode.toString(),
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
}
