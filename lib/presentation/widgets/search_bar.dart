import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    this.controller,
    required this.onSubmitted,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function(String value) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border.fromBorderSide(BorderSide()),
        ),
        child: TextField(
          onSubmitted: onSubmitted,
          keyboardType: TextInputType.text,
          controller: controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Padding(
              padding: EdgeInsets.only(left: 13),
              child: Icon(Icons.search),
            ),
          ),
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }
}
