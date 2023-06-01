import 'package:auto_size_text/auto_size_text.dart';
import 'package:ceiba_user_list/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostItem extends StatelessWidget {
  final Posts post;

  const PostItem({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                const Padding(padding: EdgeInsets.all(10)),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: AutoSizeText(
                    post.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
