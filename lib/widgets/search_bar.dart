import 'package:flutter/material.dart';

class ProductSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;

  const ProductSearchBar({
    Key? key,
    required this.onChanged,
    this.onFilterTap,
  }) : super(key: key);

  @override
  State<ProductSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<ProductSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[500],
            size: 20,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_controller.text.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[500], size: 20),
                  onPressed: () {
                    _controller.clear();
                    widget.onChanged('');
                    setState(() {});
                  },
                ),
              IconButton(
                icon: Icon(Icons.tune, color: Colors.grey[600], size: 20),
                onPressed: widget.onFilterTap,
              ),
            ],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        ),
        onSubmitted: (_) => setState(() {}),
      ),
    );
  }
}
