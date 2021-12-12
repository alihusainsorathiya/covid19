// import 'dart:html';

import 'package:covid19/dcl.dart';
import 'package:flutter/material.dart';
import 'apiservice.dart';
// import 'homepage.dart';

class NameSearch extends SearchDelegate<Report> {
  final List<Report> dclModelList;

  String token;
  NameSearch(this.token, this.dclModelList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // var suggestions;
    // var suggestions = dclModelList.where((element) {
    //   // DclModel dclModel = DclModel();
    //   return dclModelList.contains(element);
    var suggestions;
    // for (int i = 0; i < dclModelList.length; i++) {
    //   suggestions[i] = dclModelList
    //       .where((element) =>
    //           element.reports![i].jotformTestDclCode!.contains(query))
    //       .toList();
    suggestions = dclModelList
        .where((element) => element.jotformTestDclCode!.contains(query))
        .toList();

    //  return suggestions;
    // .where((element) => dclModelList.reports!.contains(element));
    // });
    // var reports = [];
    // dclModelList.forEach((element) {
    //   reports = element.reports!;
    // });

    //   var abc = reports
    //       .where((element2) => element2.jotformTestDclCode!.contains(query))
    //       .toList();

    //   return abc;
    // });

    // final suggestions = dclModelList!.where((element) => (element.reports!.where((element2) => element2.jotformTestDclCode.toUpperCase().contains(query))));

    // final suggestions = dclModelList!.where((element) => element
    //     .reports!.where((element) => element.jotformTestDclCode.toUpperCase().contains(query));

    // return dclWidget(token, suggestions);

    return dclWidget(token, suggestions, suggestions.length);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // var suggestions = dclModelList.where((element) {
    //   return dclModelList.contains(element);
//  });

    // final suggestions = dclModelList.reports!
    //     .where((element) => dclModelList.reports!.contains(element));

    // final suggestions = dclModelList.where((element) => dclModelList.contains(
    //     element.reports!.where((element) =>
    //         element.jotformTestDclCode!.toUpperCase().contains(query))));

    var suggestions;
    for (int i = 0; i < dclModelList.length; i++) {
      // suggestions[i] = dclModelList
      //     .where((element) =>
      //         element.reports![i].jotformTestDclCode!.contains(query))
      //     .toList();

      suggestions = dclModelList
          .where((element) => element.jotformTestDclCode!.contains(query))
          .toList();
    }
    return dclWidget(token, suggestions, suggestions.length);
  }

  Widget dclWidget(String token, Iterable<Report> suggestions, int length) {
    debugPrint(suggestions.length.toString());
    var apiresult2;

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        var report = suggestions.elementAt(index);
        // var report = reports[index];
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
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    Text("${report.patient.toString()}",
                        style: report.patient.toString().length > 15
                            ? report.patient.toString().length > 20
                                ? TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.w600)
                                : TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w600)
                            : TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600)),
                    Text(
                      "${report.patientEmail.toString()}",
                      style: report.patientEmail.toString().length > 20
                          ? TextStyle(
                              fontSize: 8,
                            )
                          : TextStyle(
                              fontSize: 9,
                            ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        "SITE: " + "${report.siteLocation.toString()}",
                        style: report.patientEmail.toString().length > 20
                            ? report.patient.toString().length > 30
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
                        Apiservice().sendResult(report, token, "POSITIVE");

                    apiresult2 =
                        "${report.jotformTestDclCode.toString() + "POSITIVE"}" +
                            apiresult2;

//                                 Scaffold.of(context).showSnackBar(SnackBar(
//                                     content: Text(
//                                         report.jotformTestDclCode.toString() +
//                                             ": " +
//                                             apiresult2.toString())));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(apiresult2)));
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
                        style: TextStyle(color: Colors.white, fontSize: 10),
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
                    apiresult2 =
                        Apiservice().sendResult(report, token, "NEGATIVE");
                    apiresult2 =
                        "${report.jotformTestDclCode.toString() + "NEGATIVE"}" +
                            apiresult2;

                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(apiresult2)));
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
                        style: TextStyle(color: Colors.white, fontSize: 10),
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
}
