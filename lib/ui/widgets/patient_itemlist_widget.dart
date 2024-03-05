import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientItemList extends StatefulWidget {
  final String id;
  final int lastCondition;
  final String profile;
  final String status;

  const PatientItemList({
    Key? key,
    required this.id,
    required this.lastCondition,
    required this.profile,
    required this.status,
  }) : super(key: key);

  @override
  _PatientItemListState createState() => _PatientItemListState();
}

class _PatientItemListState extends State<PatientItemList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(children: [
        Row(
          children: [
            Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                child: Image.asset('assets/images/smile1.png'),
                decoration: BoxDecoration(
                    color: Colors.lightGreen.shade200,
                    border: Border.all(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0))),
            Column(
              children: [
                Text(widget.id),
                Text(widget.profile),
                Text(widget.status),
                Icon(Icons.arrow_circle_left_sharp)
              ],
            )
          ],
        ),
        Row(
          children: [
            OutlinedButton(onPressed: () {}, child: Text("Перейти в чат")),
            Text("Выписан")
          ],
        )
      ]),
    );
  }
}
