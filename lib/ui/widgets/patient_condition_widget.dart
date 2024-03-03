import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomToggleButtons extends StatefulWidget {
  final int initialSelectedIndex;
  final bool isSmiles;
  final Function(int) onSelectedIndexChangedSmiles;
  final Function(int) onSelectedIndexChangedNumbers;

  const CustomToggleButtons({
    Key? key,
    this.initialSelectedIndex = 0,
    this.isSmiles = true,
    required this.onSelectedIndexChangedSmiles,
    required this.onSelectedIndexChangedNumbers,
  }) : super(key: key);

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

int endSelected = 0;
int endSelectedIfNums = 0;

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  int selectedIndex = 0;
  double paddingForButton = 8;
  double paddingForSmile = 8;
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
    selectedIndex = widget.initialSelectedIndex;
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
        isSelected: List.generate(5, (index) => index == selectedIndex),
        children: [
          Padding(
              padding: EdgeInsets.all(paddingForButton),
              child: SizedBox(
                width: 60, // <-- Your width
                height: 60,
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(paddingForSmile),
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
                          width: selectedIndex == 0 ? 2 : 0.5,
                          color: selectedIndex == 0
                              ? Colors.green.shade900
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
              )),
          Padding(
              padding: EdgeInsets.all(paddingForButton),
              child: SizedBox(
                width: 60, // <-- Your width
                height: 60,
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(paddingForSmile),
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
                          width: selectedIndex == 1 ? 2 : 0.5,
                          color: selectedIndex == 1
                              ? Colors.green.shade800
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
              )),
          Padding(
              padding: EdgeInsets.all(paddingForButton),
              child: SizedBox(
                width: 60, // <-- Your width
                height: 60,
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(paddingForSmile),
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
                          width: selectedIndex == 2 ? 2 : 0.5,
                          color: selectedIndex == 2
                              ? Colors.yellow.shade800
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
              )),
          Padding(
              padding: EdgeInsets.all(paddingForButton),
              child: SizedBox(
                width: 60, // <-- Your width
                height: 60,
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(paddingForSmile),
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
                          width: selectedIndex == 3 ? 2 : 0.5,
                          color: selectedIndex == 3
                              ? Colors.orange.shade800
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
              )),
          Padding(
              padding: EdgeInsets.all(paddingForButton),
              child: SizedBox(
                width: 60, // <-- Your width
                height: 60,
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(paddingForSmile),
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
                          width: selectedIndex == 4 ? 2 : 0.5,
                          color: selectedIndex == 4 ? Colors.red : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0))),
              ))
        ],
        onPressed: (int index) {
          setState(() {
            selectedIndex = index;
          });
          if (widget.isSmiles) {
            widget.onSelectedIndexChangedSmiles(index);
          } else {
            widget.onSelectedIndexChangedNumbers(index);
          } // Вызываем обратный вы
        });
  }
}
