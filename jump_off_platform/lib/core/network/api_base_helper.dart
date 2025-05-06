import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

// TODO: Confirm this path after api_exception.dart is migrated.
import 'package:jump_off_platform/core/error/api_exception.dart'; 

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      // TODO: Consider throwing a specific exception for 400, e.g., BadRequestException
      return json.decode(response.body.toString());
    case 401:
    case 403:
      // TODO: Consider throwing specific exceptions for 401/403, e.g., UnauthorisedException
      return json.decode(response.body.toString());
    case 500:
    default:
      // TODO: It might be better to throw the exception directly rather than returning it.
      // This also means call sites need to handle it properly (e.g. try-catch).
      return FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

class ApiBaseHelper {
  Future<dynamic> delete(String url) async {
    var apiResponse;
    try {
      // TODO: Add headers, timeouts, etc. as needed
      final response = await http.delete(Uri.parse(url));
      apiResponse = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    // TODO: Consider more specific error handling or re-throwing
    return apiResponse;
  }

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      // TODO: Add headers, timeouts, etc. as needed
      final response = await http.get(Uri.parse(url));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    // TODO: Consider more specific error handling or re-throwing
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    var responseJson;
    try {
      // TODO: Add headers (e.g., Content-Type: application/json), timeouts, etc. as needed
      final response = await http.post(Uri.parse(url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    // TODO: Consider more specific error handling or re-throwing
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    var responseJson;
    try {
      // TODO: Add headers (e.g., Content-Type: application/json), timeouts, etc. as needed
      final response = await http.put(Uri.parse(url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    // TODO: Consider more specific error handling or re-throwing
    return responseJson;
  }
} 