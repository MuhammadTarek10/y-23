class Session {
  final String id;
  final String title;
  final String instructor;
  Map<String, dynamic>? points;
  String? documentationLink;
  String? photoUrl;
  List<dynamic>? feedback;

  Session({
    required this.id,
    required this.title,
    required this.instructor,
    this.points,
    this.documentationLink,
    this.photoUrl,
    this.feedback,
  });

  Session copyWith({
    String? id,
    String? title,
    String? instructor,
    Map<String, String>? points,
    String? documentationLink,
    String? photoUrl,
  }) {
    return Session(
      id: id ?? this.id,
      title: title ?? this.title,
      instructor: instructor ?? this.instructor,
      points: points,
      documentationLink: documentationLink,
      photoUrl: photoUrl,
    );
  }

  factory Session.fromJson(String id, Map<String, dynamic> json) {
    return Session(
      id: id,
      title: json['title'] as String,
      instructor: json['instructor'] as String,
      points: json['points'],
      documentationLink: json['documentationLink'],
      photoUrl: json['photoUrl'],
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instructor': instructor,
      'points': points,
      'documentationLink': documentationLink,
      'photoUrl': photoUrl,
      'feedback': feedback
    };
  }
}
