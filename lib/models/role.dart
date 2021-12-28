import 'dart:convert';

// role  model class
class Role {
  String id;
  String name;

  Role({this.id, this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    var data = Role(
      id: json['id'] != null ? json['id'] : '',
      name: json['name'] != null ? json['name'] : '',
    );
    return data;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
