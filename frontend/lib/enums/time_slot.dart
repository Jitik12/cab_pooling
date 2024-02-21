enum TimeSlot {
  hourHalf,
  hour_1,
  hour_2;

  
}
extension TimeSlotExtension on TimeSlot {
  String get value {
    switch (this) {
      case TimeSlot.hourHalf:
        return '30 minutes';
      case TimeSlot.hour_1:
        return '1 hour';
      case TimeSlot.hour_2:
        return '2 hours';
      default:
        return '';
    }
  }
}

