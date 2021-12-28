import 'package:washing_love/models/app_enums.dart';
import 'package:washing_love/models/washer.dart';
import 'package:washing_love/models/user.dart';

// booking model class
class Booking {
  String id;
  User customer;
  User detailer;
  String date;
  String fromtime;
  BookingStatus status;
  WashCenter washCenter;
  String vehicleNo;
  String specialNote;

  Booking(
      {this.customer,
      this.date,
      this.detailer,
      this.fromtime,
      this.id,
      this.specialNote,
      this.status,
      this.vehicleNo,
      this.washCenter});

  factory Booking.fromJson(Map<String, dynamic> json) {
    var data = Booking(
      id: json['id'],
      customer:
          json['customer'] != null ? User.fromJson(json['customer']) : null,
      detailer:
          json['detailer'] != null ? User.fromJson(json['detailer']) : null,
      date: json['date'] != null ? json['date'] : [],
      fromtime: json['fromtime'] != null ? json['fromtime'] : '',
      status: BookingStatus.values[json['status']],
      washCenter: json['washCenter'] != null
          ? WashCenter.fromJson(json['washCenter'])
          : null,
      vehicleNo: json['vehicleNo'] != null ? json['vehicleNo'] : '',
      specialNote: json['specialNote'] != null ? json['specialNote'] : '',
    );
    return data;
  }
}
