import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:washing_love/models/notifications.dart';
import 'package:washing_love/models/packages.dart';
import 'package:washing_love/api/api_manipulation.dart';
import 'package:washing_love/models/review_rating.dart';
import 'package:washing_love/models/user.dart';
import 'package:washing_love/models/vehicle_type.dart';
import 'package:washing_love/models/washer.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'api_consts.dart';

// Handle all api calls and handle shared preferance
class CallApi {
  BuildContext _context;

  CallApi(this._context);

  showToast({String msg = ""}) {
    EasyLoading.showToast(msg, toastPosition: EasyLoadingToastPosition.bottom);
  }

  showLoading() {
    EasyLoading.show(
        status: 'Please wait...', maskType: EasyLoadingMaskType.black);
  }

  stopLoading() {
    EasyLoading.dismiss();
  }

// ##### Endpoint calls #######
  Future<void> login(String email, String password) async {
    showLoading();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppConstants.baseUrl}/users/authentications?username=$email&password=$password'));
    request.body = json.encode({"email": email, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      _allocateInSharedPref(
          _context, resJson['data']['token'], resJson['data']);
      stopLoading();
    } else {
      showToast(msg: 'Email or password invalid.');
      stopLoading();
      return null;
    }
  }

  Future<void> signup(String fname, String lname, String email, String address,
      String city, String phone, String password, String role) async {
    showLoading();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${AppConstants.baseUrl}/users/sign_up'));
    request.body = jsonEncode({
      "id": "123",
      "firstname": fname,
      "lastname": lname,
      "email": email,
      "address": address,
      "city": city,
      "role": {"name": role},
      "phone": phone,
      "state": "ACCEPTED",
      "password": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      if (role == 'CUSTOMER') {
        await login(email, password);
        ApiManipulation(_context).validateUser();
        showToast(msg: 'Successfully registered.');
      } else {
        showToast(
            msg:
                'Successfully registered. Contact admin to approve your account.');
        Navigator.of(_context).pop();
        Navigator.of(_context).pop();
      }

      stopLoading();
    } else {
      showToast(msg: 'Problem with registration.');
      stopLoading();
      return null;
    }
  }

  Future<void> addDetailer(String name, String city, String totalRate,
      String totalSlot, List<Packages> packages) async {
    showLoading();
    var headers = await _getHeaders();
    var request =
        http.Request('POST', Uri.parse('${AppConstants.baseUrl}/washCenters'));
    var pckgs = packages
        .map((e) => {
              "id": e.id,
              "description": e.description,
              "type": {"id": e.type.id, "type": e.type.type},
              "price": e.price
            })
        .toList();

    request.body = jsonEncode({
      "id": "123",
      "name": name,
      "user": await _getUser(),
      "city": city,
      "totalRate": totalRate,
      "totalSlot": totalSlot,
      "state": "ACTIVE",
      "packages": pckgs
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      showToast(msg: 'Successfully Added.');
      Navigator.of(_context).popUntil(ModalRoute.withName("/home"));
      stopLoading();
    } else {
      showToast(msg: resJson['message']);
      stopLoading();
      return null;
    }
  }

  Future<void> updateDetailer(String name, String city, String totalRate,
      String totalSlot, List<Packages> packages, String id) async {
    showLoading();
    var headers = await _getHeaders();
    var request = http.Request(
        'PUT', Uri.parse('${AppConstants.baseUrl}/washCenters/$id'));
    var pckgs = packages
        .map((e) => {
              "id": e.id,
              "description": e.description,
              "type": {"id": e.type.id, "type": e.type.type},
              "price": e.price
            })
        .toList();

    request.body = jsonEncode({
      "id": "123",
      "name": name,
      "user": await _getUser(),
      "city": city,
      "totalRate": totalRate,
      "totalSlot": totalSlot,
      "state": "ACTIVE",
      "packages": pckgs
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      showToast(msg: 'Successfully Added.');
      Navigator.of(_context).popUntil(ModalRoute.withName("/home"));
      stopLoading();
    } else {
      showToast(msg: resJson['message']);
      stopLoading();
      return null;
    }
  }

  Future<String> updateAvailable(String id) async {
    showLoading();
    var headers = await _getHeaders();
    var userId = await _getUserId();

    var request = http.Request('GET',
        Uri.parse('${AppConstants.baseUrl}/washCenters/available/$userId/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      showToast(msg: 'Successfully Updated.');
      stopLoading();
      return resJson['data'];
    } else {
      showToast(msg: resJson['message']);
      stopLoading();
      return null;
    }
  }

  Future<void> deleteWashCenter(String id) async {
    showLoading();
    var headers = await _getHeaders();
    var request = http.Request(
        'DELETE', Uri.parse('${AppConstants.baseUrl}/washCenters/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      showToast(msg: 'Successfully Deleted.');
      Navigator.of(_context).popUntil(ModalRoute.withName("/home"));
      stopLoading();
    } else {
      showToast(msg: resJson['message']);
      stopLoading();
      return null;
    }
  }

  Future<List<WashCenter>> getWashers() async {
    showLoading();
    var headers = await _getHeaders();
    var request =
        http.Request('GET', Uri.parse('${AppConstants.baseUrl}/washCenters'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      stopLoading();
      return List<WashCenter>.from(
          resJson['data'].map((item) => WashCenter.fromJson(item)));
    } else {
      stopLoading();
      return null;
    }
  }

  Future<List<WashCenter>> filter(
      String name, String city, String date, String from, String to) async {
    showLoading();
    var headers = await _getHeaders();
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstants.baseUrl}/washCenters/filter?name=$name&city=$city&date=$date&fromtime=$from&totime=$to&available=true'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson != null) {
      stopLoading();
      return List<WashCenter>.from(
          resJson.map((item) => WashCenter.fromJson(item)));
    } else {
      stopLoading();
      return null;
    }
  }

  Future<List<WashCenter>> getWashersByUserId() async {
    showLoading();
    var headers = await _getHeaders();
    var userId = await _getUserId();
    var request = http.Request(
        'GET', Uri.parse('${AppConstants.baseUrl}/washCenters/user/$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      stopLoading();
      return List<WashCenter>.from(
          resJson['data'].map((item) => WashCenter.fromJson(item)));
    } else {
      stopLoading();
      return null;
    }
  }

  Future<void> addPackage(
      VehicleType type, String price, String description) async {
    showLoading();
    var headers = await _getHeaders();
    var request =
        http.Request('POST', Uri.parse('${AppConstants.baseUrl}/packages'));
    request.body = jsonEncode({
      "id": "123",
      "user": await _getUser(),
      "description": description,
      "type": type.toJson(),
      "price": double.parse(price),
      "state": "PENDING",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      showToast(msg: 'Successfully Added.');
      Navigator.of(_context).pop();
      stopLoading();
    } else {
      showToast(msg: resJson['message']);
      stopLoading();
      return null;
    }
  }

  Future<List<VehicleType>> getVehicleTypes() async {
    showLoading();
    var headers = await _getHeaders();
    var request =
        http.Request('GET', Uri.parse('${AppConstants.baseUrl}/vehicletypes'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      stopLoading();
      return List<VehicleType>.from(
          resJson['data'].map((item) => VehicleType.fromJson(item)));
    } else {
      stopLoading();
      return null;
    }
  }

  Future<List<Packages>> getPackagesByUserId() async {
    showLoading();
    var headers = await _getHeaders();
    var userId = await _getUserId();
    var request = http.Request(
        'GET', Uri.parse('${AppConstants.baseUrl}/packages/user/$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      stopLoading();
      return List<Packages>.from(
          resJson['data'].map((item) => Packages.fromJson(item)));
    } else {
      stopLoading();
      return null;
    }
  }

  Future<void> addBooking(
      User detailer,
      String date,
      String time,
      WashCenter washCenter,
      String vehicleNo,
      String specialNote,
      Packages package) async {
    showLoading();
    var headers = await _getHeaders();

    var request =
        http.Request('POST', Uri.parse('${AppConstants.baseUrl}/bookings'));
    request.body = jsonEncode({
      "id": "123",
      "customer": await _getUser(),
      "detailer": detailer.toJson(),
      "date": date.toString(),
      "fromtime": time,
      "stringtime": time,
      "washCenter": washCenter.toJson(),
      "vehicleNo": vehicleNo,
      "specialNote": specialNote,
      "packages": package.toJson()
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      showToast(msg: 'Successfully Added Booking.');
      Navigator.of(_context).pop();
      stopLoading();
    } else {
      showToast(msg: resJson['message']);
      stopLoading();
      return null;
    }
  }

  Future<void> updateStatusOfBooking(String bookingId, String state) async {
    showLoading();
    var headers = await _getHeaders();

    var request = http.Request(
        'PUT',
        Uri.parse(
            '${AppConstants.baseUrl}/bookings/state?bookingid=$bookingId&state=$state'));
    request.body = jsonEncode({});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      showToast(msg: 'Successful');
      stopLoading();
    } else {
      showToast(msg: resJson['message']);
      stopLoading();
      return null;
    }
  }

  Future<List<dynamic>> getBookingsByUserIdAndStatus(String status) async {
    showLoading();
    var headers = await _getHeaders();
    var userId = await _getUserId();
    var request = http.Request('GET',
        Uri.parse('${AppConstants.baseUrl}/bookings/mobile/${status}/$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['data'] != null) {
      stopLoading();
      return resJson['data'];
    } else {
      stopLoading();
      return null;
    }
  }

  Future<bool> changeAvailableWashCenter(String id) async {
    showLoading();
    var headers = await _getHeaders();
    var userId = await _getUserId();
    var request = http.Request('GET',
        Uri.parse('${AppConstants.baseUrl}/washcenters/available/$userId/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      showToast(msg: 'Successful');
      stopLoading();
    } else {
      showToast(msg: resJson['message']);
      stopLoading();
      return null;
    }
  }

  Future<List<dynamic>> getAllUpcoming() async {
    showLoading();
    var headers = await _getHeaders();
    var userId = await _getUserId();
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstants.baseUrl}/bookings/mobile/upcomming_dt/$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['data'] != null) {
      stopLoading();
      return resJson['data'];
    } else {
      stopLoading();
      return null;
    }
  }

  Future<List<dynamic>> getAllOngoing() async {
    showLoading();
    var headers = await _getHeaders();
    var userId = await _getUserId();
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstants.baseUrl}/bookings/mobile/ongoing_dt/$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['data'] != null) {
      stopLoading();
      return resJson['data'];
    } else {
      stopLoading();
      return null;
    }
  }

  Future<List<dynamic>> getAllPending() async {
    showLoading();
    var headers = await _getHeaders();
    var userId = await _getUserId();
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstants.baseUrl}/bookings/mobile/pending_dt/$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['data'] != null) {
      stopLoading();
      return resJson['data'];
    } else {
      stopLoading();
      return null;
    }
  }

  Future<List<dynamic>> getAllHistory() async {
    showLoading();
    var headers = await _getHeaders();
    var userId = await _getUserId();
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConstants.baseUrl}/bookings/mobile/history_dt/$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['data'] != null) {
      stopLoading();
      return resJson['data'];
    } else {
      stopLoading();
      return null;
    }
  }

  Future<List<ReviewRating>> getAllReviews(String id) async {
    showLoading();
    var headers = await _getHeaders();
    var request = http.Request('GET',
        Uri.parse('${AppConstants.baseUrl}/review_ratings/wash_center/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['data'] != null) {
      stopLoading();
      return List<ReviewRating>.from(
          resJson['data'].map((item) => ReviewRating.fromJson(item)));
    } else {
      stopLoading();
      return null;
    }
  }

  Future<void> addRating(
      String id, WashCenter washCenter, String review, int rating) async {
    showLoading();
    var headers = await _getHeaders();

    var request = http.Request(
        'POST', Uri.parse('${AppConstants.baseUrl}/review_ratings'));
    request.body = jsonEncode({
      "id": id,
      "customer": await _getUser(),
      "washCenter": washCenter.toJson(),
      "review": review,
      "rating": rating,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      var res = await updateIsReview(id);
      if (res) {
        showToast(msg: 'Successfully Reviewed.');
        stopLoading();
      } else {
        showToast(msg: 'Error.');
        stopLoading();
      }
    } else {
      showToast(msg: resJson['message']);
      stopLoading();
      return null;
    }
  }

  Future<bool> updateIsReview(String bookingId) async {
    showLoading();
    var headers = await _getHeaders();

    var request = http.Request(
        'PUT',
        Uri.parse(
            '${AppConstants.baseUrl}/bookings/isReview?bookingid=$bookingId&isReview=true'));
    request.body = jsonEncode({});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      return true;
    } else {
      showToast(msg: resJson['message']);
      return false;
    }
  }

  Future<List<NotificationClass>> getAllNotifications() async {
    showLoading();
    var headers = await _getHeaders();
    var userID = await _getUserId();
    var request = http.Request('GET',
        Uri.parse('${AppConstants.baseUrl}/notifications/receiver/$userID'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['data'] != null) {
      stopLoading();
      return List<NotificationClass>.from(
          resJson['data'].map((item) => NotificationClass.fromJson(item)));
    } else {
      stopLoading();
      return null;
    }
  }

  Future<bool> sendOtp(String email) async {
    showLoading();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('${AppConstants.baseUrl}/users/otp/$email'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      stopLoading();
      showToast(msg: 'Please enter otp received on your email.');
      return true;
    } else {
      stopLoading();
      showToast(msg: 'Error sending otp');
      return false;
    }
  }

  Future<bool> sendOtpToMe() async {
    showLoading();
    var headers = {'Content-Type': 'application/json'};
    var useremail = await getUserEmail();
    var request = http.Request(
        'GET', Uri.parse('${AppConstants.baseUrl}/users/otp/$useremail'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      stopLoading();
      showToast(msg: 'Please enter otp received on your email.');
      return true;
    } else {
      stopLoading();
      showToast(msg: 'Error sending otp');
      return false;
    }
  }

  Future<bool> sendSignupOtp(String email) async {
    showLoading();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('${AppConstants.baseUrl}/users/signUpOtp/$email'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      showToast(msg: 'Please enter OTP received on your email.');
      stopLoading();
      return true;
    } else {
      stopLoading();
      showToast(msg: 'Error sending otp');
      return false;
    }
  }

  Future<bool> checkOtp(String email, int otp) async {
    showLoading();
    var headers = {'Content-Type': 'application/json'};

    var request =
        http.Request('POST', Uri.parse('${AppConstants.baseUrl}/users/otp'));
    request.body = jsonEncode({
      "email": email,
      "otp": otp,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      stopLoading();
      return true;
    } else {
      showToast(msg: 'Invalid OTP');
      stopLoading();
      return false;
    }
  }

  Future<bool> checkSignupOtp(String email, int otp) async {
    showLoading();
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST', Uri.parse('${AppConstants.baseUrl}/users/signUpOtp'));
    request.body = jsonEncode({
      "email": email,
      "otp": otp,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      stopLoading();
      return true;
    } else {
      showToast(msg: 'Invalid OTP');
      stopLoading();
      return false;
    }
  }

  Future<bool> changePassword(String pass, String email, int otp) async {
    showLoading();
    var headers = {'Content-Type': 'application/json'};
    var user = new User();
    user.email = email;
    user.password = pass;

    var request = http.Request(
        'PUT', Uri.parse('${AppConstants.baseUrl}/users/mobile/otp/$otp'));
    request.body = jsonEncode({"id": "123", "email": email, "password": pass});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var str = await response.stream.bytesToString();
    var resJson = json.decode(str);

    if (resJson['code'] == 200) {
      stopLoading();
      Navigator.of(_context).pop();
      Navigator.of(_context).pop();
      Navigator.of(_context).pop();
      showToast(msg: 'Password changed');
      return true;
    } else {
      showToast(msg: 'Failed Change password.');
      stopLoading();
      return false;
    }
  }

  //logout
  Future<bool> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool wipe = await sharedPreferences.clear();
    return wipe;
  }

  //Profile Info Method
  void _allocateInSharedPref(BuildContext _context, String token, user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(AppConstants.spUser, jsonEncode(user));
    await sharedPreferences.setString(AppConstants.spToken, token);
    // print('from shared pref: $user');

    if (sharedPreferences.getString(AppConstants.spToken) != null) {
      // User uUser = User.fromJson(json.decode(user));
      ApiManipulation(_context).validateUser();
    } else {
      print('from API: Token null');
    }
  }

  _getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var userString = await sharedPreferences.get(AppConstants.spUser);
    return jsonDecode(userString);
  }

  _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return await sharedPreferences.getString(AppConstants.spToken);
  }

  _getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var userString = await sharedPreferences.get(AppConstants.spUser);
    return jsonDecode(userString)['id'];
  }

  getUserEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var userString = await sharedPreferences.get(AppConstants.spUser);
    return jsonDecode(userString)['email'];
  }

  isDetailer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var userString = await sharedPreferences.get(AppConstants.spUser);
    return jsonDecode(userString)['role']['name'] == 'DETAILER';
  }

  _getHeaders() async {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _getToken()}'
    };
  }
}
