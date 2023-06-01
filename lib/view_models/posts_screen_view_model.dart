import 'dart:async';
import 'package:ceiba_user_list/models/db_helper.dart';
import 'package:ceiba_user_list/models/post_model.dart';
import 'package:ceiba_user_list/services/post_service.dart';

class PostsScreenViewModel {
  final StreamController<List<Posts>> _filteredPostsController =
      StreamController<List<Posts>>.broadcast();

  Stream<List<Posts>> get filteredPostsStream => _filteredPostsController.stream;

  List<Posts> _posts = [];
  List<Posts> _filteredPosts = [];
  final DbHelper _dbHelper = DbHelper();

  void init(int userId) async {
    try {
      _posts = await _dbHelper.getPostList(userId);
      if (_posts.isEmpty) {
          _posts = await PostService.getPostsByUserId(userId);
          for (var element in _posts) {
          _dbHelper.insertPosts(element);
        }
      }
        _filteredPosts = _posts;
          _filteredPostsController.add(_filteredPosts);
    } catch (error) {
      _filteredPostsController.addError(error);
    }
    
  }

  void filterPosts(String filter) {
    _filteredPosts = _posts.where((post) =>
        post.title.toLowerCase().contains(filter.toLowerCase())).toList();
    _filteredPostsController.add(_filteredPosts);
  }

  void dispose() {
    _filteredPostsController.close();
  }
}
