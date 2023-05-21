import 'package:intl/intl.dart';

String convertDateTime({required String dateTime}) {
  Intl.defaultLocale = 'th';

  return DateFormat.yMMMd('th').add_jms().format(DateTime.parse(dateTime));
}
