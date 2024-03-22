import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

//API Key

// const String apiKey = "002b7f8a8bb24e5389773ddf28e1f094";

const String apiKey = "85940a4d7b23488ba7ecd9e9e7c6533e";

//Base URL

const String baseUrl = "https://newsapi.org/v2";

//Default Headers

const Map<String, dynamic> defaultHeaders = {
  "Content-Type": "application/json",
};

//API Class

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = baseUrl;

    _dio.options.headers = defaultHeaders;

    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  }

  //Dio Getter -> sendRequest

  Dio get sendRequest => _dio;
}

//API Response Class

class ApiResponse {
  String status;
  List<dynamic> articles;
  int totalResults;
  String? message;
  String? code;

  ApiResponse({
    required this.status,
    required this.articles,
    required this.totalResults,
    this.message,
    this.code,
  });

  factory ApiResponse.fromResponse(Response response) {
    var data = jsonDecode(response.toString());

    return ApiResponse(
      status: data["status"],
      articles: data["articles"] as List<dynamic>,
      totalResults: data["totalResults"],
      message: data["message"],
      code: data["code"],
    );
  }
}
