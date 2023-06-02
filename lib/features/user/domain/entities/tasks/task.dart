class Task {
  final String id;
  final String title;
  final String description;
  final String? documentationLink;
  final int? points;
  final String? photoUrl;
  List<dynamic>? feedback;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.documentationLink,
    this.points,
    this.photoUrl,
    this.feedback,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? documentationLink,
    int? points,
    String? photoUrl,
    List<dynamic>? feedback,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      documentationLink: documentationLink,
      points: points,
      photoUrl: photoUrl,
      feedback: feedback
    );
  }

  factory Task.fromJson(String id, Map<String, dynamic> json) {
    return Task(
      id: id,
      title: json['title'] as String,
      description: json['description'] as String,
      documentationLink: json['documentationLink'],
      points: json['points'],
      photoUrl: json['photoUrl'],
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'documentationLink': documentationLink,
      'points': points,
      'photoUrl': photoUrl,
      'feedback': feedback,
    };
  }
}
