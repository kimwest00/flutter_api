// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int count;
  String status;

  UserModel({
    required this.count,
    required this.status,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    count: json["count"],
    status: json["status"],

  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "status": status,

  };
}