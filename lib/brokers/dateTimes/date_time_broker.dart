import 'i_date_time_broker.dart';

class DateTimeBroker implements IDateTimeBroker {
  @override
  Future<DateTime> getCurrentDateTimeOffsetAsync() async => DateTime.now();
}
