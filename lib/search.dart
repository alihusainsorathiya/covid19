import 'dart:html';

import 'package:covid19/dcl.dart';
import 'package:flutter/material.dart';
import 'apiservice.dart';
import 'homepage.dart';

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
    return Expanded(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        // itemCount: model.reports!.length,
        shrinkWrap: true,
        //                   var newresult = report.result.toString();
        //                   newresult = newresult.replaceAll("Result.", "");
        itemCount: length,
        itemBuilder: (context, index) {
          var report = suggestions.elementAt(index);

          // var report = report1.reports![index];
          // debugPrint(report.jotformTestDclCode);
          // var reportsList = dclSnap.data[index];
          // var report = model.reports![index];
          // dclList.add(dclModel.reports.dc.toString());

          var newresult = report.result.toString();
          newresult = newresult.replaceAll("Result.", "");
          // height: MediaQuery.of(context).size.height * 0.125,
          return Card(
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
                        apiresult2 = await Apiservice()
                            .sendResult(report, token, "POSITIVE");
                        // apiresult2 = " SENT POSITIVE";

                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(report.jotformTestDclCode.toString() +
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

                        apiresult2 = await Apiservice()
                            .sendResult(report, token, "NEGATIVE");
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(report.jotformTestDclCode.toString() +
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
          );
        },
      ),
    );
  }
}
