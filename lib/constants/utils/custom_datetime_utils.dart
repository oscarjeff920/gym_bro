class CustomDatetimeUtils extends DateTime{
  CustomDatetimeUtils(super.year);

  static String dateToString(int year, int month, int day) {
    String yearString;
    String monthString;
    String dayString;

    if (year.toString().length > 2) {
      yearString = year.toString().substring(year.toString().length - 2);
    } else {
      yearString = year.toString();
    }

    if (month.toString().length == 1) {
      monthString = "0$month";
    } else {
      monthString = month.toString();
    }

    if (day.toString().length == 1) {
      dayString = "0$day";
    } else {
      dayString = day.toString();
    }

    return "$dayString/$monthString/$yearString";
  }
}