class Task {
  final String id;
  final String title;
  final String description;
  final String? documentationLink;
  List<dynamic>? feedback;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.documentationLink,
    this.feedback,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? documentationLink,
    List<dynamic>? feedback,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      documentationLink: documentationLink,
      feedback: feedback
    );
  }

  factory Task.fromJson(String id, Map<String, dynamic> json) {
    return Task(
      id: id,
      title: json['title'] as String,
      description: json['description'] as String,
      documentationLink: json['documentationLink'],
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'documentationLink': documentationLink,
      'feedback': feedback,
    };
  }
}
