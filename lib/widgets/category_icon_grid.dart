import 'package:flutter/material.dart';

class CategoryIconGrid extends StatelessWidget {
  final ValueChanged<String> onCategoryTap;

  const CategoryIconGrid({Key? key, required this.onCategoryTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 900;

    final categories = [
      {'name': 'Clothes', 'icon': Icons.checkroom},
      {'name': 'Shoes', 'icon': Icons.directions_walk},
      {'name': 'Bags', 'icon': Icons.shopping_bag},
      {'name': 'Electronics', 'icon': Icons.devices},
      {'name': 'Watch', 'icon': Icons.watch},
      {'name': 'Jewelry', 'icon': Icons.diamond},
      {'name': 'Kitchen', 'icon': Icons.local_dining},
      {'name': 'Toys', 'icon': Icons.toys},
    ];

    // Responsive values
    late int crossAxisCount;
    late double containerWidth;
    late double containerHeight;
    late double iconSize;
    late double fontSize;
    late double spacing;
    late double padding;

    if (isMobile) {
      crossAxisCount = 4;
      containerWidth = 55;
      containerHeight = 50;
      iconSize = 24;
      fontSize = 11;
      spacing = 10;
      padding = 16;
    } else if (isTablet) {
      crossAxisCount = 5;
      containerWidth = 70;
      containerHeight = 64;
      iconSize = 28;
      fontSize = 12;
      spacing = 12;
      padding = 20;
    } else {
      // Large screens
      crossAxisCount = 6;
      containerWidth = 80;
      containerHeight = 72;
      iconSize = 32;
      fontSize = 13;
      spacing = 14;
      padding = 24;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.95,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              onCategoryTap(category['name'].toString().toLowerCase());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: containerWidth,
                  height: containerHeight,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    color: Colors.black,
                    size: iconSize,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category['name'].toString(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
