import 'package:flutter_riverpod/flutter_riverpod.dart';



// FAMILY RIVERPOD PROVIDER EXAMPLE IS HERE
final multiplierProvider = StateProvider.family<int , Map<String , dynamic>>((ref, number){
  return number['number'] * 6;
});





final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(SearchState(search: '',isChanged: false));

  // funtion for searching
  void search(String query) {
    state = state.copyWith(search: query);
  }

  // function for change
  void change(bool isChanged){
    state = state.copyWith(isChanged: isChanged);
  }
}

// copyWith or handling multiple provider
class SearchState {
bool? isChanged;
String? search;

  SearchState({required this.search , required this.isChanged});
  SearchState copyWith({String? search , bool? isChanged}) {
  return SearchState(search: search ?? this.search, isChanged: isChanged ?? this.isChanged);
}
}
