import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String value) onSearch;
  final String hintText;
  final bool autofocus;
  final VoidCallback? onFilterTap;
  final bool showFilterButton;

  const CustomSearchBar({
    super.key,
    required this.onSearch,
    this.hintText = 'Search inventory...',
    this.autofocus = false,
    this.onFilterTap,
    this.showFilterButton = true,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _hasText = _searchController.text.isNotEmpty;
      });
      widget.onSearch(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search icon
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 12),
            child: Icon(Icons.search, color: Colors.black54, size: 24),
          ),

          // Search field
          Expanded(
            child: TextField(
              controller: _searchController,
              autofocus: widget.autofocus,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              textInputAction: TextInputAction.search,
              onSubmitted: widget.onSearch,
            ),
          ),

          // Clear button (only shows when there's text)
          if (_hasText)
            GestureDetector(
              onTap: _clearSearch,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.close, color: Colors.grey[500], size: 20),
              ),
            ),

          // // Optional filter button
          // if (widget.showFilterButton)
          //   GestureDetector(
          //     onTap: widget.onFilterTap,
          //     child: Container(
          //       padding: const EdgeInsets.all(8),
          //       margin: const EdgeInsets.only(right: 8),
          //       decoration: BoxDecoration(
          //         color: Colors.grey[100],
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //       child: const Icon(
          //         Icons.filter_list,
          //         color: Colors.black54,
          //         size: 22,
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
