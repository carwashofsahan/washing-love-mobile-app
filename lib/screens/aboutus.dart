import 'package:flutter/material.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';

// about us page
class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: AppBarCommonUtils('About US'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Sri Lanka’s only Car Wash App.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Washing Love was founded by Mr. Sahan Gaurava who saw a need in the industry for an integrated Point-of-sale, and Marketing system that would not only help car wash owners attract new business, but also get current customers to wash with them more often.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Our Detailers are experienced, insured, and highly recommended by our customers.',
            ),
            SizedBox(
              height: 15,
            ),
            Text(
                'We only charge you after the service. A dedicated support team will be here in case anything goes wrong.')
          ],
        ),
      ),
    );
  }
}
