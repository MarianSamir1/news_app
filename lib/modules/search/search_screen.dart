import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/component/components.dart';
import 'package:news_app/shared/cupit/cubit.dart';
import 'package:news_app/shared/cupit/states.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value){
                    AppCubit.get(context).searchData =  value;
                    AppCubit.get(context).getSearchData();
                  },
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      labelText: 'Search'),
                ),
                state == AppGetSearchLoadingState()
                    ? Expanded(
                        child: Center(child: CircularProgressIndicator()))
                    : Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => newsComponent(
                                AppCubit.get(context).search[index], context),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: AppCubit.get(context).search.length),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
