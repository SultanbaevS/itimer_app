class TimerData {
  final int id;
  final int constTime;
  final int selectedTime;
  final String sectionName;

  const TimerData({
    required this.id,
    required this.constTime,
    required this.sectionName,
    required this.selectedTime,
  });

  TimerData copyWith({
    final int? id,
    final int? constTime,
    final int? selectedTime,
    final String? sectionName,
  }) =>
      TimerData(
        id: id ?? this.id,
        constTime: constTime ?? this.constTime,
        sectionName: sectionName ?? this.sectionName,
        selectedTime: selectedTime ?? this.selectedTime,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          constTime == other.constTime &&
          selectedTime == other.selectedTime &&
          sectionName == other.sectionName;

  @override
  int get hashCode => id.hashCode ^ constTime.hashCode ^ selectedTime.hashCode ^ sectionName.hashCode;

  @override
  String toString() {
    return 'TimerData(id: $id, constTime: $constTime, selectedTime: $selectedTime, sectionName: $sectionName)';
  }
}
