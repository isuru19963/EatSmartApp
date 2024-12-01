import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'https://stopcannabischallenge.ca/api';
  final String _webURL = 'https://stopcannabischallenge.ca/';
  final String imagesUrl = 'https://stopcannabischallenge.ca/';


  // final String _url = 'http://192.168.8.102/Stop-Cannabis-Admin/api';
  // final String _webURL = 'http://192.168.8.102/Stop-Cannabis-Admin/';
  // final String imagesUrl = 'https://stopcannabischallenge.ca/';

  var token;


  getapiURL() {
    return _url;
  }

  getImage() {
    return imagesUrl;
  }

  postData(data, apiUrl) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    token = localStorage.getString('token');

    Uri url = Uri.parse(apiUrl);
    print(url.toString());
    return await http.post(url, body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    Uri url = Uri.parse(fullUrl);
    return await http.get(url, headers: _setHeaders());
  }

  getURL() {
    return _webURL;
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
    'Connection': 'keep-alive',
  };
}
