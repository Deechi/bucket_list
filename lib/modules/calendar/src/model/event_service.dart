import 'package:bucket_list/modules/calendar/src/entity/event.dart';
import 'package:bucket_list/modules/calendar/src/ext/same_date.dart';

class EventService {
  List<Event> filter(List<Event> eventList, DateTime dateTime) {
    return eventList.where((e) => dateTime.isSameDay(e.dateTime!)).toList();
  }
}
