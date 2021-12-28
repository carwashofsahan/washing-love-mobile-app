import 'package:flutter/material.dart';
import 'package:washing_love/api/api_manipulation.dart';
import 'package:washing_love/utils/utils_theme.dart';

class LandPage extends StatefulWidget {
  @override
  _LandPageState createState() => _LandPageState();
}

// landing page of washing love
class _LandPageState extends State<LandPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        color: Colors.amber[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/wash_icon.jpg',
                      height: 125,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'We\'re',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.blue,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Wash Doctors',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.blue,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'Beat the Queues.',
              style: TextStyle(
                  fontSize: 35,
                  // color: Colors.blue,
                  fontWeight: FontWeight.w400),
            ),
            Column(
              children: [
                Container(
                  color: Colors.blue[200],
                  child: Text(
                    'You don’t need to be there.',
                    style: TextStyle(
                        fontSize: 20,
                        // color: Colors.blue,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  color: Colors.blue[200],
                  child: Text(
                    'Relax while we wash your Car.',
                    style: TextStyle(
                        fontSize: 20,
                        // color: Colors.blue,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            Center(
                child: Text(
              'Sri lanka\'s only Car Wash app',
              style: TextStyle(
                  fontSize: 22, color: Theme.of(context).primaryColor),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  onPressed: () async {
                    ApiManipulation(context).validateUser();
                  },
                  color: AppColors.color('2196F3'),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
