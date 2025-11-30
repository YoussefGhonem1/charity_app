import 'package:flutter/material.dart';
import '../models/category_model.dart';

class CategoryChip extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;

  const CategoryChip({
    Key? key,
    required this.category,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFE7277) : Colors.white,
        border: Border.all(
          color: isSelected ? const Color(0xFFFE7277) : Colors.grey.shade300,
          width: 1.6,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: isSelected
            ? [
          BoxShadow(
            color: const Color(0xFFFE7277).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ]
            : null,
      ),
      child: Text(
        category.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}