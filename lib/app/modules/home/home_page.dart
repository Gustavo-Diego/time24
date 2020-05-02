import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto1/app/modules/shared/utilities/constants.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  final pageController = PageController();
  int get indexPage => pageController?.page?.round() ?? 0;

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
              Text("Você já investiu"),
              Text("Seu dinheiro já rendeu"),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("R\$ 3.200,00"),
              Text("R\$ 250,35"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listaSonhos() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile();
        });
  }

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
                        horizontal: 30.0,
                        vertical: 20.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _apresentacao(),
                          SizedBox(height: 25.0),
                          _boxInvestimentoTotal(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // pagina dos sonhos
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
                        vertical: 20.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // pagina dos investimentos
          Center(
            child: Container(
              child: Text('pagina dinheiro do usuário',
                  style: TextStyle(color: Colors.black)),
            ),
          ),

          // página de perfil de usuário 
          Center(
            child: Container(
              child: Text('pagina perfil do usuário',
                  style: TextStyle(color: Colors.black)),
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
                    icon: Icon(Icons.cloud_circle,
                        color: corSecundaria, size: 25),
                    title:
                        Text('Sonhos', style: TextStyle(color: corSecundaria)),
                    activeIcon: Icon(Icons.cloud_circle,
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

          
    );
  }
}
