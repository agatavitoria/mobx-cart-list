import 'package:mobx/mobx.dart';
import 'package:mobx_cart_list/app/models/item_model.dart';
import 'package:rxdart/rxdart.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final listItems = BehaviorSubject<List<ItemModel>>.seeded([]);
  final filter = BehaviorSubject<String>.seeded('');

  late ObservableStream<List<ItemModel>> output;

  _HomeControllerBase() {
    output = Rx.combineLatest2<List<ItemModel>, String, List<ItemModel>>(
    listItems.stream, filter.stream, (list, filter) {
        if (filter.isEmpty) {
          return list;
        } else {
          return list.where((item) => item.title.toLowerCase().contains(filter.toLowerCase())).toList();
        }
    }).asObservable(initialValue: []);
  }

  @action
  setFilter(String value) => filter.add(value);

  @action
  addItem(ItemModel model) {
    listItems.add(List<ItemModel>.from(listItems.value..add(model)));
  }

  @action
  removeItem(ItemModel model) {
    listItems.add(List<ItemModel>.from(listItems.value..remove(model)));
  }

  // @observable
  // ObservableList<ItemModel> listItems = [
  //   ItemModel(title: "Item 1", check: true),
  //   ItemModel(title: "Item 2", check: false),
  //   ItemModel(title: "Item 3", check: true),
  // ].asObservable();

  // @computed
  // int get totalChecked => output.data.where((item) => item.check);

  // @computed
  // List<ItemModel> get listFiltered {
  //   if (filter.isEmpty) {
  //     return listItems;
  //   } else {
  //     return listItems.where((item) => item.title.toLowerCase().contains(filter.toLowerCase())).toList();
  //   }
  // }

  // @observable
  // String filter = '';
}
