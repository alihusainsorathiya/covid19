import 'package:covid19/dcl.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class NameSearch extends SearchDelegate<DclModel> {
  final List<Report> dclModelList;

  String token;
  NameSearch(this.token, this.dclModelList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var suggestions = dclModelList.where((element) {
      // DclModel dclModel = DclModel();
      return dclModelList.contains(element);
    });

    return dclWidget(token, suggestions);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestions = dclModelList.where((element) {
      // DclModel dclModel = DclModel();
      return dclModelList.contains(element);
    });

    return dclWidget(token, suggestions);
  }

  Widget dclWidget(String token, Iterable<Report> suggestions) {
    debugPrint(suggestions.length.toString());
    return Expanded(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        // itemCount: model.reports!.length,
        shrinkWrap: true,
        //                   var newresult = report.result.toString();
        //                   newresult = newresult.replaceAll("Result.", "");
        itemCount: suggestions.length,
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
                        apiresult2 =
                            await sendResult(report, token, "POSITIVE");
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

                        apiresult2 =
                            await sendResult(report, token, "NEGATIVE");
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
