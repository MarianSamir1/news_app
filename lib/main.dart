import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/home_screen.dart';
import 'package:news_app/shared/cupit/bloc_observer.dart';
import 'package:news_app/shared/cupit/cubit.dart';
import 'package:news_app/shared/cupit/states.dart';
import 'package:news_app/shared/network/local/chash_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async{
  //السطر دا بيتاكد ان اي حاجه قبل الرن بتاع الماي اب خلصت بعد كدا يشغل الماي اب
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await ChashHelper.init();

  bool? fromShared = ChashHelper().getBoolData( key: 'isDark');

  runApp(MyApp(fromShared));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  
  bool? shared;

  MyApp(this.shared);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ( context) => AppCubit()..getBusinessData()..getScienceData()..getSportsData()..isDarkMood(fromShared: shared),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context , states){},
        builder: (context , states) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          
          //light
          theme: ThemeData( 
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.deepOrange,
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black
              )
            ),
            appBarTheme: AppBarTheme(
              titleSpacing: 20,
              iconTheme: IconThemeData(color: Colors.black),
              actionsIconTheme: IconThemeData(
                color: Colors.black ,),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor:Colors.white,
                statusBarIconBrightness: Brightness.dark ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
              color: Colors.white,
              elevation: 0.0),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedIconTheme:IconThemeData(color: Colors.deepOrange) )),
         
         //dark
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(27, 38, 49,1),
            primarySwatch: Colors.deepOrange,
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white
              )
            ),
            appBarTheme: AppBarTheme(
              titleSpacing: 20,
              actionsIconTheme: IconThemeData(
                color: Colors.white ,),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor:Color.fromRGBO(27, 38, 49 ,1),
                statusBarIconBrightness: Brightness.light ),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
              color: Color.fromRGBO(27, 38, 49,1),
              elevation: 0.0),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Color.fromRGBO(27, 38, 49 ,1),
              unselectedItemColor: Colors.grey,
              selectedIconTheme:IconThemeData(color: Colors.deepOrange) )),
         
          themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light ,
          home: HomeScreen(),
        );}
      ),
    );
  }
}