import 'package:flutter/material.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/utils/utils_text_progress_page.dart';
import 'package:washing_love/utils/utils_theme.dart';

// detailer all jobs widget
class TaskPageDetailer extends StatefulWidget {
  @override
  _TaskPageDetailerState createState() => _TaskPageDetailerState();
}

class _TaskPageDetailerState extends State<TaskPageDetailer> {
  List<dynamic> upcoming = [];
  List<dynamic> ongoing = [];
  List<dynamic> pending = [];
  List<dynamic> history = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var upcomingRes = await CallApi(context).getAllUpcoming();
    var ongoingRes = await CallApi(context).getAllOngoing();
    var pendingRes = await CallApi(context).getAllPending();
    var historyRes = await CallApi(context).getAllHistory();

    setState(() {
      upcoming = upcomingRes;
      ongoing = ongoingRes;
      pending = pendingRes;
      history = historyRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            ProgressPageHeaderTextUtils(text: 'Pending jobs'),
            _buildListView(pending, 'Pending', Colors.yellow),
            ProgressPageHeaderTextUtils(text: 'Ongoing jobs'),
            _buildListView(ongoing, 'Ongoing', Colors.green),
            ProgressPageHeaderTextUtils(text: 'Upcoming jobs'),
            _buildListView(upcoming, 'Upcoming', Colors.blue),
            ProgressPageHeaderTextUtils(text: 'Completed jobs'),
            _buildListView(history, 'Completed', Colors.brown),
          ],
        ),
      ),
    ));
  }

  _buildListView(List<dynamic> list, String state, Color color) {
    return list.length <= 0
        ? Container(
            height: 50,
            child: Center(
              child: Text(
                'No ' + state + ' jobs',
                style: TextStyle(fontSize: 10),
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (BuildContext context, int i2) =>
                  SizedBox(height: 10),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(list[index][5] + ' ' + list[index][6],
                              style: TextStyle(
                                  color: AppColors.color('90A0B2'),
                                  fontSize: 12))
                        ],
                      ),
                      //Todo Box
                      Container(
                          padding: EdgeInsets.only(
                            left: 5.0,
                            bottom: 5.0,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  //Todo left user colume
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://i.pinimg.com/originals/26/f6/c8/26f6c82178cdaacf100fb20358124318.jpg'),
                                                  fit: BoxFit.cover)),
                                        ),
                                        SizedBox(height: 5.0),
                                      ],
                                    ),
                                  ),
                                  //Todo right delivery column
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 110,
                                      margin: EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  height: 18,
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    list[index][3],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                margin:
                                                    const EdgeInsets.all(3.0),
                                                color: color,
                                                child: Text(
                                                  state,
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                              height: 25,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                list[index][2],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              )),
                                          Container(
                                              height: 18,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                list[index][1],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              )),
                                          Container(
                                              height: 18,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                list[index][4],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              )),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              if (state == 'Pending')
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RaisedButton(
                                        onPressed: () async {
                                          accept(context, list[index][0]);
                                        },
                                        color: AppColors.color('2196F3'),
                                        child: Text(
                                          'Approve',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )),
                                    RaisedButton(
                                        onPressed: () async {
                                          reject(context, list[index][0]);
                                        },
                                        color: Colors.red,
                                        child: Text(
                                          'Reject',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )),
                                  ],
                                ),
                              if (state == 'Ongoing')
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RaisedButton(
                                        onPressed: () async {
                                          complete(context, list[index][0]);
                                        },
                                        color: AppColors.color('2196F3'),
                                        child: Text(
                                          'Complete',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )),
                                  ],
                                )
                            ],
                          )),
                    ],
                  ),
                );
              },
            ),
          );
  }

  accept(BuildContext context, String id) {
    Widget cancelButton = FlatButton(
      child: Text("OK"),
      onPressed: () async {
        Navigator.of(context).pop();
        await CallApi(context).updateStatusOfBooking(id, 'PROCESSING');
        getData();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Confirm'),
      content: Text('Are you sure to approve booking?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  reject(BuildContext context, String id) {
    Widget cancelButton = FlatButton(
      child: Text("OK"),
      onPressed: () async {
        Navigator.of(context).pop();
        await CallApi(context).updateStatusOfBooking(id, 'REJECTED');
        getData();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Confirm'),
      content: Text('Are you sure to reject booking?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  complete(BuildContext context, String id) {
    Widget cancelButton = FlatButton(
      child: Text("OK"),
      onPressed: () async {
        Navigator.of(context).pop();
        await CallApi(context).updateStatusOfBooking(id, 'COMPLETED');
        getData();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Confirm'),
      content: Text('Are you sure to complete booking?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
