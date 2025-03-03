import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A widget that displays date picker input field
/// Used in the add task screen to select a due date
class DatePickerField extends StatelessWidget {
  final DateTime selectedDate;
  final Function(BuildContext) onTap;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onTap(context),
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.colorScheme.surfaceContainer,
          // Remove all borders but keep the shape
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('MM dd').format(selectedDate),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}

/// A widget that displays time picker input field
/// Used in the add task screen to select a due time
class TimePickerField extends StatelessWidget {
  final TimeOfDay selectedTime;
  final Function(BuildContext) onTap;

  const TimePickerField({
    super.key,
    required this.selectedTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onTap(context),
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.colorScheme.surfaceContainer,
          // Remove all borders but keep the shape
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedTime.format(context),
            ),
            const Icon(Icons.access_time),
          ],
        ),
      ),
    );
  }
}
