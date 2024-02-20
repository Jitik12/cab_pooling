enum NumPeople<int> {
  one,
  two,
  three,
  four,
}

extension NumPeopleExtension on NumPeople {
  int get value {
    switch (this) {
      case NumPeople.one:
        return 1;
      case NumPeople.two:
        return 2;
      case NumPeople.three:
        return 3;
      case NumPeople.four:
        return 4;
      default:
        return 0;
    }
  }
}