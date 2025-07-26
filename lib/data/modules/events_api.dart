import 'dart:convert';
import 'dart:developer';

import 'package:events_app/data/api_service.dart';
import 'package:events_app/models/categories_response_model.dart';
import 'package:events_app/models/event_details_response_model.dart';

class EventsApi {
  final dio = DioClient().dio;
  Future<List<EventCategoriesResponseModel>?> callEventsCategoryApi() async {
    try {
      final resp = await dio.get("/categories.json");
      if (resp.statusCode == 200) {
        return eventCategoriesResponseModelFromJson(jsonEncode(resp.data));
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Item>?> callEventsDetailsApi(String category) async {
    try {
      final resp = await dio.get(category);
      if (resp.statusCode == 200) {
        return eventDetailsResponseModelFromJson(jsonEncode(resp.data)).item;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
