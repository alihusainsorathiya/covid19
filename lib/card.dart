import 'dart:convert';
import 'dart:math';
import 'package:covid19/dcl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

// import 'pacakges:instant/instant.dart';
String apiresult2 = "";
Widget dclCard(Report? report, String token) => Card(
    elevation: 4.0,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("DCL: " + report!.jotformTestDclCode.toString()),
          Text("Gender: " + report.sex.toString()),
          Text("Name: " + report.patient.toString()),
          Text("Email: " + report.patientEmail.toString()),
          Text("DOB: " + report.dob.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.pink,
                  ),
                  onPressed: () async {
                    print("Positive");
                    apiresult2 = await sendResult(report, token, "POSITIVE");
                    apiresult2 = apiresult2 + "POSITIVE";
                  },
                  child: Text("Positive")),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.pink,
                ),
                onPressed: () async {
                  print("Negative");

                  apiresult2 = await sendResult(report, token, "NEGATIVE");
                  apiresult2 = apiresult2 + "POSITIVE";
                },
                child: Text("Negative"),
              ),
              Text(apiresult2.toString()),
            ],
          )
        ],
      ),
    ));

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
