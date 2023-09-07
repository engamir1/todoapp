import 'package:flutter/material.dart';

import '../components/form_field.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController serchEditingController = TextEditingController();
  String? val;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, right: 12, left: 12),
        child: Column(
          children: [
            CustomInputField(
              // onSaved: (value) {
              //   setState(() {
              //     serchEditingController.text = value!;
              //   });
              // },
              onChanged: (value) {
                setState(() {
                  // serchEditingController.text = value;
                });
              },
              iconData: Icons.mic,
              controller: serchEditingController,
              hintText: "Enter word",
            ),
            Text(serchEditingController.text)
          ],
        ),
      ),
    );
  }
}
