import 'dart:convert';

import 'package:washing_love/models/app_enums.dart';
import 'package:washing_love/models/user.dart';
import 'package:washing_love/models/vehicle_type.dart';

// packages  model class
class Packages {
  String id;
  User user;
  String description;
  VehicleType type;
  double price;
  PackageStatus state;
  bool selected = false;

  Packages(
      {this.description,
      this.id,
      this.price,
      this.state,
      this.type,
      this.user});

  factory Packages.fromJson(Map<String, dynamic> json) {
    var data = Packages(
      id: json['id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      description: json['description'] != null ? json['description'] : '',
      type: json['type'] != null ? VehicleType.fromJson(json['type']) : null,
      price: json['price'] != null ? json['price'] : null,
      // state:PackageStatus.values[int.parse(json['state']),
    );
    return data;
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user": user == null ? null : user.toJson(),
        "description": description,
        "type": type.toJson(),
        "price": price
      };
}
