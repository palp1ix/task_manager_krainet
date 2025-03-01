class Task {
  Task({
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.isCompleted,
  });

  final String title;
  final String description;
  final String category;
  final DateTime date;
  final bool isCompleted;
}
