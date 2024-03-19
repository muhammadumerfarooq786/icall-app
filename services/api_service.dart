import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:icall/Model/cnic_verify_model.dart';
import 'package:icall/Model/email_verify_model.dart';
import 'package:icall/Model/login_user_model.dart';
import 'package:icall/Model/login_user_response_model.dart';
import 'package:icall/Model/nameVerifyModel.dart';
import 'package:icall/Model/register_user_model.dart';
import 'package:icall/Model/user_new_post_model.dart';
import 'package:icall/services/shared_service.dart';

import '../../config.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> cnicVerify(
    CnicVerifyModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.cnicAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> nameVerify(
    NameVerifyModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.userNameAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> emailVerify(
    EmailVerifyModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.emailAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> registerUser(
    RegisterUserModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.registerAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> loginUser(
    LoginUserModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.loginAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      await SharedService.setLoginDetails(
        loginResponseJson(
          response.body,
        ),
      );

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> usernewPost(
    UserNewPostModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.newPostAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> PostDetails() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.postsAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      return "";
    }
  }

  static Future<String> NewsDetails() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.newsAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("ok");
      return response.body;
    } else {
      print("wrong");
      return "";
    }
  }

  // static Future<String> CasesDetails() async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //   };

  //   var url = Uri.http(Config.apiURL, Config.casesAPI);

  //   var response = await client.get(
  //     url,
  //     headers: requestHeaders,
  //   );

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print("ok");
  //     return response.body;
  //   } else {
  //     print("wrong");
  //     return "";
  //   }
  // }
}
