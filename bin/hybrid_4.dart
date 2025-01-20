import "package:http/http.dart" as http;
import "dart:convert" as convert;
import "dart:math";

void main() async {
  try {
    int limit = 8;

    // this is done to generate random series of ids and names each time the program runs
    // skip 1 to 22 (in the case limit = 8) (since dummyjson returns only 30 users at max)
    int skip = Random().nextInt(31 - limit);

    var uri = Uri.parse("https://dummyjson.com/users?limit=$limit&skip=$skip");
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
          "Failed http request. Status code: ${response.statusCode}");
    }

    final data = convert.jsonDecode(response.body);
    List<Map<String, dynamic>> users =
        List<Map<String, dynamic>>.from(data["users"]);

    for (var user in users) {
      User u = User(user);
      u.output();
    }
  } catch (err) {
    print(err);
  }
}

class User {
  Map<String, dynamic> user;

  User(this.user);

  output() {
    print(
        "ID: ${user["id"]}, Full Name: ${user["firstName"]} ${user["lastName"]}");
  }
}
