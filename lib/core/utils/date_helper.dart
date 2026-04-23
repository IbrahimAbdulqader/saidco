class DateHelper {
  static String formatDate(DateTime? date) {
    String getWeekdayName(int weekday) {
      switch (weekday) {
        case 1:
          return 'الإتنين';
        case 2:
          return 'الثلاثاء';
        case 3:
          return 'الأربعاء';
        case 4:
          return 'الخميس';
        case 5:
          return 'الجمعة';
        case 6:
          return 'السبت';
        case 7:
          return 'الأحد';
        default:
          return '';
      }
    }

    if (date == null) return 'لا يوجد';
    return '${date.day} / ${date.month} / ${date.year} - ${getWeekdayName(date.weekday)}';
  }

  static String formatShortDate(DateTime? date) {
    if (date == null) return 'لا يوجد';
    return '${date.day} / ${date.month} / ${date.year}';
  }
}
