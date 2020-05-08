import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto1/app/modules/home/home_controller.dart';
import 'package:projeto1/app/modules/shared/utilities/constants.dart';

class EscolherSonhoInvestimento extends StatefulWidget {
  @override
  _EscolherSonhoInvestimentoState createState() => _EscolherSonhoInvestimentoState();
}

class _EscolherSonhoInvestimentoState extends ModularState<EscolherSonhoInvestimento, HomeController> {
    
    Widget _setaVoltar() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      InkWell(
        onTap: () => Modular.to.pop(),
        child: Icon(Icons.arrow_back, color: corFundo, size: 35),
      ),
    ]);
  }

    Widget _disponivelCarteira() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(
            'Disponível na carteira',
            style: styleTextlongo,
          ),
          SizedBox(height: 10.0),
          Text(
            'R\$ 1.100,00',
            style: styleTextlongo,
          ),
        ]),
        InkWell(
          onTap: () => {},
          child: Icon(Icons.people),
        ),
      ],
    );
  }

  Widget _confirmarInvestimento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("INVESTIMENTO CONFIRMADO", style:styleTextLetraInvestimento2),
        SizedBox(height: 10.0),
        InkWell(
          child: Icon(Icons.check_box, color: corVerde, size: 80),
        ),
      ]
    );
  }
  
  Widget _selecionarSonho() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("SELECIONE UM SONHO", style:styleTextLetraInvestimento2),
        InkWell(
          child: Icon(Icons.add, color: corVerde, size: 35),
          onTap: () => Modular.to.pushNamed('/CriarSonho'),
        ),
      ]
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
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        width: double.infinity,
                        child: Container(
                          color: corSecundaria,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _setaVoltar(),
                        SizedBox(height: 8.0),
                        _disponivelCarteira(),
                        SizedBox(height: 55.0),
                        _confirmarInvestimento(),
                        SizedBox(height: 25.0),
                        _selecionarSonho(),
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