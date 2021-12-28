import 'package:flutter/material.dart';

// common app bar
class AppBarCommonUtils extends StatelessWidget {
  final String appBarTitle;
  AppBarCommonUtils(@required this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        // color: Colors.amber[300],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 4),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
          ),
          title: Text(
            appBarTitle,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
