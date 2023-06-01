

import 'dart:convert';
import 'package:ceiba_user_list/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:ceiba_user_list/models/post_model.dart';

class PostService {

  static List<Posts> parsePosts(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Posts>((json) => Posts.fromJson(json)).toList( );
  }

  static Future<List<Posts>> getPosts()async {
    try {
      final response = await http.get( Uri.parse('${Constants.baseUrl}posts'));
      if (response.statusCode == 200) {
        List<Posts> list = parsePosts(response.body);
        return list;
      }else{
        throw Exception("Error");
      }
      
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<Posts>> getPostsByUserId(int? userId)async {
    try {
      final response = await http.get(Uri.parse('${Constants.baseUrl}posts?userId=$userId'));
      if (response.statusCode == 200) {
        List<Posts> list = parsePosts(response.body);
        return list;
      }else{
        throw Exception("Error");
      }
      
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
}