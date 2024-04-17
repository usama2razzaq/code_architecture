import 'dart:io';
import 'package:assignment/networks/API/app_exceptions.dart';
import 'package:assignment/utils/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final headers = <String, String>{
  "Content-Type": "application/json",
};

//Get Method Using http package repository
class ApiBaseHelper {
  Future<dynamic> get(String endpoint) async {
    var url = Uri.parse(Constants.kBaserUrl + endpoint);
    var responseJson;

    try {
      final response = await http.get(url, headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print(responseJson);
    print('api get recieved!');
    return responseJson;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
