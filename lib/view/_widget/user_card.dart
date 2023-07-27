import 'package:flutter/material.dart';
import 'package:fluttersqflite/core/extension/context_extension.dart';

import '../model/user_model.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {super.key,
      required this.user,
      required this.delete,
      required this.edit});
  final UserModel user;
  final Function() delete;
  final Function() edit;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: edit,
        leading: CircleAvatar(
          backgroundColor: context.colors.onPrimary,
          child: const Icon(Icons.person),
        ),
        title: Text(
          "Id: ${user.id}",
        ),
        subtitle: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "Name: ${user.name}\n"),
              TextSpan(text: "Surname: ${user.surname}\n"),
              TextSpan(text: "Email: ${user.email}\n"),
              TextSpan(text: "Age: ${user.age}"),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: delete,
          icon: const Icon(
            Icons.delete,
          ),
        ),
      ),
    );
  }
}
