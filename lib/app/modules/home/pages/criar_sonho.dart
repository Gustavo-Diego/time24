import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto1/app/modules/home/home_controller.dart';
import 'package:projeto1/app/modules/home/models/sonho.dart';
import 'package:projeto1/app/modules/shared/utilities/constants.dart';

//teste
import 'package:shared_preferences/shared_preferences.dart';

class CriarSonho extends StatefulWidget {

  var sonho = new List<Sonho>();

  CriarSonho(){
    sonho = [];
  }

  @override
  _CriarSonhoState createState() => _CriarSonhoState();
}

class _CriarSonhoState extends ModularState<CriarSonho, HomeController> {

//////////////////////////////////////////////////////////////////////////////
  var newTaskControlerSonho = TextEditingController();
  var newTaskControlerValorSonho = TextEditingController();

  void adicionaItem(){

    if(newTaskControlerSonho.text.isEmpty || newTaskControlerValorSonho.text.isEmpty) return print("voltou nada");

    setState(() {
      widget.sonho.add(
        Sonho(
          nome: newTaskControlerSonho.text,
          valorEstipulado: num.parse(newTaskControlerValorSonho.text),
        ),
      );
      newTaskControlerSonho.text = "";
      newTaskControlerValorSonho.text = "0";
      save();
    });
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode( widget.sonho ));
  }

  void callAll() {
    adicionaItem();
    Modular.to.pop();
    //load();
      }
    
    ///////////////////////////////////////////////////////////////////////////////
    
        Widget _setaVoltar() {
        return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          InkWell(
            onTap: () => Modular.to.pop(),
            child: Icon(Icons.arrow_back, color: corSecundaria, size: 35),
          ),
        ]);
      }
    
       Widget _escolherImagem() {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 100.0,
              width: 100.0,
              child: Icon(Icons.add_a_photo, color: corFundo, size: 50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: corSecundaria,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0, 1),
                    blurRadius: 6.0,
                  ),
                ],
              ),
            ),
          )
        ]);
      }
    
     Widget _qualSonho() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Qual seu Sonho?',
              style: TextStyle(
                color: corSecundaria,
                fontWeight: FontWeight.normal,
                fontFamily: 'OpenSans',
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              decoration: caixaEscritaBranca,
              height: 60.0,
              child: TextField(
                keyboardType: TextInputType.text,
                controller: newTaskControlerSonho,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  // hintText: 'Sonho',
                  //hintStyle: kHintTextStyle,
                ),
              ),
            ),
          ],
        );
      }
    
      Widget _valorSonho() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Quanto vai precisar economizar?',
              style: TextStyle(
                color: corSecundaria,
                fontWeight: FontWeight.normal,
                fontFamily: 'OpenSans',
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              decoration: caixaEscritaBranca,
              height: 60.0,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: newTaskControlerValorSonho,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  // hintText: 'Quanto precisa',
                  // hintStyle: kHintTextStyle,
                ),
              ),
            ),
          ],
        );
      }
    
      Widget _btnSalvarSonhoCadastrado() {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          width: double.infinity,
          child: RaisedButton(
            elevation: 5.0,
            onPressed: () => callAll(),
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: corSecundaria,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'CONTINUAR',
                    style: TextStyle(
                      color: corFundo,
                      letterSpacing: 1.2,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  InkWell(
                    child: Icon(Icons.arrow_forward, color: corFundo, size: 25),
                  ),
                ]),
          ),
        );
      }
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: PageView(children: <Widget>[
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Container(
                        color: corCinzaClaro,
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 40.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _setaVoltar(),
                            _escolherImagem(),
                            SizedBox(height: 20.0),
                            _qualSonho(),
                            SizedBox(height: 20.0),
                            _valorSonho(),
                            SizedBox(height: 20.0),
                            _btnSalvarSonhoCadastrado()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        );
      }
    
}