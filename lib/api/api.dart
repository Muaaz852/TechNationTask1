import 'package:http/http.dart' as http;
import 'package:tech_nation_task_1/models/banner.dart';

import 'dart:convert' as JSON;

import 'package:tech_nation_task_1/models/banners.dart';
import 'package:tech_nation_task_1/models/event.dart';
import 'package:tech_nation_task_1/models/events.dart';
import 'package:tech_nation_task_1/models/user.dart';
import 'package:tech_nation_task_1/models/users.dart';

class ApiClient {

  // Singleton Pattern
  static final ApiClient _apiClient = ApiClient._internal();

  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._internal();

  // Static constant api urls.
  static const String baseURL = "http://techclub.qorapp.com/api/en";
  static const String bannersURL = "$baseURL/listBanners";
  static const String eventsURL = "$baseURL/listEvents";
  static const String usersURL = "https://jsonplaceholder.typicode.com/users";

  String placeholderImageURL = "http://via.placeholder.com/300x150";

  // Static http client
  static final http.Client _httpClient = http.Client();

  // Get all banners from the api then convert them to a dart object and returns it
  Future<List<Banner>> getBanners() async {
    http.Response _response = await _httpClient.get(bannersURL);
    Banners _banners = Banners.fromJson(JSON.jsonDecode(_response.body));

    if (_banners.status == 1) {
      return _banners.banners;
    } else {
      throw Exception('Failed to load banners');
    }
  }

  // Get all events from the api then convert them to a dart object and returns it
  Future<List<Event>> getEvents() async {
    http.Response _response = await _httpClient.get(eventsURL);
    Events _events = Events.fromJson(JSON.jsonDecode(_response.body));

    if (_events.status == 1) {
      return _events.events;
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<List<User>> getUsers() async {
    http.Response _response = await _httpClient.get(usersURL);
    if (_response.statusCode == 200) {
      List<User> _users = getUsersList(_response.body);
      return _users;
    } else {
      throw Exception("Failed to load users");
    }
  }

  List<User> getUsersList(String responseBody) {
    final dynamic parsed = JSON.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((dynamic json) => User.fromJson(json)).toList();
  }
}