import 'package:intl/src/intl/date_format.dart';
import 'package:intl/intl.dart';

String convertDateTime({required String dateTime}) {
  Intl.defaultLocale = 'th';

  return DateFormat.yMMMd('th').format(DateTime.parse(dateTime));
}
