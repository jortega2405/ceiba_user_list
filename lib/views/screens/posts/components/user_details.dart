import 'package:ceiba_user_list/models/user_model.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final UserModel user;

  const UserDetails({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          subtitle: Text(user.name.toString()),
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
          subtitle: Text(user.phone.toString()),
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
          subtitle: Text(user.email.toString()),
        ),
      ],
    );
  }
}
