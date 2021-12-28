import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//widget used to home page top 3 icons with images
class HomePageIcon extends StatelessWidget {
  String iconpath;
  String title;

  HomePageIcon({this.iconpath, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            color: Theme.of(context).accentColor,
            child: Image(
              height: 50,
              image: NetworkImage(iconpath),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}
