// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  String? status;
  String? message;
  List<FAQItem>? data;

  FaqModel({
     this.status,
     this.message,
     this.data,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    status: json["status"],
    message: json["message"],
    data: List<FAQItem>.from(json["data"].map((x) => FAQItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FAQItem {
  String id;
  String question;
  String answer;
  String createdAt;

  FAQItem({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
  });

  factory FAQItem.fromJson(Map<String, dynamic> json) => FAQItem(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "created_at": createdAt,
  };
}
