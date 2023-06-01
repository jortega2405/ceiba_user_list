
import 'dart:convert';
import 'package:ceiba_user_list/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'package:ceiba_user_list/models/user_model.dart';

class UserServices {

  static List<UserModel> parseUsers(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList( );
  }


  static Future<List<UserModel>> getUsers()async {
    try {
      final response = await http.get(Uri.parse('${Constants.baseUrl}users'));
      if (response.statusCode == 200) {
        List<UserModel> list = parseUsers(response.body);
        return list;
      }else{
        throw Exception("Error");
      }
      
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
}