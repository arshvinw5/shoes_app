import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoes_app/model/User.dart';

class RestApiService {
  String baseURl = 'https://dummyjson.com/users';

  //future method to get all the users.
  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(baseURl));

    print(response.body);

    //checking state code by using response.statusCode

    if (response.statusCode == 200) {
      return getUsersFromJson(response.body);
    } else {
      throw Exception('Failed to fetch list of users');
    }
  }

  //Convert response body (JSON string) to List<User>
  List<User> getUsersFromJson(String responseBody) {
    // Decode the JSON string into a Map
    final Map<String, dynamic> parsedBody = json.decode(responseBody);

    // Extract the list of users using the 'users' key.
    final List<dynamic> usersJson = parsedBody['users'];

    // Map each item in the list to a User object.
    return usersJson
        .map<User>((json) => User.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}



//jason value => string vlaue
  // if the json resopnse is list the you will have to go through below process
  //convert response body => User object list

  //to get list of users

  //List<User> getUsersFromJson(String responseBody) {
    //responseBody => list of users
    // you need to decode the response body => responseBody
    //devocing using key / value => cast it to map
    // final parsdBody = json.decode(responseBody).cast<Map<String, dynamic>>();
    // return parsdBody.map<User>((json) => User.fromJson(json)).toList();
  //}
