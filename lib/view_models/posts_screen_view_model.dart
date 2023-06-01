import 'dart:async';
import 'package:ceiba_user_list/models/post_model.dart';
import 'package:ceiba_user_list/services/post_service.dart';

class PostsScreenViewModel {
  final StreamController<List<Posts>> _filteredPostsController =
      StreamController<List<Posts>>.broadcast();

  Stream<List<Posts>> get filteredPostsStream => _filteredPostsController.stream;

  List<Posts> _posts = [];
  List<Posts> _filteredPosts = [];

  void init(int userId) {
    PostService.getPostsByUserId(userId).then((postsFromServer) {
      _posts = postsFromServer;
      _filteredPosts = _posts;
      _filteredPostsController.add(_filteredPosts);
    });
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
