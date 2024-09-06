// lib/src/data_entry/jui_date_picker/jui_date_picker_types.dart

enum JuiDatePickerMode {
  scrollYM,
  scrollYMD,
  scrollYMDWHM,
}

enum JuiCalendarSelectRangeType {
  custom,
  day,
  week,
  month,
}

enum JuiRangeType {
  hasMin,
  hasMax,
  common,
  hasMinAndMax,
}

class JuiTimeRange {
  final DateTime? min;
  final DateTime? max;

  const JuiTimeRange({this.min, this.max});
}