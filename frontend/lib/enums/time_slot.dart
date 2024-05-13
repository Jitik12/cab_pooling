enum TimeSlot {
  hour_0('00', 0),
  hour_1('01', 1),
  hour_2('02', 2),
  hour_3('03', 3),
  hour_4('04', 4),
  hour_5('05', 5),
  hour_6('06', 6),
  hour_7('07', 7),
  hour_8('08', 8),
  hour_9('09', 9),
  hour_10('10', 10),
  hour_11('11', 11),
  hour_12('12', 12),
  hour_13('13', 13),
  hour_14('14', 14),
  hour_15('15', 15),
  hour_16('16', 16),
  hour_17('17', 17),
  hour_18('18', 18),
  hour_19('19', 19),
  hour_20('20', 20),
  hour_21('21', 21),
  hour_22('22', 22),
  hour_23('23', 23),
  hour_24('24', 24);

  final String label;
  final int val;

  const TimeSlot(this.label, this.val);

  String get value => label;
}
