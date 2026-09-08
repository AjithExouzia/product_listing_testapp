import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  final List<String> categories;
  final ValueChanged<String> onCategorySelected;
  final String initialCategory;

  const CategoryFilter({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
    this.initialCategory = 'all',
  }) : super(key: key);

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // All category button
            _buildCategoryButton('all', 'All'),
            const SizedBox(width: 8),
            // Other categories
            ...widget.categories.map((category) {
              // Capitalize first letter
              final displayName = category[0].toUpperCase() + category.substring(1);
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _buildCategoryButton(category, displayName),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category, String label) {
    final isSelected = _selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
        widget.onCategorySelected(category);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: isSelected ? null : Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
