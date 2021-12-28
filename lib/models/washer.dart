import 'dart:convert';

import 'package:washing_love/models/app_enums.dart';
import 'package:washing_love/models/packages.dart';
import 'package:washing_love/models/review_rating.dart';
import 'package:washing_love/models/user.dart';

// washer  model class
class WashCenter {
  WashCenter(
      {this.id,
      this.city,
      this.name,
      this.packages,
      this.reviewRatings,
      this.state,
      this.totalRate,
      this.totalSlot,
      this.user});

  String id;
  String name;
  User user;
  String city;

  List<Packages> packages;
  int totalRate;
  int totalSlot;
  List<ReviewRating> reviewRatings;
  WashCenterState state;

  factory WashCenter.fromJson(Map<String, dynamic> json) {
    var data = WashCenter(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      city: json["city"] == null ? null : json["city"],
      packages: json["packages"] == null
          ? []
          : List<Packages>.from(
              json['packages'].map((item) => Packages.fromJson(item))),
      totalRate: json["totalRate"] == null ? 0 : json["totalRate"],
      totalSlot: json["totalSlot"] == null ? 0 : json["totalSlot"],
      reviewRatings: json["reviewRatings"] == null
          ? []
          : List<ReviewRating>.from(
              json['reviewRatings'].map((item) => ReviewRating.fromJson(item))),
      // state: WashCenterState.values[int.parse(json["state"])],
    );
    return data;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'user': user.toJson(),
        'city': city,
        //'packages': packages.map((e) => e.toJson()),
        'totalRate': totalRate,
        'totalSlot': totalSlot,
      };
}
