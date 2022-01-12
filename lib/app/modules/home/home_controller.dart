import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto1/app/modules/shared/services/local_storage_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  
  // @observable
  // int value = 0;

  final ILocalStorage _storage = Modular.get();
  
  @observable
  String text = '';

  @action
 setText(String value) => text = value;

    @observable
  ObservableList<String> sonho = <String>[].asObservable();

  // @action
  // void increment() {
  //   value++;
  // }

 _HomeControllerBase(){
   init();
 }

 @action
  init() async{
    List<String> listLocal = await _storage.get('sonho');

    if( listLocal == null){
        sonho = <String>[].asObservable();
        print("nulo");
    } else{
        sonho = listLocal.asObservable();
        print("chegou dados");
    }

  }

  @action
 void save(){
   sonho.add(text);
   _storage.put('sonho', sonho);
 }
 
  @action
 void delete( int index){
   sonho.removeAt(index);
   _storage.put('sonho', sonho);
 }

}
