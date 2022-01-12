import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:projeto1/app/modules/home/models/investimento.dart';
import 'package:projeto1/app/modules/home/models/sonho.dart';
import 'package:projeto1/app/modules/shared/utilities/constants.dart';
import 'package:projeto1/app/modules/home/home_controller.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
 // final String title;
 // const HomePage({Key key, this.title = "Home"}) : super(key: key);

  // var investimento = new List<Investimento>();

  var sonho = new List<Sonho>();

  HomePage(){
    sonho = [];

    // investimento.add(Investimento(dci: 131, nome: "Banco Caixa", vencimento: "10/10/2020", valorMinimo: 20));
    // investimento.add(Investimento(dci: 131, nome: "Banco Nubank", vencimento: "16/08/2020", valorMinimo: 500 ));
    // investimento.add(Investimento(dci: 131, nome: "Banco Ítau", vencimento: "15/03/2020", valorMinimo: 85));

  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

// controle de estado da 4 telas do bottombar
  final pageController = PageController();
  int get indexPage => pageController?.page?.round() ?? 0;
//////////////////////////////////////////////////////////////////////////


////////////////////////sonhos
///

  Future load() async {
    var  prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if(data != null){
      Iterable decoded = jsonDecode(data);
      List<Sonho> result = decoded.map((x) => Sonho.fromJson(x)).toList();

      setState(() {
        widget.sonho = result;
      });
    }
  }

  _HomePageState(){
    load();
  }

  Widget _listaSonhos() {
    return ListView.builder(
        itemCount: widget.sonho.length,
        itemBuilder: (context, index) {
          final sonh = widget.sonho[index];
          return ListTile(
            title: Text(sonh.nome),
            subtitle: Text(sonh.valorEstipulado.toString()),
          );
        });
  }

//////////////////////// carrega os investimentos

  // void adicionaItem(){

  //   // if(newTaskControler.text.isEmpty) return;

  //   // setState(() {
  //   //   widget.items.add(
  //   //     Item(
  //   //       title: newTaskControler.text,
  //   //       done: false,
  //   //     ),
  //   //   );
  //     // newTaskControler.text = "";
  //     // save();
  //   });
  // }

//////
///
/////////////////////////////////



// para montar o grafico de pizza
List<charts.Series<Task, String>> _seriesPieData;

  _generateData() {

    var piedata = [
      new Task('Work', 35.8, Color(0xff3366cc)),
      new Task('Eat', 8.3, Color(0xff990099)),
      new Task('Commute', 10.8, Color(0xff109618)),
      new Task('TV', 15.6, Color(0xfffdbe19)),
      new Task('Sleep', 19.2, Color(0xffff9900)),
      new Task('Other', 10.3, Color(0xffdc3912)),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
         labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
  }
///////////////////////////////////////////////////////////////////////////


/// widget nas telas 
    Widget _graficoPizza(){
      return Container(
        child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Time spent on daily tasks',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10.0,),
                        Expanded(
                          child: charts.PieChart(
                            _seriesPieData,
                            animate: true,
                            animationDuration: Duration(seconds: 5),
                             behaviors: [
                            new charts.DatumLegend(
                              outsideJustification: charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                              cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                              entryTextStyle: charts.TextStyleSpec(
                                  color: charts.MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Georgia',
                                  fontSize: 11),
                            )
                          ],
                           defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                             arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside)
        ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
    }

    Widget _apresentacao() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(
            'Olá,',
            style: styleTextApresentacao,
          ),
          SizedBox(height: 10.0),
          Text(
            'Mariana!',
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

  Widget _boxInvestimentoTotal() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: styleBoxTotalInvestimento,
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Você já investiu", style: styleletra),
              Text("Seu dinheiro já rendeu", style: styleletra),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("R\$ 3.200,00", style: styleletra),
              Text("R\$ 250,35", style: styleletra),
            ],
          ),
        ],
      ),
    );
  }



  /////////////////////////////////////////////////////////////////////////////////////
  
   Widget _listaTodosInvestimento1() {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: styleBoxTotalInvestimento,
        height: 160.0,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                    // padding: EdgeInsets.symmetric(vertical: 10.0),
                    width: 120,
                    child: RaisedButton(
                      elevation: 7.0,
                      onPressed: () => Modular.to.pushNamed('/ConfirmarInvestimento'),
                      padding: EdgeInsets.all(3.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: corSecundaria,
                      child: Text(
                        'SIMULAR',
                        style: TextStyle(
                          color: corFundo,
                          letterSpacing: 1.2,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]));
  }

  Widget _listaTodosInvestimento2() {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: styleBoxTotalInvestimento,
        height: 160.0,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                    // padding: EdgeInsets.symmetric(vertical: 10.0),
                    width: 120,
                    child: RaisedButton(
                      elevation: 7.0,
                      onPressed: () => Modular.to.pushNamed('/ConfirmarInvestimento'),
                      padding: EdgeInsets.all(3.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: corSecundaria,
                      child: Text(
                        'SIMULAR',
                        style: TextStyle(
                          color: corFundo,
                          letterSpacing: 1.2,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]));
  }

  Widget _listaTodosInvestimento3() {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: styleBoxTotalInvestimento,
        height: 160.0,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                    // padding: EdgeInsets.symmetric(vertical: 10.0),
                    width: 120,
                    child: RaisedButton(
                      elevation: 7.0,
                      onPressed: () => Modular.to.pushNamed('/ConfirmarInvestimento'),
                      padding: EdgeInsets.all(3.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: corSecundaria,
                      child: Text(
                        'SIMULAR',
                        style: TextStyle(
                          color: corFundo,
                          letterSpacing: 1.2,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]));
  }

  // tela do sonho que será separada chamada apenas quando clicar em sonho
  Widget _sonho() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(
            'Minha metas e sonhos',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Playstation 5',
            style: styleTextApresentacao,
          ),
          SizedBox(height: 10.0),
          InkWell(
            onTap: () => {},
            child: Container(
              alignment: Alignment.center,
              height: 40.0,
              width: 40.0,
              decoration: styleBoxEditSonho,
              child: Icon(Icons.edit),
            ),
          ),
        ]),
        InkWell(
          onTap: () => {},
          child: Icon(Icons.cloud),
        ),
      ],
    );
  }

  Widget _boxInformacaoSonho() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: styleBoxInformacaoSonho,
      height: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("VOCÊ JÁ ATINGIU"),
                    SizedBox(height: 5.0),
                    Text(
                      "R\$ 151,25",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("INVESTIDO ESSE MÊS"),
                    SizedBox(height: 5.0),
                    Text("INVESTIDO MÉDIA/MÊS"),
                  ],
                ),
              ]),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("DA SUA META"),
                    SizedBox(height: 5.0),
                    Text(
                      "R\$ 900,00",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "R\$ 50,00",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "R\$ 800,00",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ]),
        ],
      ),
    );
  }

  Widget _tempoSonho() {
    return Row(children: <Widget>[
      Text(
        "9 MESES",
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
          fontSize: 22.0,
        ),
      ),
      SizedBox(width: 8.0),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(
          "É O TEMPO QUE VOCÊ VAI DEMORAR",
          style: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 11.0,
          ),
        ),
        Text(
          "PARA ATINGIR SEU SONHO",
          style: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 11.0,
          ),
        )
      ]),
      SizedBox(width: 8.0),
      InkWell(
        onTap: () => {},
        child: Icon(Icons.question_answer),
      ),
    ]);
  }

  // final de tela do sonho
  /////////////////////////////////////////////////////////////////

  /// Tela de INVESTIMENTO  inicio
  Widget _pesquisarInvestimento() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: styleBoxPesquisaInvestimento,
      height: 40.0,
      child: TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: corLetraCinzaEscuro,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 8.0),
          prefixIcon: Icon(
            Icons.search,
            color: corLetraCinzaEscuro,
          ),
          hintText: 'Procure seu investimento',
          hintStyle: styleletra,
        ),
      ),
    );
  }

  // Widget _listaInvestimentos() {
  //   return Container(
  //     child: ListView.builder(
  //       itemCount: widget.investimento.length,
  //       itemBuilder: (context, index) {
  //         final invest = widget.investimento[index];
  //         return ListTile(
  //           title: Text(invest.nome),
  //           subtitle: Text(invest.vencimento),
  //           leading: Text(invest.dci.toString()),
  //           onLongPress: (){},
  //           trailing: Text(invest.valorMinimo.toString()),
  //         );
  //       }
  //     )
  //   ) ;
  // }

  /// Tela de INVESTIMENTO  final
  /////////////////////////////////////////////////////////////////////////////////////

  /// tela CARTEIRA inicio
  //////////////////////////////////////////////////////////////////////////////////////
  Widget _saldoTotal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(
            'Seu saldo é',
            style: styleTextApresentacao,
          ),
          SizedBox(height: 10.0),
          Text(
            'R\$ 3.200,00',
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

  Widget _botaoDepositar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: 130,
      child: RaisedButton(
        elevation: 2.0,
        onPressed: () => print('Login Button Pressed'),
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Column(
          children: <Widget>[
          InkWell(
            child: Icon(Icons.arrow_upward, color: corSecundaria, size: 35),
          ),
          Text(
            'DEPOSITAR',
            style: TextStyle(
              color: corSecundaria,
              letterSpacing: 1.2,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ]),
      ),
    );
  }
  
    Widget _botaoResgatar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: 130,
      child: RaisedButton(
        elevation: 2.0,
        onPressed: () => print('Login Button Pressed'),
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Column(
          children: <Widget>[
          InkWell(
            child: Icon(Icons.arrow_downward, color: corSecundaria, size: 35),
          ),
          Text(
            'RESGATAR',
            style: TextStyle(
              color: corSecundaria,
              letterSpacing: 1.2,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ]),
      ),
    );
  }

  Widget _depositarResgatar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      _botaoDepositar(),
      _botaoResgatar()
    ]);
  }
  


  //////////////////////////////////////////////////////////////////////////////////////

  ///independe de tela compartilhado em varias telas

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

  ////////////////////////////lista de sonhos
  // Widget _listaSonhos() {
  //   return Container(
  //     child: ListView.builder(
  //       itemCount: widget.investimento.length,
  //       itemBuilder: (context, index) {
  //         final invest = widget.investimento[index];
  //         return ListTile(
  //           title: Text(invest.nome),
  //           subtitle: Text(invest.vencimento),
  //           leading: Text(invest.dci.toString()),
  //           onLongPress: (){},
  //           trailing: Text(invest.valorMinimo.toString()),
  //         );
  //       }
  //     )
  //   ) ;
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: <Widget>[

          // pagina principal
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
                        vertical: 40.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _apresentacao(),
                          SizedBox(height: 25.0),
                          _boxInvestimentoTotal(),
                          SizedBox(height: 25.0),
                          SizedBox(
                            width: 200,
                            height: 100,
                            child: Container(
                              child: Scaffold(
                                body:_listaSonhos(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // pagina dos investimento
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
                        vertical: 40.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _disponivelCarteira(),
                          SizedBox(height: 15.0),
                          _pesquisarInvestimento(),
                          SizedBox(height: 20.0),
                          _listaTodosInvestimento1(),
                          SizedBox(height: 20.0),
                          _listaTodosInvestimento2(),
                          SizedBox(height: 20.0),
                          _listaTodosInvestimento3(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // pagina dos carteira
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
                        vertical: 40.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _saldoTotal(),
                          _depositarResgatar(),
                          //_graficoPizza()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // página de perfil de usuário 
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
                        vertical: 40.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 200,
                            height: 100,
                            child: Container(
                              child: Scaffold(
                                // body:_listaInvestimentos()
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          
          
        ],
      ),
       bottomNavigationBar: AnimatedBuilder(
          animation: pageController,
          builder: (_, __) {
            return BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              onTap: (index) {
                pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              currentIndex: indexPage,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home, color: corSecundaria, size: 25),
                    title: Text('Home', style: TextStyle(color: corSecundaria)),
                    activeIcon:
                        Icon(Icons.home, color: corSecundaria, size: 35)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_balance,
                        color: corSecundaria, size: 25),
                    title: Text('Investir',
                        style: TextStyle(color: corSecundaria)),
                    activeIcon: Icon(Icons.account_balance,
                        color: corSecundaria, size: 35)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.monetization_on,
                        color: corSecundaria, size: 25),
                    title: Text('Carteira',
                        style: TextStyle(color: corSecundaria)),
                    activeIcon: Icon(Icons.monetization_on,
                        color: corSecundaria, size: 35)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person, color: corSecundaria, size: 25),
                    title:
                        Text('Perfil', style: TextStyle(color: corSecundaria)),
                    activeIcon:
                        Icon(Icons.person, color: corSecundaria, size: 35))
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushNamed('/CriarSonho'),
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );

  }
}

// classe separada para montar o gráfico de pizza
class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}
