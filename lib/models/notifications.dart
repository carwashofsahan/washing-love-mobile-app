import 'package:washing_love/models/app_enums.dart';
import 'package:washing_love/models/user.dart';

// notification  model class
class NotificationClass {
  String id;
  User sender;
  User receiver;
  String notification;
  String date;
  NotificationState state;

  NotificationClass(
      {this.date,
      this.id,
      this.notification,
      this.receiver,
      this.sender,
      this.state});

  factory NotificationClass.fromJson(Map<String, dynamic> json) {
    var data = NotificationClass(
      id: json['id'] != null ? json['id'] : '',
      notification: json['notification'] != null ? json['notification'] : '',
      date: json['date'] != null ? json['date'] : '',
    );
    return data;
  }
}
