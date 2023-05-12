import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../utils/debouncer.dart';

class FilterTextField extends StatefulWidget {
  const FilterTextField({
    Key? key,
    this.controller,
    required this.hintText,
    required this.onTextChange,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String> onTextChange;

  @override
  State<FilterTextField> createState() => _FilterTextFieldState();
}

class _FilterTextFieldState extends State<FilterTextField> {
  late final textController = widget.controller ?? TextEditingController();
  final debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: AppColors.grey5,
        ),
        hoverColor: AppColors.grey6,
        prefixIcon: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.hardEdge,
          child: IconButton(
            onPressed: () => widget.onTextChange(textController.text),
            icon: const Icon(
              Icons.search,
              color: AppColors.grey3,
            ),
            hoverColor: AppColors.grey6,
          ),
        ),
        suffixIcon: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.hardEdge,
          child: IconButton(
            onPressed: () {
              textController.clear();
              widget.onTextChange(textController.text);
            },
            icon: const Icon(Icons.close_outlined),
            hoverColor: AppColors.grey6,
          ),
        ),
      ),
      onChanged: (value) {
        setState(() {});
        debouncer.run(() => widget.onTextChange(value));
      },
    );
  }
}
