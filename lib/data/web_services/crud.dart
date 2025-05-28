import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dartz/dartz.dart';
import 'package:user_appointment/constants/checkinternet.dart';
import 'package:user_appointment/constants/statusrequest.dart';
import 'package:http/http.dart' as http;

// ignore: prefer_interpolation_to_compose_strings
String _basicAuth = 'Basic ' + base64Encode(utf8.encode('fares:fares102030'));
Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  //using to get data from server
  Future<Either<StatusRequest, Map>> getDataFromServer(
    String linkurl,
    Map data,
  ) async {
    if (await checkInternet()) {
      var response = await http.post(Uri.parse(linkurl), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responseBody = jsonDecode(response.body);
        print(responseBody);
        return Right(responseBody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  // stream

  Stream<Either<StatusRequest, Map>> getDataFromServerAsStream(
    String linkurl,
    Map data,
  ) async* {
    if (await checkInternet()) {
      try {
        var response = await http.post(Uri.parse(linkurl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          print(responseBody);
          yield Right(responseBody);
        } else {
          yield const Left(StatusRequest.serverfailure);
        }
      } catch (e) {
        yield const Left(
          StatusRequest.serverfailure,
        ); // or another failure type if needed
      }
    } else {
      yield const Left(StatusRequest.offlinefailure);
    }
  }

  //using to send file
  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("post", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multiPartFile = http.MultipartFile(
      "file",
      stream,
      length,
      filename: basename(file.path),
    );
    request.headers.addAll(myheaders);
    request.files.add(multiPartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      if (response.body.isNotEmpty) {
        Map responsebody = jsonDecode(response.body);
        return Right(responsebody);
      } else {
        print("Empty response body ===========================");
        return const Left(StatusRequest.failure);
      }
    } else {
      return const Left(StatusRequest.serverfailure);
    }
  }
}

  //  Future<Map> getDataFromServer(String linkurl, Map data) async {
  //   if (await checkInternet()) {
  //     http.Response response = await http.post(Uri.parse(linkurl), body: data);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Map<String, dynamic> responseBody = jsonDecode(response.body);
  //       print("responseBody : $responseBody");
  //       return (responseBody);
  //     } else {
  //       print(
  //         " Error: ${response.statusCode} - ${response.reasonPhrase}  \n Please check your internet connection and try again.  \n If the problem persists, contact the server administrator.",
  //       );
  //       return {"": " Server Error"};
  //     }
  //   } else {
  //     print(
  //       "No internet connection. Please check your internet connection and try again.",
  //     );
  //     return {"": " Network Error"};
  //   }
  // }