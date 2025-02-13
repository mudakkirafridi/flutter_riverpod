import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course/riverpod/search_provider.dart';

class Home3 extends ConsumerWidget {
  const Home3({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {




    //  THIS IS THE EXAMPLE OF FAMILY PROVIDER IN RIVERPOD
    Map<String , dynamic> map = {
     "number" : 2
    };
    final numbers = ref.watch(multiplierProvider(map));




    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
                            // FAMILY RIVERPOD VALUE IS HERE
        title:  Text('search Provider ${numbers.toString()}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         TextFormField(
          onChanged: (value){
            ref.read(searchProvider.notifier).search(value);
          },
         ),
         const SizedBox(height: 30,),
         Consumer(builder: (context,ref , child){
          
    final searches = ref.watch(searchProvider);
          return Text(searches.search!);
         }),

         Consumer(builder: (context,ref,child){
          final searches = ref.watch(searchProvider);
          return Switch(value: searches.isChanged!, onChanged: (value){
            ref.read(searchProvider.notifier).change(value);
          });
         })
        ],
      ),
    );
  }
}