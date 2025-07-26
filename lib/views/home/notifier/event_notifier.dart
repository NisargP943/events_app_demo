import 'package:events_app/data/modules/events_api.dart';
import 'package:events_app/models/event_details_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventNotifier extends StateNotifier<List<Item>> {
  EventNotifier(this.api) : super([]);

  final EventsApi api;

  List<Item> allEvents = [];
  bool isLoading = false;

  Future<void> loadEvents(String endpoint) async {
    try {
      isLoading = true;
      final event = await api.callEventsDetailsApi(endpoint);
      if (event != null) {
        state = event;
        allEvents = state;
        isLoading = false;
      }
    } catch (e) {
      state = [];
      isLoading = false;
      rethrow; // Let UI handle error
    }
  }

  void filterEvent(String key) {
    {
      if (key.isEmpty) {
        state = allEvents;
      } else {
        state = allEvents
            .where((element) => element.eventname?.contains(key) ?? false)
            .toList();
      }
    }
  }
}
