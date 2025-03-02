import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';

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
    final localization = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () => onTap(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: localization.dueDate,
          border: OutlineInputBorder().copyWith(
            borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
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
    final localization = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () => onTap(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: localization.dueTime,
          border: OutlineInputBorder().copyWith(
            borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
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
