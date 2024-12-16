import 'dart:math' as math;

import 'package:app_fliplaptop/components/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 0.8.sw,
              child: Text(
                widget.title,
                style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _showContent = !_showContent;
                });
              },
              child: _showContent
                  ? Transform.rotate(
                      angle: 130 * math.pi / 260,
                      // origin: Offset.fromDirection(-123),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 20.r,
                        color: highlightedText,
                      ),
                    )
                  : Icon(
                      Icons.arrow_forward_ios,
                      size: 20.r,
                      color: Colors.black,
                    ),
            ),
          ],
        ),
        _showContent
            ? Container(
                padding: EdgeInsets.only(right: 23.r),
                child: Text(
                  widget.content,
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, color: Color(0xff636365), height: 2),
                ),
              )
            : Container(),
      ]),
    );
  }
}
