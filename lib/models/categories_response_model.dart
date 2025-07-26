// To parse this JSON data, do
//
//     final productsResponseModel = productsResponseModelFromJson(jsonString);

import 'dart:convert';

List<EventCategoriesResponseModel> eventCategoriesResponseModelFromJson(
  String str,
) => List<EventCategoriesResponseModel>.from(
  json.decode(str).map((x) => EventCategoriesResponseModel.fromJson(x)),
);

String eventCategoriesResponseModelToJson(
  List<EventCategoriesResponseModel> data,
) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventCategoriesResponseModel {
  String? category;
  String? data;

  EventCategoriesResponseModel({this.category, this.data});

  factory EventCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      EventCategoriesResponseModel(
        category: json["category"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {"category": category, "data": data};
}
