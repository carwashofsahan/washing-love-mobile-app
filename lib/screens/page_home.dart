import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/auth_pages/page_mail_otp.dart';
import 'package:washing_love/screens/aboutus.dart';
import 'package:washing_love/screens/contactus.dart';
import 'package:washing_love/screens/notifications_page.dart';
import 'package:washing_love/screens/search_washcenters.dart';
import 'package:washing_love/screens/washersList.dart';
import 'package:washing_love/models/user.dart';
import 'package:washing_love/models/washer.dart';
import 'package:washing_love/screens/add_package.dart';
import 'package:washing_love/screens/add_service.dart';
import 'package:washing_love/utils/icon_title.dart';
import 'package:washing_love/utils/utils_bottom_nav_bar.dart';
import 'package:washing_love/utils/utils_theme.dart';
import 'package:washing_love/utils/utils_text_progress_page.dart';

// home page
class HomePage extends StatefulWidget {
  final User user;
  final String token;

  HomePage({this.user, this.token});

  @override
  State<StatefulWidget> createState() {
    return _HomeState(user, token);
  }
}

final List<String> _items = ['service 1', '2'];

class _HomeState extends State<HomePage> {
  final User user;
  final String token;
  bool isDetailer = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<WashCenter> washers = [];

  _HomeState(this.user, this.token);

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var isDetailerRes = await CallApi(context).isDetailer();

    setState(() {
      isDetailer = isDetailerRes;
    });
  }

  Widget _buildFirstCard() {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(16),
              child: Text(
                'Find best places to wash your car.',
                style: TextStyle(fontSize: 15),
              )),
          Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'How it works.',
                style: TextStyle(fontSize: 15),
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: HomePageIcon(
                          iconpath:
                              'https://thumbs.dreamstime.com/b/car-wash-icon-map-pointer-location-79229299.jpg',
                          title: 'Find best location')),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: HomePageIcon(
                          iconpath:
                              'https://5.imimg.com/data5/EW/GO/SZ/GLADMIN-51741270/selection-092-500x500.png',
                          title: 'Find best service')),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: HomePageIcon(
                          iconpath:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ06oKb7tFRwk5xWGy-SgWCJ2TlYbMWwgEqUA&usqp=CAU',
                          title: 'Book')),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future buildText() {
    return Future.delayed(Duration(seconds: 1), () => print('waiting...'));
  }

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(72),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          color: Theme.of(context).accentColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 4),
          child: AppBar(
            automaticallyImplyLeading: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
            ),
            title: Text(
              'Washing Love',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                _key.currentState.openDrawer();
              },
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationsList()));
                  },
                  icon: Container(
                    width: 30,
                    height: 30,
                    child: Stack(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 30,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 5),
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffc32c37),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Center(
                                  // child: Text(
                                  //   '5',
                                  //   style: TextStyle(fontSize: 10),
                                  // ),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _widthHight = MediaQuery.of(context).size.width / 2 - 50;
    return Scaffold(
      key: _key,
      bottomNavigationBar:
          BottomNavigationUtils(initValue: 0, user: user, token: token),
      appBar: _buildAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: AppColors.color('FFD54F'),
              child: DrawerHeader(
                child: Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Washing',
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                      Text(
                        'Love',
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      )
                    ],
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 5,
              child: Container(
                color: AppColors.color('2196F3'),
              ),
            ),
            Visibility(
              visible: isDetailer,
              child: ListTile(
                title: const Text('Add Service Station'),
                leading: Icon(Icons.add),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddServicePage()));
                },
              ),
            ),
            Visibility(
              visible: isDetailer,
              child: ListTile(
                title: const Text('Add Package'),
                leading: Icon(Icons.add),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPackagePage()));
                },
              ),
            ),
            ListTile(
              title: const Text('About US'),
              leading: Icon(Icons.account_balance_outlined),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              title: const Text('Contact US'),
              leading: Icon(Icons.contact_mail),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
            ),
            ListTile(
              title: const Text('Change Password'),
              leading: Icon(Icons.vpn_key),
              onTap: () async {
                var email = await CallApi(context).getUserEmail();
                var res = await CallApi(context).sendOtpToMe();
                if (res)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpScreenMail(
                                inputMail: email,
                                type: 'change',
                              )));
              },
            ),
            ListTile(
              title: const Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                CallApi(context).logOut();
                Navigator.of(context).popUntil(ModalRoute.withName("/land"));
              },
            ),
          ],
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        children: [
          //section 01
          _buildFirstCard(),

          SizedBox(height: 20),

          if (!isDetailer)
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchWashers()));
              },
              color: AppColors.color('FFD54F'),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Find available services'),
                ],
              ),
            ),

          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProgressPageHeaderTextUtils(
                  text: isDetailer
                      ? 'My Service Stations'
                      : 'Car wash locations'),
              InkWell(
                child: Icon(Icons.refresh),
                onTap: () {
                  getData();
                },
              )
            ],
          ),
          WashcentersList(),
        ],
      ),
    );
  }
}
