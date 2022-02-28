// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.donationDate,
    required this.donationPrice,
    required this.fName,
  });

  String donationDate;
  int donationPrice;
  String fName;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    donationDate: json["donationDate"],
    donationPrice: json["donationPrice"],
    fName: json["f_name"],
  );

  Map<String, dynamic> toJson() => {
    "donationDate": donationDate,
    "donationPrice": donationPrice,
    "f_name": fName,
  };
}
