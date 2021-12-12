// To parse this JSON data, do
//
//     final dclModel = dclModelFromMap(jsonString);

import 'dart:convert';

DclModel dclModelFromMap(String str) => DclModel.fromMap(json.decode(str));

String dclModelToMap(DclModel data) => json.encode(data.toMap());

class DclModel {
  DclModel({
    this.isError,
    this.reports,
  });

  bool? isError;
  List<Report>? reports;

  factory DclModel.fromMap(Map<String, dynamic> json) => DclModel(
        isError: json["isError"],
        reports:
            List<Report>.from(json["reports"].map((x) => Report.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "isError": isError,
        "reports": List<dynamic>.from(reports!.map((x) => x.toMap())),
      };
}

class Report {
  Report({
    this.id,
    this.createdUser,
    this.lastUser,
    this.patientId,
    this.pdfName,
    this.pdfPath,
    this.cliId,
    this.reqId,
    this.dob,
    this.sex,
    this.addressFull,
    this.patient,
    this.patientEmail,
    this.phone,
    this.collectionDate,
    this.reportDate,
    this.test,
    this.result,
    this.flag,
    this.jotformId,
    this.jotformSubmissionId,
    this.jotformSubmissionDate,
    this.jotformTestDclCode,
    this.status,
    this.countSend,
    this.lastSend,
    this.isDeleted,
    this.deletedAt,
    this.createdTime,
    this.siteCode,
    this.siteLocation,
    this.created,
    this.v,
  });

  String? id;
  String? createdUser;
  String? lastUser;
  String? patientId;
  String? pdfName;
  String? pdfPath;
  CliId? cliId;
  String? reqId;
  String? dob;
  Sex? sex;
  String? addressFull;
  String? patient;
  String? patientEmail;
  String? phone;
  String? collectionDate;
  String? reportDate;
  Test? test;
  Result? result;
  Flag? flag;
  String? jotformId;
  String? jotformSubmissionId;
  DateTime? jotformSubmissionDate;
  String? jotformTestDclCode;
  int? status;
  int? countSend;
  String? lastSend;
  bool? isDeleted;
  dynamic deletedAt;
  String? createdTime;
  dynamic siteCode;
  String? siteLocation;
  DateTime? created;
  int? v;

  factory Report.fromMap(Map<String, dynamic> json) => Report(
        id: json["_id"],
        createdUser: json["createdUser"] == null ? null : json["createdUser"],
        lastUser: json["lastUser"] == null ? null : json["lastUser"],
        patientId: json["patientId"],
        pdfName: json["pdfName"] == null ? null : json["pdfName"],
        pdfPath: json["pdfPath"] == null ? null : json["pdfPath"],
        cliId: json["cliID"] == null ? null : cliIdValues.map![json["cliID"]],
        reqId: json["reqID"] == null ? null : json["reqID"],
        dob: json["dob"] == null ? null : json["dob"],
        sex: sexValues.map![json["sex"]],
        addressFull: json["address_full"] == null ? null : json["address_full"],
        patient: json["patient"],
        patientEmail: json["patientEmail"],
        phone: json["phone"],
        collectionDate:
            json["collectionDate"] == null ? null : json["collectionDate"],
        reportDate: json["reportDate"] == null ? null : json["reportDate"],
        test: json["test"] == null ? null : testValues.map![json["test"]],
        result:
            json["result"] == null ? null : resultValues.map![json["result"]],
        flag: json["flag"] == null ? null : flagValues.map![json["flag"]],
        jotformId: json["jotform_id"],
        jotformSubmissionId: json["jotform_submission_id"],
        jotformSubmissionDate: DateTime.parse(json["jotform_submission_date"]),
        jotformTestDclCode: json["jotform_test_dcl_code"],
        status: json["status"],
        countSend: json["count_send"],
        lastSend: json["last_send"] == null ? null : json["last_send"],
        isDeleted: json["isDeleted"],
        deletedAt: json["deletedAt"],
        createdTime: json["createdTime"] == null ? null : json["createdTime"],
        siteCode: json["site_code"],
        siteLocation: json["site_location"],
        created: DateTime.parse(json["created"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "createdUser": createdUser == null ? null : createdUser,
        "lastUser": lastUser == null ? null : lastUser,
        "patientId": patientId,
        "pdfName": pdfName == null ? null : pdfName,
        "pdfPath": pdfPath == null ? null : pdfPath,
        "cliID": cliId == null ? null : cliIdValues.reverse[cliId],
        "reqID": reqId == null ? null : reqId,
        "dob": dob == null ? null : dob,
        "sex": sexValues.reverse[sex],
        "address_full": addressFull == null ? null : addressFull,
        "patient": patient,
        "patientEmail": patientEmail,
        "phone": phone,
        "collectionDate": collectionDate == null ? null : collectionDate,
        "reportDate": reportDate == null ? null : reportDate,
        "test": test == null ? null : testValues.reverse[test],
        "result": result == null ? null : resultValues.reverse[result],
        "flag": flag == null ? null : flagValues.reverse[flag],
        "jotform_id": jotformId,
        "jotform_submission_id": jotformSubmissionId,
        "jotform_submission_date": jotformSubmissionDate!.toIso8601String(),
        "jotform_test_dcl_code": jotformTestDclCode,
        "status": status,
        "count_send": countSend,
        "last_send": lastSend == null ? null : lastSend,
        "isDeleted": isDeleted,
        "deletedAt": deletedAt,
        "createdTime": createdTime == null ? null : createdTime,
        "site_code": siteCode,
        "site_location": siteLocation,
        "created": created!.toIso8601String(),
        "__v": v,
      };
}

enum CliId { THE_14_D0988472 }

final cliIdValues = EnumValues({"14D0988472": CliId.THE_14_D0988472});

enum Flag { NORMAL, ABNORMAL }

final flagValues =
    EnumValues({"ABNORMAL": Flag.ABNORMAL, "NORMAL": Flag.NORMAL});

enum Result { NEGATIVE, POSITIVE }

final resultValues =
    EnumValues({"NEGATIVE": Result.NEGATIVE, "POSITIVE": Result.POSITIVE});

enum Sex { MALE, FEMALE }

final sexValues = EnumValues({"Female": Sex.FEMALE, "Male": Sex.MALE});

enum Test { ANTIGEN_COVID_19_SARS_COV19_NP }

final testValues = EnumValues(
    {"ANTIGEN COVID-19 SARS-COV19 - NP": Test.ANTIGEN_COVID_19_SARS_COV19_NP});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
