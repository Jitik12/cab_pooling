enum TimeSlot<String> {
  hourHalf,
  hour_1,
  hour_2,
}

extension TimeSlotExtension on TimeSlot {
  String get name {
    switch (this) {
      case TimeSlot.hourHalf:
        return '1/2 hour';
      case TimeSlot.hour_1:
        return '1 hour';
      case TimeSlot.hour_2:
        return '2 Hour';
      default:
        return '';
    }
  }
}
