import 'dart:convert';

import 'package:washing_love/models/app_enums.dart';
import 'package:washing_love/models/role.dart';

// user  model class
class User {
  String id;
  String firstname;
  String lastname;
  String email;
  String password;
  String address;
  String phone;
  String city;
  Role role;
  UserState state;
  String token;

  User(
      {this.address,
      this.city,
      this.email,
      this.firstname,
      this.id,
      this.lastname,
      this.password,
      this.phone,
      this.role,
      this.state,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    var data = User(
      id: json['id'] != null ? json['id'] : '',
      firstname: json['firstname'] != null ? json['firstname'] : '',
      lastname: json['lastname'] != null ? json['lastname'] : '',
      email: json['email'] != null ? json['email'] : '',
      address: json['address'] != null ? json['address'] : '',
      phone: json['phone'] != null ? json['phone'] : '',
      city: json['city'] != null ? json['city'] : '',
      role: json['role'] != null ? Role.fromJson(json['role']) : '',
      password: json['password'] != null ? json['password'] : '',
      // state: UserState.values[int.parse(json['state'])],
    );
    return data;
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
        "phone": phone == null ? null : phone,
        "city": city == null ? null : city,
        "role": role == null ? null : role.toJson(),
      };
}
