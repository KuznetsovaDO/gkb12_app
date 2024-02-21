import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomToggleButtons extends StatefulWidget {
  final int initialSelectedIndex;

  final Function(int) onPressed;
  final bool isSmiles;

  const CustomToggleButtons({
    Key? key,
    this.initialSelectedIndex = 0,
    required this.onPressed,
    this.isSmiles = true,
  }) : super(key: key);

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  int selectedButtonIndex = 0;
  List<String> ImagePaths = [
    'assets/images/smile1.png',
    'assets/images/smile2.png',
    'assets/images/smile3.png',
    'assets/images/smile4.png',
    'assets/images/smile5.png',
  ];

  @override
  void initState() {
    super.initState();
    selectedButtonIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        fillColor: Color.fromARGB(0, 0, 0, 0),
        splashColor: Color.fromARGB(0, 0, 0, 0),
        constraints: BoxConstraints.loose(Size.infinite),
        direction: Axis.horizontal,
        borderRadius: BorderRadius.circular(10),
        renderBorder: false,
        isSelected: List.generate(5, (index) => index == selectedButtonIndex),
        children: [
          Padding(
              padding: EdgeInsets.all(5),
              child: SizedBox(
                width: 60, // <-- Your width
                height: 60,
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(4),
                    child: widget.isSmiles
                        ? Image.asset('assets/images/smile1.png')
                        : Text(
                            '1',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: 20,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                    decoration: BoxDecoration(
                        color: Colors.lightGreen.shade200,
                        border: Border.all(
                          width: 1,
                          color: selectedButtonIndex == 0
                              ? Colors.green.shade700
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
              )),
          Padding(
              padding: EdgeInsets.all(5),
              child: SizedBox(
                width: 60, // <-- Your width
                height: 60,
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(4),
                    child: widget.isSmiles
                        ? Image.asset('assets/images/smile2.png')
                        : Text(
                            '2',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: 20,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                    decoration: BoxDecoration(
                        color: Colors.lightGreen.shade100,
                        border: Border.all(
                          width: 1,
                          color: selectedButtonIndex == 1
                              ? Colors.green.shade500
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
              )),
          Padding(
              padding: EdgeInsets.all(5),
              child: SizedBox(
                width: 60, // <-- Your width
                height: 60,
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(4),
                    child: widget.isSmiles
                        ? Image.asset('assets/images/smile3.png')
                        : Text(
                            '3',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: 20,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        border: Border.all(
                          width: 1,
                          color: selectedButtonIndex == 2
                              ? Colors.yellow
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
              )),
          Padding(
              padding: EdgeInsets.all(5),
              child: SizedBox(
                width: 60, // <-- Your width
                height: 60,
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(4),
                    child: widget.isSmiles
                        ? Image.asset('assets/images/smile4.png')
                        : Text(
                            '4',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: 20,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                    decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        border: Border.all(
                          width: 1,
                          color: selectedButtonIndex == 3
                              ? Colors.orange
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
              )),
          Padding(
              padding: EdgeInsets.all(5),
              child: SizedBox(
                width: 60, // <-- Your width
                height: 60,
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(4),
                    child: widget.isSmiles
                        ? Image.asset('assets/images/smile5.png')
                        : Text(
                            '5',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: 20,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                    decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        border: Border.all(
                          width: 1,
                          color: selectedButtonIndex == 4
                              ? Colors.red
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
              ))
        ],
        onPressed: (int index) => setState(() => selectedButtonIndex = index));
  }
}
