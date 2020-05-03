import 'package:projeto1/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto1/app/modules/home/pages/criar_sonho.dart';
import 'package:projeto1/app/modules/home/pages/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
        Router('/CriarSonho', child: (_, args) => CriarSonho()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
