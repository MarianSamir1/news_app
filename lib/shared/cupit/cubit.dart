import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/Business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cupit/states.dart';
import 'package:news_app/shared/network/local/chash_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_cricket_sharp ), label: 'Sports')
  ];

  List<Widget> screen =[
    Business(),
    Science(),
    Sports(),
  ];

  int index = 0;

  List<dynamic> business =[] ;
  List<dynamic> science =[] ;
  List<dynamic> sports =[] ;

  void getBusinessData(){

    DioHelper.getData(
      url: 'v2/top-headlines', 
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'1131f368b3a146618fb8ceda159d09ac'
      }).then((value) {
        business = value.data['articles'];
        print(value.data['articles'][0]['title']);
        //success
        emit(AppGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        //error
        emit(AppGetBusinessErrorState());
      });

  }

  void getScienceData(){

    DioHelper.getData(
      url: 'v2/top-headlines', 
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'1131f368b3a146618fb8ceda159d09ac'
      }).then((value) {
        science = value.data['articles'];
        print(value.data['articles'][0]['title']);
        //success
        emit(AppGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        //error
        emit(AppGetScienceErrorState());
      });

  }

    void getSportsData(){

    DioHelper.getData(
      url: 'v2/top-headlines', 
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'1131f368b3a146618fb8ceda159d09ac'
      }).then((value) {
        sports = value.data['articles'];
        print(value.data['articles'][0]['title']);
        //success
        emit(AppGetSportSuccessState());
      }).catchError((error){
        print(error.toString());
        //error
        emit(AppGetSportErrorState());
      });

  }

  List<dynamic> search = [];

  void getSearchData( String query){
    emit(AppLoadingState());

    DioHelper.getData(
      url: 'v2/everything', 
      query: {
        'q':'$query',
        'apiKey':'1131f368b3a146618fb8ceda159d09ac'
      }).then((value) {
        search = value.data['articles'];
        print(value.data['articles'][0]['title']);
        //success
        emit(AppGetSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        //error
        emit(AppGetSearchErrorState());
      });

  }

  void changeIndex(int currentIndex){
    index=currentIndex;
    emit(AppChangeBottomNavigationIndex());
  }

  bool isDark = false;

  void isDarkMood({bool? fromShared,}){
    if(fromShared!=null){
      isDark=fromShared;
      emit(AppIsDarkState());
    }else{
      isDark =! isDark;
      ChashHelper().setBoolData(key: 'isDark', value: isDark, ).then((value){
        emit(AppIsDarkState());
        });
    }
  }
}