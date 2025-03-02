/// Represents the different categories of tasks available in the application.
///
/// Using an enum ensures that categories are represented consistently
/// across the application regardless of the current language.
enum TaskCategory {
  /// Today tasks category
  today,

  /// Personal tasks category
  personal,

  /// Work tasks category
  work,

  /// Completed tasks category
  completed,

  /// All tasks category
  all,

  /// Other tasks that don't fit into the predefined categories
  other;

  /// Converts a string representation to the corresponding TaskCategory enum value.
  ///
  /// This is used when retrieving data from the database.
  ///
  /// @param value The string value to convert
  /// @return The corresponding TaskCategory or TaskCategory.other if no match is found
  static TaskCategory fromString(String value) {
    // Map to handle various localized versions of category names
    if (value.contains('Today') || value.contains('Сегодня')) {
      return TaskCategory.today;
    } else if (value.contains('Personal') || value.contains('Личные')) {
      return TaskCategory.personal;
    } else if (value.contains('Work') || value.contains('Работа')) {
      return TaskCategory.work;
    } else if (value.contains('Completed') || value.contains('Завершённые')) {
      return TaskCategory.completed;
    } else if (value.contains('All') || value.contains('Все')) {
      return TaskCategory.all;
    } else if (value == 'Other' || value == 'Другое') {
      return TaskCategory.other;
    }

    // If no match found, try to match with the enum name directly
    return TaskCategory.values.firstWhere(
      (category) => category.name == value,
      orElse: () => TaskCategory.other,
    );
  }

  /// Returns the string identifier of the category which is stored in the database.
  ///
  /// @return The name of the enum value
  String get identifier => name;
}
