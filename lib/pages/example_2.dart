import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course/riverpod/slider_riverpod.dart';

class Home2 extends ConsumerWidget {
  const Home2({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    print('build');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Slider'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // show password with riverpod

           Consumer(builder: (context,ref , child){
          final sliders = ref.watch(sliderRiverpod.select((state)=> state.showPassword));
          return InkWell(
            onTap: (){
              final stateProvider = ref.read(sliderRiverpod.notifier);
              stateProvider.state = stateProvider.state.copyWith(showPassword: !sliders);
            },
            child: SizedBox(
            height: 200,
            width: 200,
            child: sliders ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                     ),
          );
         }),



        // widget or consumer for container with the color red

         Consumer(builder: (context,ref , child){
          final sliders = ref.watch(sliderRiverpod.select((state)=> state.slider));
          return Container(
          height: 200,
          width: 200,
          color: Colors.red.withOpacity(sliders),
         );
         }),




        // widget or consumer for slider 
         
         Consumer(builder: (context, ref , child){
           final sliders = ref.watch(sliderRiverpod.select((state)=> state.slider));
          return Slider(value: sliders, onChanged: (value){
         final stateProvider =  ref.read(sliderRiverpod.notifier);
         stateProvider.state = stateProvider.state.copyWith(slider: value);
         });
         }),

        ],
      ),
    );
  }
}