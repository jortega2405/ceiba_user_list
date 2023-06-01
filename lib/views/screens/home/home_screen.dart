import 'package:ceiba_user_list/models/user_model.dart';
import 'package:ceiba_user_list/views/screens/posts/posts_screen.dart';
import 'package:ceiba_user_list/views/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:ceiba_user_list/view_models/home_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenViewModel _viewModel = HomeScreenViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prueba de Ingreso',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                label: Text(
                  'Buscar usuario',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                focusedBorder:
                    Theme.of(context).inputDecorationTheme.focusedBorder,
                enabledBorder:
                    Theme.of(context).inputDecorationTheme.enabledBorder,
              ),
              onChanged: (string) {
                _viewModel.filterUsers(string);
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<UserModel>>(
              stream: _viewModel.filteredUsersStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final users = snapshot.data!;
                  return ListView.separated(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: users.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(color: Colors.transparent),
                    itemBuilder: (BuildContext context, int index) {
                      return UserCard(
                        user: users[index],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostsScreen(
                                    user: users[index])),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error al cargar los usuarios.'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
