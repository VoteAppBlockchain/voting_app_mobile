import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app_mobile/http/vote_http.dart';

class Vote extends StatefulWidget {
  @override
  _VoteState createState() => _VoteState();
}

class _VoteState extends State<Vote> {
  int selectedCandidateIndex = -1;

  // List<String> candidates = ["Candidate 1", "Candidate 2", "Candidate 3"];
  VoteHttp voteHttp = new VoteHttp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Vote"),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  "Welcome to Elections!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Container(
                child: FutureBuilder<Map<String, dynamic>>(
                    future: voteHttp.getCandidates(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> candidates = [];

                        for (var k in snapshot.data.keys) {
                          candidates.add(snapshot.data[k]);
                        }
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: candidates.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15)),
                                  elevation: 5,
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 30, 15, 0),
                                  color: selectedCandidateIndex == index
                                      ? Colors.blue
                                      : Colors.red,
                                  child: ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(
                                      candidates[index],
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight:
                                              selectedCandidateIndex == index
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedCandidateIndex == index
                                            ? selectedCandidateIndex = -1
                                            : selectedCandidateIndex = index;
                                      });
                                    },
                                  ));
                            });
                      } else {
                        return Center();
                      }
                    }),
              ),
              SizedBox(
                height: 5,
              ),
              MaterialButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10)),
                height: 50,
                color: Colors.green,
                child: Text(
                  'Vote',
                  style: TextStyle(color: Colors.black87, fontSize: 20.0),
                ),
                onPressed: () {
                  // TODO Call vote function
                },
              ),
            ],
          ),
        ));
  }
}
