import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';

class FilterSection<T> extends StatelessWidget {
  final String title;
  final List<T> options;
  final T? selectedOption;
  final ValueChanged<T> onSelect;
  final bool displayAsString;

  const FilterSection({
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onSelect,
    this.displayAsString = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTextStyles.font20Bold
                .copyWith(color: AppColors.primaryColor)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          children: options.map((option) {
            final isSelected = selectedOption == option;
            return FilterChip(
              checkmarkColor: Colors.white,
              label: Text(
                displayAsString ? option.toString() : option as String,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.grey,
                ),
              ),
              selected: isSelected,
              selectedColor: AppColors.primaryColor,
              onSelected: (_) => onSelect(option),
              backgroundColor: CupertinoColors.white,
            );
          }).toList(),
        ),
      ],
    );
  }
}
