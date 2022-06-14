import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelbi_finance/constants/preference_key.dart';

class ApiClient extends GetxService {
  static const int _timeoutInSeconds = 20;

  final String baseUrl;
  final SharedPreferences sharedPreferences;

  String? _token;
  late Map<String, String> _header;

  ApiClient({
    required this.baseUrl,
    required this.sharedPreferences,
  }) {
    _token = sharedPreferences.getString(PreferenceKey.token);
    if (_token != null) {
      _header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      };
    } else {
      _header = {'Accept': 'application/json'};
    }
  }

  void updateHeader(String token) {
    _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> get(String uri) async {
    try {
      if (foundation.kDebugMode) {
        developer.log('API Call: $uri');
      }

      final response = await http
          .get(Uri.parse(baseUrl + uri))
          .timeout(const Duration(seconds: _timeoutInSeconds));

      if (foundation.kDebugMode) {
        developer
            .log('API Response: [${response.statusCode}] \n${response.body}');
      }

      return _handleResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri);
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri);
    }
  }

  Future<dynamic> post(String uri, {Object? body}) async {
    try {
      if (foundation.kDebugMode) {
        developer.log('API Call: $uri, Body: $body');
      }

      final response = await http
          .post(Uri.parse(baseUrl + uri), body: body, headers: _header)
          .timeout(const Duration(seconds: _timeoutInSeconds));

      if (foundation.kDebugMode) {
        developer
            .log('API Response: [${response.statusCode}] \n${response.body}');
      }

      return _handleResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri);
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri);
    }
  }

  Future<dynamic> postMultipart(String uri, Map<String, String> body,
      {List<MultipartBody>? multipartBody}) async {
    try {
      if (foundation.kDebugMode) {
        developer.log('API Call: $uri, Body: $body');
      }

      http.MultipartRequest _request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + uri));
      _request.headers.addAll(_header);

      if (multipartBody != null) {
        for (MultipartBody multipart in multipartBody) {
          File _file = File(multipart.file.path);
          _request.files.add(http.MultipartFile(
            multipart.key,
            _file.readAsBytes().asStream(),
            _file.lengthSync(),
            filename: _file.path.split('/').last,
          ));
        }
      }

      _request.fields.addAll(body);
      final response = await http.Response.fromStream(await _request.send());

      if (foundation.kDebugMode) {
        developer
            .log('API Response: [${response.statusCode}] \n${response.body}');
      }

      return _handleResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri);
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri);
    }
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(response.body);
        return responseJson;

      case 401:
        throw UnAuthorizedException(
            response.body, response.request!.url.toString());
      case 404:
        throw FetchDataException(
            response.body, response.request!.url.toString());

      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad Request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responded in time', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'UnAuthorized request', url);
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
