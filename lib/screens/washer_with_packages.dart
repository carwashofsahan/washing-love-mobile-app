import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/models/packages.dart';
import 'package:washing_love/models/review_rating.dart';
import 'package:washing_love/models/washer.dart';
import 'package:washing_love/screens/add_package.dart';
import 'package:washing_love/screens/add_service.dart';
import 'package:washing_love/screens/washer_reviews.dart';
import 'package:washing_love/utils/utils_text_progress_page.dart';
import 'package:washing_love/utils/utils_theme.dart';
import 'package:washing_love/utils/utils_textform_field_normal.dart';

// Washer with packages and booking page
class WasherWithPackages extends StatefulWidget {
  final WashCenter washCenter;
  WasherWithPackages({this.washCenter});

  @override
  _WasherWithPackagesState createState() => _WasherWithPackagesState();
}

class _WasherWithPackagesState extends State<WasherWithPackages> {
  Packages selectedPackage;
  bool showReviews = false;
  bool isDetailer = false;

  bool active = true;

  final vehicleNoController = TextEditingController();
  final specialNoteController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.now());

  final _formKey = GlobalKey<FormState>();

  List<ReviewRating> reviews = [];

  @override
  void initState() {
    if (widget.washCenter.packages.length > 0)
      selectedPackage = widget.washCenter.packages[0];
    getData();
    super.initState();
  }

  getData() async {
    var res = await CallApi(context).getAllReviews(widget.washCenter.id);
    var res2 = await CallApi(context).isDetailer();
    setState(() {
      reviews = res;
      isDetailer = res2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // color: AppColors.color('FFD54F'),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://carsguide-res.cloudinary.com/image/upload/f_auto%2Cfl_lossy%2Cq_auto%2Ct_default/v1/editorial/wash-zone-1001x565-%281%29.jpg"),
                      fit: BoxFit.cover)),
              height: 250,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Washing Love',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold)),
                  Flexible(
                    child: Text('${widget.washCenter.name}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, size: 13, color: Colors.pink),
                      SizedBox(
                        width: 15,
                      ),
                      Text('${widget.washCenter.city}',
                          style: TextStyle(fontSize: 13, color: Colors.pink, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_clock, size: 13, color: Colors.pink),
                      SizedBox(
                        width: 15,
                      ),
                      Text('${widget.washCenter.totalSlot} slots per day',
                          style: TextStyle(fontSize: 13, color: Colors.pink, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_copy_sharp,
                          size: 13, color: Colors.white),
                      SizedBox(
                        width: 15,
                      ),
                      Text('${widget.washCenter.packages.length} packages',
                          style: TextStyle(fontSize: 13, color: Colors.pink, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          color: Colors.amber[300],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reviews(
                                          washCenter: widget.washCenter,
                                        )));
                          },
                          child: Text('Reviews')),
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
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ProgressPageHeaderTextUtils(text: 'Packages'),
                  ],
                ),
                Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          widget.washCenter.packages.map((Packages packageVar) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedPackage = packageVar;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            padding: EdgeInsets.all(2.0),
                            width: 260,
                            decoration: BoxDecoration(
                                color: packageVar.id == selectedPackage.id
                                    ? Theme.of(context).accentColor
                                    : Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(
                                      left: 3.0,
                                      top: 3.0,
                                      bottom: 3.0,
                                      right: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://img.lovepik.com/element/40174/3494.png_860.png'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Container(
                                  width: 140,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 130,
                                          child: Text(packageVar.description)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.attach_money_outlined,
                                                  size: 12,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('Rs: ${packageVar.price}',
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.file_copy_sharp,
                                                  size: 12,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('${packageVar.type.type}',
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                      //   children: [
                                      //     Icon(
                                      //       Icons.star,
                                      //       size: 16.0,
                                      //       color: AppColors.color('FFB44A'),
                                      //     ),
                                      //     SizedBox(width: 5.0),
                                      //     Text('${5}'),
                                      //   ],
                                      // )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                if (!isDetailer)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    child: Form(
                      key: _formKey,
                      child: Wrap(
                        runSpacing: 20,
                        children: [
                          TextFormFieldNormalUtils(
                            validator: (name) {
                              if (name == null || name.isEmpty) {
                                return 'Vehicle No is required';
                              }
                              return null;
                            },
                            textLabel: "Vehicle No",
                            controller: vehicleNoController,
                            isPhonekey: false,
                          ),
                          TextFormFieldNormalUtils(
                            textLabel: "Special Notes",
                            controller: specialNoteController,
                            isPhonekey: false,
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: TextFormFieldNormalUtils(
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return 'Date is required';
                                }
                                return null;
                              },
                              textLabel: "Date",
                              controller: dateController,
                              isPhonekey: false,
                              disabled: true,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectTime(context);
                            },
                            child: TextFormFieldNormalUtils(
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return 'Time is required';
                                }
                                return null;
                              },
                              textLabel: "Time",
                              controller: timeController,
                              isPhonekey: false,
                              disabled: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                if (!isDetailer)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var outputFormat = DateFormat('yyyy-MM-dd');
                            var date = outputFormat.format(selectedDate);
                            var time =
                                '${selectedTime.hour}:${selectedTime.minute}:00';
                            await CallApi(context).addBooking(
                                widget.washCenter.user,
                                date,
                                time,
                                widget.washCenter,
                                vehicleNoController.text,
                                specialNoteController.text,
                                selectedPackage);
                          }
                        },
                        color: AppColors.color('FFD54F'),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            'Book',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )),
                  )
              ],
            ),
            if (isDetailer)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddServicePage(
                                      washCenter: widget.washCenter,
                                    )));
                      },
                      color: AppColors.color('2196F3'),
                      child: Text(
                        'Update Service',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                  RaisedButton(
                      onPressed: () async {
                        delete(context, widget.washCenter.id);
                      },
                      color: Colors.red,
                      child: Text(
                        'Delete Service',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            if (isDetailer)
              SizedBox(
                height: 15,
              ),
            if (isDetailer)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                      onPressed: () async {
                        var res = await CallApi(context)
                            .updateAvailable(widget.washCenter.id);

                        if (res == 'ACTIVE') {
                          setState(() {
                            active = true;
                          });
                        } else {
                          setState(() {
                            active = false;
                          });
                        }
                      },
                      color: AppColors.color('2196F3'),
                      child: Text(
                        'Set as ' + (active ? 'Unavailable' : 'Available'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
          ],
        ),
      ),
    ));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat.yMd().format(selectedDate);
        // DateFormat.yMd().format(picked);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        timeController.text = '${picked.hour}:${picked.minute}:00';
      });
  }

  delete(BuildContext context, String id) {
    Widget cancelButton = FlatButton(
      child: Text("OK"),
      onPressed: () async {
        Navigator.of(context).pop();
        await CallApi(context).deleteWashCenter(id);
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
      content: Text('Are you sure to delete wash center?'),
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
