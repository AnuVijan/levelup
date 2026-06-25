
class Task {
  String title;
  String category;
  int points;
  bool completed;

  Task({
    required this.title,
    required this.category,
    required this.points,
    required this.completed,
  });
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'points': points,
      'completed': completed,
    };
  }
  factory Task.fromMap(Map<String, dynamic> map) {
  return Task(
    title: map['title'],
    category: map['category'],
    points: map['points'],
    completed: map['completed'],
  );
}
}