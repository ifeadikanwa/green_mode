import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String searchHint;
  final SearchDelegate searchDelegate;
  const SearchBar({
    Key? key,
    required this.searchHint,
    required this.searchDelegate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () => showSearch(
        context: context,
        delegate: searchDelegate,
      ),
      decoration: InputDecoration(
        hintText: searchHint,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white.withOpacity(0.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
