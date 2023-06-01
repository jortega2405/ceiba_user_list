import 'package:auto_size_text/auto_size_text.dart';
import 'package:ceiba_user_list/models/post_model.dart';
import 'package:ceiba_user_list/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ceiba_user_list/view_models/posts_screen_view_model.dart';

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
    return Scaffold(
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
              style:  TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              decoration: InputDecoration(
                focusedBorder:
                    Theme.of(context).inputDecorationTheme.focusedBorder,
                enabledBorder:
                    Theme.of(context).inputDecorationTheme.enabledBorder,
                fillColor:  Theme.of(context).primaryColor,
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
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: const Text(
                              'Autor',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(widget.user!.name.toString()),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: const Text(
                              'Telefono',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(widget.user!.phone.toString()),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: const Text(
                              'Correo Electronico',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(widget.user!.email.toString()),
                          ),
                          const Text(
                            'Publicaciones',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: filteredPosts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                             FaIcon(
                                              FontAwesomeIcons.newspaper,
                                              size: 15,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.all(10)),
                                            SizedBox(
                                              height: 50,
                                              width: 250,
                                              child: AutoSizeText(
                                                filteredPosts[index].title,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
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
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
