import 'dart:convert';
import 'package:http/http.dart ' as http;

void main() async {
  try {
    var auth = await login();
    var token = "JWT ${auth['token']}";
    var fetchData = await fetch(token);
    print(fetchData[0]['text']);
  } catch (e) {
    print(e);
  }
}

Future login() async {
  var request = await http.post(
      'https://trello.backend.tests.nekidaem.ru/api/v1/users/login/',
      body: {'username': 'armada', 'password': 'FSH6zBZ0p9yH'});
  var map = JsonDecoder().convert(request.body) as Map;
  return map;
}

Future fetch(String token) async {
  var response = await http.get(
      'https://trello.backend.tests.nekidaem.ru/api/v1/cards/',
      headers: {'Authorization': token});
  var result = JsonDecoder().convert(response.body) as Map;
  return result;
}
