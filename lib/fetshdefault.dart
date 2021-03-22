import 'package:http/http.dart' as http;

Future addsomething(apiurl, bodys) async {
  try {
    var value = await http.post(apiurl, body: bodys);

    if (value.body == "1") {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<List<dynamic>> fetch(apiurl, map, frommap) async {
  try {
    final response = await http.post(apiurl, body: map);

    return frommap(response.body);
  } catch (e) {
    return null;
  }
}

Stream<List<dynamic>> fetchstream(apiurl, map, frommap) async* {
  try {
    final response = await http.post(apiurl, body: map);
    yield frommap(response.body);
  } catch (e) {
    yield null;
  }
}
