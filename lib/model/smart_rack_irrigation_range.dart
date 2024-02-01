class SmartRackIrrigationRange {
  final int start;
  final int end;

  SmartRackIrrigationRange({required this.start, required this.end});

  factory SmartRackIrrigationRange.fromJson(Map<String, dynamic> json) {
    return SmartRackIrrigationRange(
      start: json['start'] as int,
      end: json['end'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }
}
