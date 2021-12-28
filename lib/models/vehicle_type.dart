import 'dart:convert';

// vehicle type  model class
class VehicleType {
  String id;
  String type;

  VehicleType({this.id, this.type});

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    var data = VehicleType(
      id: json['id'] != null ? json['id'] : '',
      type: json['type'] != null ? json['type'] : '',
    );
    return data;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}
