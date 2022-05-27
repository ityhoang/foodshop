// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';


class UserModel {
  final String email;
  final String gender;
  var name;
  final String id;
  var avt;
  var address;
  var phone;
  UserModel({
    required this.email,
    required this.gender,
    required this.name,
    required this.id,
    required this.avt,
    required this.address,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      email: jsonData['UserEmail'],
      gender: jsonData['UserGender'],
      name: jsonData['UserName'],
      id: jsonData['UserId'],
      avt: jsonData['avtar'],
      address: jsonData['address'],
      phone: jsonData['phone'],
    );
  }
  static Map<String, dynamic> toMap(UserModel user) => {
        'email': user.email,
        'gender': user.gender,
        'name': user.name,
        'id': user.id,
        'avt': user.avt,
        'address': user.address,
        'phone': user.phone,
      };

  static String encode(List<UserModel> card) => json.encode(
        card
            .map<Map<String, dynamic>>((card) => UserModel.toMap(card))
            .toList(),
      );

  static List<UserModel> decode(String card) =>
      (json.decode(card) as List<dynamic>)
          .map<UserModel>((item) => UserModel.fromJson(item))
          .toList();
}
