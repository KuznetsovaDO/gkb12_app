import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRichTextContainer extends StatelessWidget {
  final RichText richText;

  const CustomRichTextContainer({Key? key, required this.richText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: richText,
    );
  }
}
