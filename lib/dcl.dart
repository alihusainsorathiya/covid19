// To parse this JSON data, do
//
//     final dclModel = dclModelFromJson(jsonString?);

import 'dart:convert';

DclModel dclModelFromJson(String? str) => DclModel.fromJson(json.decode(str!));

String? dclModelToJson(DclModel data) => json.encode(data.toJson());

class DclModel {
  DclModel({
    this.isError,
    this.reports,
  });

  bool? isError;
  List<Report>? reports;

  factory DclModel.fromJson(Map<String?, dynamic> json) => DclModel(
        isError: json["isError"] == null ? null : json["isError"],
        reports: json["reports"] == null
            ? null
            : List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "isError": isError == null ? null : isError,
        "reports": reports == null
            ? null
            : List<dynamic>.from(reports!.map((x) => x.toJson())),
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
  DateTime? created;
  int? v;

  factory Report.fromJson(Map<String?, dynamic> json) => Report(
        id: json["_id"] == null ? null : json["_id"],
        createdUser: json["createdUser"] == null ? null : json["createdUser"],
        lastUser: json["lastUser"] == null ? null : json["lastUser"],
        patientId: json["patientId"] == null ? null : json["patientId"],
        pdfName: json["pdfName"] == null ? null : json["pdfName"],
        pdfPath: json["pdfPath"] == null ? null : json["pdfPath"],
        cliId: json["cliID"] == null ? null : cliIdValues.map![json["cliID"]],
        reqId: json["reqID"] == null ? null : json["reqID"],
        dob: json["dob"] == null ? null : json["dob"],
        sex: json["sex"] == null ? null : sexValues.map![json["sex"]],
        addressFull: json["address_full"] == null ? null : json["address_full"],
        patient: json["patient"] == null ? null : json["patient"],
        patientEmail:
            json["patientEmail"] == null ? null : json["patientEmail"],
        phone: json["phone"] == null ? null : json["phone"],
        collectionDate:
            json["collectionDate"] == null ? null : json["collectionDate"],
        reportDate: json["reportDate"] == null ? null : json["reportDate"],
        test: json["test"] == null ? null : testValues.map![json["test"]],
        result:
            json["result"] == null ? null : resultValues.map![json["result"]],
        flag: json["flag"] == null ? null : flagValues.map![json["flag"]],
        jotformId: json["jotform_id"] == null ? null : json["jotform_id"],
        jotformSubmissionId: json["jotform_submission_id"] == null
            ? null
            : json["jotform_submission_id"],
        jotformSubmissionDate: json["jotform_submission_date"] == null
            ? null
            : DateTime?.parse(json["jotform_submission_date"]),
        jotformTestDclCode: json["jotform_test_dcl_code"] == null
            ? null
            : json["jotform_test_dcl_code"],
        status: json["status"] == null ? null : json["status"],
        countSend: json["count_send"] == null ? null : json["count_send"],
        lastSend: json["last_send"] == null ? null : json["last_send"],
        isDeleted: json["isDeleted"] == null ? null : json["isDeleted"],
        deletedAt: json["deletedAt"],
        createdTime: json["createdTime"] == null ? null : json["createdTime"],
        created:
            json["created"] == null ? null : DateTime?.parse(json["created"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String?, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "createdUser": createdUser == null ? null : createdUser,
        "lastUser": lastUser == null ? null : lastUser,
        "patientId": patientId == null ? null : patientId,
        "pdfName": pdfName == null ? null : pdfName,
        "pdfPath": pdfPath == null ? null : pdfPath,
        "cliID": cliId == null ? null : cliIdValues.reverse![cliId],
        "reqID": reqId == null ? null : reqId,
        "dob": dob == null ? null : dob,
        "sex": sex == null ? null : sexValues.reverse![sex],
        "address_full": addressFull == null ? null : addressFull,
        "patient": patient == null ? null : patient,
        "patientEmail": patientEmail == null ? null : patientEmail,
        "phone": phone == null ? null : phone,
        "collectionDate": collectionDate == null ? null : collectionDate,
        "reportDate": reportDate == null ? null : reportDate,
        "test": test == null ? null : testValues.reverse![test],
        "result": result == null ? null : resultValues.reverse![result],
        "flag": flag == null ? null : flagValues.reverse![flag],
        "jotform_id": jotformId == null ? null : jotformId,
        "jotform_submission_id":
            jotformSubmissionId == null ? null : jotformSubmissionId,
        "jotform_submission_date": jotformSubmissionDate == null
            ? null
            : jotformSubmissionDate!.toIso8601String(),
        "jotform_test_dcl_code":
            jotformTestDclCode == null ? null : jotformTestDclCode,
        "status": status == null ? null : status,
        "count_send": countSend == null ? null : countSend,
        "last_send": lastSend == null ? null : lastSend,
        "isDeleted": isDeleted == null ? null : isDeleted,
        "deletedAt": deletedAt,
        "createdTime": createdTime == null ? null : createdTime,
        "created": created == null ? null : created!.toIso8601String(),
        "__v": v == null ? null : v,
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
  Map<String?, T>? map;
  Map<T, String?>? reverseMap;

  EnumValues(this.map);

  Map<T, String?>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
