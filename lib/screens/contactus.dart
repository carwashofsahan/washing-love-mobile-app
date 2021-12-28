import 'package:flutter/material.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';

// contact us page
class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: AppBarCommonUtils('Contact US'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'General Inquiries: +94778712353',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Head Office:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                Text(
                  'Washing Love Lanka (Pvt) Ltd.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                Text(
                  'No. 07, Galle Road,',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                Text(
                  'Panadura, Sri Lanka.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'washinglovesrilanka@gmail.com',
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            Text(
                '© Copyright © 2021 – Washing Love Lanka (Pvt) Ltd. All rights reserved.')
          ],
        ),
      ),
    );
  }
}
