import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// ///// SIMPLE PROVIDER WITHOUT STATE    to read int value 
// final age = Provider((ref){
//   return 25;
// });



// PROVIDER IN RIVERPOD WITH STATES 
final counter = StateProvider((ref) => 10);

// second way
// final age = StateProvider((ref){
//   return 25;
// });



//// SWITCH VARIABLE IN RIVERPOD
final isOn = StateProvider((ref) => false);




class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Counter Example"),
      ),
      body: Column(
        children: [
          Consumer(builder: (context,ref , child){
        final myCounter = ref.watch(counter);
        print('build2');
        return Center(
        child: Text(myCounter.toString()),
      );
      }) ,

      //////// SWITCH EXAMPLE

      Consumer(builder: (context,ref , child){
        final switchCondition = ref.watch(isOn);
        print('build2');
        return Switch(value: switchCondition, onChanged: (value){
         ref.read(isOn.notifier).state = value;
        });
      }) ,
        ],
      ),
    floatingActionButton: FloatingActionButton(onPressed: (){



      // for increment the value in riverpod provider veriable
      ref.read(counter.notifier).state++;


      // for decrement the value in riverpod provider veriable
      // ref.read(counter.notifier).state--;





    },child: const Icon(Icons.add),));

    
  }
}