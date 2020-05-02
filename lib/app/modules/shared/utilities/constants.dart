import 'package:flutter/material.dart';

final Color corFundo = Color.fromARGB(255, 255, 255, 255);

final Color corSecundaria = Color.fromARGB(255, 210, 210, 210);

  final styleTextApresentacao = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
    fontSize: 28.0,
  );

  final styleBoxTotalInvestimento = BoxDecoration(
    color: corSecundaria,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black,
        blurRadius: 26.0,
        offset: Offset(1, 1),
      ),
    ],
  );