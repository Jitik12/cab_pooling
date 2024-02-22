enum TimeSlot {
  hourHalf('1/2 hour'),
  hour_1('1 hour'),
  hour_2('2 hour');

  final String label;

  const TimeSlot(this.label);

  String get value => label;
}
