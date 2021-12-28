import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/models/review_rating.dart';
import 'package:washing_love/models/washer.dart';
import 'package:washing_love/utils/utils_theme.dart';

// reviews page
class Reviews extends StatefulWidget {
  final WashCenter washCenter;

  Reviews({this.washCenter});

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.now());

  final _formKey = GlobalKey<FormState>();

  List<ReviewRating> reviews = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var res = await CallApi(context).getAllReviews(widget.washCenter.id);

    setState(() {
      reviews = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            // color: AppColors.color('FFD54F'),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://admin.idaoffice.org/wp-content/uploads/2018/11/%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%B0%D1%8F-5-1000x550.jpg"),
                    fit: BoxFit.cover)),
            height: 180,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Washing Love',
                    style: TextStyle(fontSize: 20, color: Colors.pink, fontWeight: FontWeight.bold)),
                Text('${widget.washCenter.name}',
                    style: TextStyle(fontSize: 35, color: Colors.pink, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        color: Colors.amber[300],
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Go Back to Booking')),
                  ],
                )
              ],
            )),
          ),
          SizedBox(
            height: 5,
            child: Container(
              color: AppColors.color('2196F3'),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 24),
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reviews[index].customer.firstname +
                                ' ' +
                                reviews[index].customer.lastname,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              RatingBar(
                                onRatingChanged: (rating) => setState(() => {}),
                                initialRating: reviews[index].rating + 0.0,
                                filledIcon: Icons.star,
                                emptyIcon: Icons.star_border,
                                isHalfAllowed: false,
                                filledColor: Colors.amber[300],
                                emptyColor: Colors.black,
                                size: 20,
                              ),
                            ],
                          ),
                          Text(
                            reviews[index].review,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
