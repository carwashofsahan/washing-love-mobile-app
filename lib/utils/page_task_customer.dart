import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/models/user.dart';
import 'package:washing_love/models/washer.dart';
import 'package:washing_love/utils/utils_textform_field_normal.dart';
import 'package:washing_love/utils/utils_theme.dart';

// customer all jobs widget
class TaskPageCustomer extends StatefulWidget {
  @override
  _TaskPageCustomerState createState() => _TaskPageCustomerState();
}

class _TaskPageCustomerState extends State<TaskPageCustomer> {
  List<dynamic> pending = [];
  List<dynamic> processing = [];
  List<dynamic> completed = [];
  List<dynamic> rejected = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var pendingRes =
        await CallApi(context).getBookingsByUserIdAndStatus('PENDING');
    var processingRes =
        await CallApi(context).getBookingsByUserIdAndStatus('PROCESSING');
    var completedRes =
        await CallApi(context).getBookingsByUserIdAndStatus('COMPLETED');
    var rejectedRes =
        await CallApi(context).getBookingsByUserIdAndStatus('REJECTED');

    setState(() {
      pending = pendingRes;
      processing = processingRes;
      completed = completedRes;
      rejected = rejectedRes;
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
            _buildListView(pending, 'Pending', Colors.yellow, context),
            _buildListView(processing, 'Processing', Colors.blue, context),
            _buildListView(completed, 'Completed', Colors.green, context),
            _buildListView(rejected, 'Rejected', Colors.red, context),
          ],
        ),
      ),
    ));
  }

  _buildListView(
      List<dynamic> list, String state, Color color, BuildContext bcontext) {
    return Container(
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
                //todo header date time
                Row(
                  children: [
                    Text(list[index][2] + ' ' + list[index][3],
                        style: TextStyle(
                            color: AppColors.color('90A0B2'), fontSize: 12))
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
                    child: Row(
                      children: [
                        //Todo left user colume
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://asset.quotientapp.com/image/quote-example/file/car-detailing-04-large.jpg'),
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
                            height: 120,
                            margin: EdgeInsets.only(left: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 5.0),
                                Container(
                                    height: 25,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      list[index][5],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                    height: 25,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Type: ' + list[index][4],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    )),
                                Container(
                                    height: 25,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Package: ' + list[index][7],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 15,
                                      alignment: Alignment.topLeft,
                                      child: Text(list[index][6]),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (state == 'Completed' && !list[index][9])
                                      InkWell(
                                        onTap: () {
                                          rateDialog(bcontext, list[index][0],
                                              list[index][8]);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(3.0),
                                          margin: const EdgeInsets.all(3.0),
                                          color: AppColors.color('FFD54F'),
                                          child: Text(
                                            'Rate us',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    if (list[index][9])
                                      Container(
                                        padding: const EdgeInsets.all(3.0),
                                        margin: const EdgeInsets.all(3.0),
                                        color: AppColors.color('FFD54F'),
                                        child: Text(
                                          'Thank for rating us',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    Container(
                                      padding: const EdgeInsets.all(3.0),
                                      margin: const EdgeInsets.all(3.0),
                                      color: color,
                                      child: Text(
                                        state,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
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

  rateDialog(BuildContext context, String id, String washCenterId) {
    int ratingSel = 1;
    final reviewController = TextEditingController();

    Widget cancelButton = FlatButton(
      child: Text("OK"),
      onPressed: () async {
        Navigator.of(context).pop();
        await CallApi(context).addRating(
            id,
            new WashCenter(id: washCenterId, user: new User(id: '0')),
            reviewController.text,
            ratingSel);
        getData();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Rate Us'),
      content: Container(
        height: 220,
        child: Column(
          children: [
            Text('How do you feel about our service!'),
            RatingBar(
              onRatingChanged: (rating) =>
                  setState(() => ratingSel = rating.ceil()),
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              isHalfAllowed: false,
              filledColor: Colors.amber[300],
              emptyColor: Colors.black,
              size: 30,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormFieldNormalUtils(
              textLabel: "Review",
              controller: reviewController,
              isPhonekey: false,
              lines: 4,
            ),
          ],
        ),
      ),
      actions: [
        cancelButton,
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
