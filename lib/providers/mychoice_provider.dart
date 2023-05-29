import 'package:flutter/foundation.dart';
import 'package:sda_event_spoofer/providers/service_provider.dart';

class Wish extends ChangeNotifier {
  final List<Service> _list = [];
  List<Service> get getWishItems {
    return _list;
  }
   int? get count {
    return _list.length;
  }


  Future <void> addWishItem(
    String name,
    double price,
    List imagesUrl,
    String documentId,
    String serId,
  ) async{
    final service = Service(
        name: name,
        price: price,
        imagesUrl: imagesUrl,
        documentId: documentId,
        serId: serId);
    _list.add(service);
    notifyListeners();
  }

  void removeWishItem(Service service) {
    _list.remove(service);
    notifyListeners();
  }

  void clearWishList() {
    _list.clear();
    notifyListeners();
  }

  void removeThis (String id){
    _list.removeWhere((element) => element.documentId == id);
    notifyListeners();
  }
}