import 'package:ceiba_user_list/models/post_model.dart';
import 'package:ceiba_user_list/models/user_model.dart';
import 'package:ceiba_user_list/view_models/posts_screen_view_model.dart';
import 'package:ceiba_user_list/views/screens/posts/components/post_item.dart';
import 'package:ceiba_user_list/views/screens/posts/components/user_details.dart';
import 'package:flutter/material.dart';


class PostsScreen extends StatefulWidget {
  final UserModel? user;

  const PostsScreen({Key? key, this.user}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late PostsScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = PostsScreenViewModel();
    _viewModel.init(widget.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.user!.name.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                  enabledBorder:
                      Theme.of(context).inputDecorationTheme.enabledBorder,
                  fillColor: Theme.of(context).primaryColor,
                  contentPadding: const EdgeInsets.all(15.0),
                  label: Text(
                    "Ingrese título de la publicación",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                onChanged: (string) {
                  _viewModel.filterPosts(string);
                },
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: StreamBuilder<List<Posts>>(
                    stream: _viewModel.filteredPostsStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final filteredPosts = snapshot.data!;
                        return Column(
                          children: [
                            UserDetails(user: widget.user!),
                            const Text(
                              'Publicaciones',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: filteredPosts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return PostItem(post: filteredPosts[index]);
                                },
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error al cargar las publicaciones.'),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
