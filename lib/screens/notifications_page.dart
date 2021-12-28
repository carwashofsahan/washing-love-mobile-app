import 'package:flutter/material.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/models/notifications.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';

// notification page
class NotificationsList extends StatefulWidget {
  @override
  _NotificationsListState createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.now());

  final _formKey = GlobalKey<FormState>();

  List<NotificationClass> reviews = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var res = await CallApi(context).getAllNotifications();

    setState(() {
      reviews = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: AppBarCommonUtils('Notifications'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 24),
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.notification_important),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              reviews[index].notification,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
