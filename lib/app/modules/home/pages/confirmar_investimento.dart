import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto1/app/modules/home/home_controller.dart';
import 'package:projeto1/app/modules/shared/utilities/constants.dart';

class ConfirmarInvestimento extends StatefulWidget {
  @override
  _ConfirmarInvestimentoState createState() => _ConfirmarInvestimentoState();
}

class _ConfirmarInvestimentoState extends ModularState<ConfirmarInvestimento, HomeController> {

  Widget _disponivelCarteira() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(
            'Disponível na carteira',
            style: styleTextApresentacao,
          ),
          SizedBox(height: 10.0),
          Text(
            'R\$ 1.100,00',
            style: styleTextApresentacao,
          ),
        ]),
        InkWell(
          onTap: () => {},
          child: Icon(Icons.people),
        ),
      ],
    );
  }

    Widget _investimentoEscolhido() {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: caixaEscritaBranca,
        height: 120.0,
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("CDI 138%", style:styleTextLetraInvestimento1),
              Text("BANCO DO BRASIL", style:styleTextLetraInvestimento2),
              Text("VENCIMENTO 31/10/2021", style:styleTextLetraInvestimento1),
              SizedBox(height: 10.0),
              Text("VALOR MÍNIMO R\$ 500,00", style:styleTextLetraInvestimento1),
            ]));
  }
  
  
    Widget _valorNoInvestimento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Quanto você quer investir?',
          style: styleTextLetraInvestimento2,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: caixaEscritaBranca,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.number,
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
  
   Widget _rendimentoInvestimento() {
     return Row(
       children: <Widget>[
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Text("ESSE INVESTIMENTO NO", style: styleTextRendimentoInvestimento1),
             Text("VENCIMENTO VPCÊ TERÁ", style: styleTextRendimentoInvestimento1),
           ],
         ),
         SizedBox(width: 10.0),
         Text("R\$ 3.000,00", style: styleTextRendimentoInvestimento2),
       ]
     );
   }
  
    Widget _btnConfirmarInvestimeto() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => Modular.to.pushNamed('/EscolherSonhoInvestimento'),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: corSecundaria,
        child:
              Text(
                'CONFIRMAR INVESTIMENTO',
                style: TextStyle(
                  color: corFundo,
                  letterSpacing: 1.3,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
      ),
    );
  }

  Widget _setaVoltar() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      InkWell(
        onTap: () => Modular.to.pop(),
        child: Icon(Icons.arrow_back, color: corFundo, size: 35),
      ),
    ]);
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
                      horizontal: 30.0,
                      vertical: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _setaVoltar(),
                        SizedBox(height: 8.0),
                        _disponivelCarteira(),
                        SizedBox(height: 35.0),
                        _investimentoEscolhido(),
                        SizedBox(height: 15.0),
                        _valorNoInvestimento(),
                        SizedBox(height: 15.0),
                        _rendimentoInvestimento(),
                        SizedBox(height: 15.0),
                        _btnConfirmarInvestimeto(),
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