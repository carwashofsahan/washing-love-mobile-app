import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/models/user.dart';
import 'package:washing_love/screens/page_task_view_customer.dart';
import 'package:washing_love/screens/page_task_view_detailer.dart';
import 'package:washing_love/utils/utils_icon.dart';

// bbottom nav bar
class BottomNavigationUtils extends StatefulWidget {
  final int initValue;
  final User user;
  final String token;
  BottomNavigationUtils({this.initValue, this.user, this.token});

  @override
  _BottomNavigationUtilsState createState() => _BottomNavigationUtilsState();
}

class _BottomNavigationUtilsState extends State<BottomNavigationUtils> {
  bool isDetailer = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getData() async {
    var res = await CallApi(context).isDetailer();

    setState(() {
      isDetailer = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = widget.initValue;
    User user = widget.user;
    String token = widget.token;
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        barBackgroundColor: Colors.white,
        selectedItemBorderColor: Colors.transparent,
        selectedItemBackgroundColor: Theme.of(context).accentColor,
        selectedItemIconColor: Colors.white,
        selectedItemLabelColor: Colors.black,
        showSelectedItemShadow: false,
        barHeight: 60,
      ),
      selectedIndex: selectedIndex,
      onSelectTab: (index) {
        setState(() {
          selectedIndex = index;

          if (selectedIndex == 0) {
            //Navigator.of(context).pop();
           // Navigator.of(context).pushNamed("/home");
           Navigator.of(context).popUntil(ModalRoute.withName("/home"));

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => HomePage(
            //               user: user,
            //               token: token,
            //             )));
          } else if (selectedIndex == 1) {
            if (isDetailer) {
              //Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryPageDetailer(
                            user: user,
                            token: token,
                          )));
            } else {
              //Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryPageCustomer(
                            user: user,
                            token: token,
                          )));
            }
          }
        });
      },
      items: [
        FFNavigationBarItem(
          iconData: AppIcon.home,
          label: 'Home',
        ),
        FFNavigationBarItem(
          iconData: AppIcon.tasks,
          label: 'Jobs',
        ),
      ],
    );
  }
}
