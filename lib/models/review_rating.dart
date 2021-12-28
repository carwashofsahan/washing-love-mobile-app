import 'package:washing_love/models/washer.dart';
import 'package:washing_love/models/user.dart';

// review rating  model class
class ReviewRating {
  String id;
  User customer;
  WashCenter washCenter;
  String review;
  int rating;

  ReviewRating(
      {this.customer, this.id, this.rating, this.review, this.washCenter});

  factory ReviewRating.fromJson(Map<String, dynamic> json) {
    var data = ReviewRating(
      id: json['id'] != null ? json['id'] : '',
      customer:
          json['customer'] != null ? User.fromJson(json['customer']) : null,
      washCenter: json['washCenter'] != null
          ? WashCenter.fromJson(json['washCenter'])
          : null,
      review: json['review'] != null ? json['review'] : '',
      rating: json['rating'] != null ? json['rating'] : 0,
    );
    return data;
  }
}
