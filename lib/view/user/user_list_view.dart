import 'package:flutter/material.dart';
import 'package:fluttersqflite/core/extension/context_extension.dart';
import 'package:fluttersqflite/view/_widget/user_card.dart';

import 'user_list_view_model.dart';

class UserListView extends UserListViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Flutter sqflite example",
        style: context.theme.textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }

  SizedBox buildBody(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height,
      child: Builder(
        builder: (context) {
          if (userList.isEmpty) {
            return Center(
              child: Text(
                "No Users !",
                style: context.textTheme.titleLarge,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              setState(() => userList = []);
              await getUserList();
            },
            child: ListView.builder(
              padding: context.paddingLow,
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return UserCard(
                  user: userList[index],
                  delete: () => deleteUser(userList[index].id!),
                  edit: () => editUser(userList[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        getUserList();
        addToUserList();
      },
    );
  }
}
