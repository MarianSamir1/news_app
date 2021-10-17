import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/component/components.dart';
import 'package:news_app/shared/cupit/cubit.dart';
import 'package:news_app/shared/cupit/states.dart';

class Sports extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit , AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        List<dynamic> list =AppCubit.get(context).sports;
        return list.length== 0?Center(child: CircularProgressIndicator()) : 
        ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (ctx , index ) => newsComponent(list[index], context), 
            separatorBuilder: (ctx , index ) => myDivider(), 
            itemCount: 10) ;
          
      });
  }
}