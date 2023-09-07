import 'package:bmi/news/constats/constants.dart';
import 'package:bmi/news/network/dio_helpr.dart';
import 'package:bmi/news/views/business.dart';
import 'package:bmi/news/views/sports.dart';
import 'package:bmi/news/views/stocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  // static NewsCubit get(context) => BlocProvider.of(context);

// change State of Bottom Nav Br when click item
// 1
  final List<Widget> screens = [
    const Health(),
    const Business(),
    const Sports(),
  ];
// 2
  final List<BottomNavigationBarItem> items = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.health_and_safety_outlined),
      label: "Health",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
  ];
// 3
  var currIndex = 0;
// 4
  changeNavIndex(int index) {
    currIndex = index;
    emit(NewsButtonNav());
  }

// list of articles
  List healthList = [];
  List businessList = [];
  List sportsList = [];

  // list of category
  List categoryName = ["science", "business", "sports"];

// get data
  getDataFromApi({String? category, int index = 0}) async {
    try {
      emit(LoadingArticle());
      var response = await DioHelper.getData(
        MyConst.url,
        {
          "country": "eg",
          "apiKey": MyConst.apiKey,
          "category": category,
        },
      );

      switch (index) {
        case 0:
          healthList = response.data["articles"];
          break;
        case 1:
          businessList = response.data["articles"];
          break;
        case 2:
          sportsList = response.data["articles"];
          break;
      }

      emit(SuccessArticle());
    } catch (e) {
      emit(ErrorArticle(err: e.toString()));
      print(e);
    }
  }

// change mode function
  bool isDark = false;
  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }

  // ----------- change direction

  // change mode function
  bool isLeft = true;
  void changeDirection() {
    isLeft = !isLeft;
    emit(AppChangeDirectionState());
  }
}
