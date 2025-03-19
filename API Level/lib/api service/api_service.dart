import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../utils/utility.dart';

class ApiService {
  String baseURL = 'https://66f4062c77b5e8897097ef61.mockapi.io/';
  ProgressDialog? pd;

  void showProgressDialog(context) {
    if (pd == null) {
      pd = ProgressDialog(context);
      pd!.style(
        message: '  Please Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: SpinKitSpinningLines(color: Colors.black,),
        elevation: 10.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
      );
    }
    pd!.show();
  }

  void dismissProgress() {
    if (pd != null && pd!.isShowing()) {
      pd!.hide();
    }
  }

  Future<dynamic> getUsers(context) async {
    if (await Utils().isInternetAvailable(context)) {
      showProgressDialog(context);
      http.Response res = await http.get(Uri.parse(baseURL + 'candidate'));
      dismissProgress();
      return convertJSONToData(res);
    }
    return null;
  }

  Future<dynamic> addUser({context, map}) async {
    showProgressDialog(context);
    http.Response res = await http.post(Uri.parse(baseURL + 'candidate'), body: map);
    dismissProgress();
    return convertJSONToData(res);
  }

  Future<dynamic> updateUser({id, map, context}) async {
    showProgressDialog(context);
    http.Response res =
    await http.put(Uri.parse(baseURL + 'candidate/$id'), body: map);
    dismissProgress();
    return convertJSONToData(res);
  }

  Future<dynamic> deleteUser({id, context}) async {
    showProgressDialog(context);
    http.Response res = await http.delete(Uri.parse(baseURL + 'candidate/$id'));
    dismissProgress();
    return convertJSONToData(res);
  }


  dynamic convertJSONToData(http.Response res) {
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else if (res.statusCode == 404) {
      return 'PAGE NOT FOUND PLEASE CHECK YOUR URL';
    } else if (res.statusCode == 500) {
      return 'SERVER UDI GAYELU 6';
    } else {
      return 'NO DATA FOUND';
    }
  }
}
