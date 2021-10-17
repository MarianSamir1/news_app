import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/cupit/cubit.dart';
import 'package:news_app/shared/cupit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> SearchScreen()
                ));
              }, 
              icon:Icon(Icons.search)
              ),
              IconButton(onPressed: (){
                cubit.isDarkMood();
              }, 
              icon: Icon(Icons.brightness_4_outlined))
            ],
          ),
          body: cubit.screen[cubit.index],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.index,
            onTap: (int index) {
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
