import '../../core/init/database/database_model.dart';

class UserModel extends DatabaseModel<UserModel> {
  int? id;
  String? name;
  String? surname;
  int? age;
  String? email;

  UserModel({
    this.name,
    this.surname,
    this.age,
    this.email,
    this.id,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    age = json['age'];
    email = json['email'];
  }

  @override
  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['age'] = age;
    data['email'] = email;
    return data;
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }
}
