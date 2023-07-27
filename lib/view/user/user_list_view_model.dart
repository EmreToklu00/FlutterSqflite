// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../_widget/custom_text_field.dart';
import '../model/user_model.dart';
import '../service/user_database_provider.dart';
import 'user_list.dart';

abstract class UserListViewModel extends State<UserList> {
  UserDatabaseProvider userDatabaseProvider = UserDatabaseProvider.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isMarried = false;
  List<UserModel> userList = [];

  @override
  void initState() {
    super.initState();
    getUserList();
  }

  Future getUserList() async {
    final response = await userDatabaseProvider.getAll();
    if (response == null) {
      userList = [];
      return;
    }
    userList = response;
    setState(() {});
  }

  //Add User To Db
  Future<void> saveUser() async {
    UserModel userModel = UserModel();
    userModel.name = nameController.text;
    userModel.surname = surnameController.text;
    userModel.age = int.tryParse(ageController.text);
    userModel.email = emailController.text;
    await userDatabaseProvider.add(userModel);
  }

  //Edit User
  Future<void> updateUser(int id) async {
    UserModel? model = await userDatabaseProvider.get(id);
    if (model == null) return;
    model.id = id;
    model.name = nameController.text;
    model.surname = surnameController.text;
    model.age = int.tryParse(ageController.text);
    model.email = emailController.text;
    await userDatabaseProvider.update(model.id!, model);
  }

  //Delete User
  Future<void> deleteUser(int id) async {
    await userDatabaseProvider.delete(id);
    await getUserList();
    setState(() {});
  }

  //clear all text editing controllers
  void clearTextEditingControllers() {
    nameController.clear();
    surnameController.clear();
    ageController.clear();
    emailController.clear();
  }

  //Add User Method
  Future<dynamic> addToUserList() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add User To Local Database"),
          content: Wrap(
            runSpacing: 10,
            children: [
              CustomTextField(
                hintText: "Name",
                controller: nameController,
                keyboardType: TextInputType.name,
              ),
              CustomTextField(
                hintText: "Surname",
                controller: surnameController,
                keyboardType: TextInputType.name,
              ),
              CustomTextField(
                hintText: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextField(
                hintText: "Age",
                controller: ageController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                saveUser();
                clearTextEditingControllers();
                Navigator.of(context).pop();
                getUserList();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  //Edit User Method
  Future<dynamic> editUser(UserModel model) {
    nameController.text = model.name.toString();
    surnameController.text = model.surname.toString();
    ageController.text = model.age.toString();
    emailController.text = model.email.toString();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add User To Local Database"),
          content: Wrap(
            runSpacing: 10,
            children: [
              CustomTextField(
                hintText: "Name",
                controller: nameController,
                keyboardType: TextInputType.name,
              ),
              CustomTextField(
                hintText: "Surname",
                controller: surnameController,
                keyboardType: TextInputType.name,
              ),
              CustomTextField(
                hintText: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextField(
                hintText: "Age",
                controller: ageController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateUser(model.id!);
                clearTextEditingControllers();
                await getUserList();
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
