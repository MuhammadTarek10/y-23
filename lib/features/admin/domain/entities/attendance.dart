class Attendance {
  final String? id;
  final Map<String, dynamic>? attendance;

  Attendance({
    this.id,
    this.attendance,
  });

  Attendance copyWith({
    String? id,
    Map<String, dynamic>? attendance,
  }) {
    return Attendance(
      id: id ?? this.id,
      attendance: attendance ?? this.attendance,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attendance': attendance,
    };
  }

  factory Attendance.fromJson(String id, Map<String, dynamic> json) {
    return Attendance(
      id: id,
      attendance: json['attendance'],
    );
  }
}
