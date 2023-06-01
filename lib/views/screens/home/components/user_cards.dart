import 'package:flutter/material.dart';
import 'package:ceiba_user_list/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onPressed;

  const UserCard({super.key, required this.user, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name.toString(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.phone, color: Theme.of(context).primaryColor),
                const SizedBox( width: 8),
                Text(
                  user.phone.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.email, color: Theme.of(context).primaryColor),
                const SizedBox( width: 8),
                Text(
                  user.email.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onPressed,
                child: Text(
                  'VER PUBLICACIONES',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
