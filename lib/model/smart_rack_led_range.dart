class SmartRackLedRange {
  final int start;
  final int end;

  SmartRackLedRange({required this.start, required this.end});

  factory SmartRackLedRange.fromJson(Map<String, dynamic> json) {
    return SmartRackLedRange(
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
