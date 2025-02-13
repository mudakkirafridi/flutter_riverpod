

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course/model/item.dart';

final itemProvider = StateNotifierProvider<ItemNotifier , List<Item>>((ref){
  return ItemNotifier();
});


class ItemNotifier extends StateNotifier<List<Item>> {
  ItemNotifier() : super([]);

  // ADD NOTES
  void addItem (String name){
    final item = Item(id: DateTime.now().millisecondsSinceEpoch.toString(), name: name);
    state.add(item);
    state = state.toList();
  }


  // UPDATE ITEM 
  void updateNotes(String id , String name){
    int foundedIndex = state.indexWhere((item)=> item.id == id);
    state[foundedIndex].name = name;
    state = state.toList();
  }

  // DELETE NOTE
  void deleteNotes(String id){
    state.removeWhere((item)=> item.id == id);
    state = state.toList();
  }
}