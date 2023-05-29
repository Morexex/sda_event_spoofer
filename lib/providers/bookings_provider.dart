
import 'package:flutter/foundation.dart';
import 'package:sda_event_spoofer/providers/service_provider.dart';

class Book extends ChangeNotifier {
  final List<Service> _list = [];
  List<Service> get getItems {
    return _list;
  }

  double get totalPrice{
    var total = 0.0;
    for (var item in _list){
      total += item.price ;
    }return total;
  }

  int? get count {
    return _list.length;
  }

  void addItem(
    String name,
    double price,
    List imagesUrl,
    String documentId,
    String serId,
  ) {
    final service = Service(
        name: name,
        price: price,
        imagesUrl: imagesUrl,
        documentId: documentId,
        serId: serId);
    _list.add(service);
    notifyListeners();
  }

  void removeItem (Service service){
    _list.remove(service);
    notifyListeners();
  }

  void clearBook (){
    _list.clear();
    notifyListeners();
  }
}