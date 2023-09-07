import 'package:bmi/news/cubit/news_cubit.dart';
import 'package:bmi/news/views/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNews extends StatelessWidget {
  const MainNews({super.key});

  @override
  Widget build(BuildContext context) {
    NewsCubit cubit = BlocProvider.of<NewsCubit>(context);
    cubit.getDataFromApi(category: cubit.categoryName[0], index: 0);

    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actionsIconTheme: const IconThemeData(size: 30),
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: true,
            leading: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(Icons.newspaper),
            ),
            title: const Text("Stocks App"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SearchView(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search)),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  onPressed: () {
                    cubit.changeAppMode();
                  },
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                    size: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                    onPressed: () {
                      cubit.changeDirection();
                    },
                    icon: const Icon(
                      Icons.language,
                      size: 25,
                    )),
              ),
            ],
          ),
          body: cubit.screens[cubit.currIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedIconTheme: const IconThemeData(size: 30),
            selectedItemColor: Colors.deepOrange,
            onTap: (index) {
              cubit.getDataFromApi(
                  category: cubit.categoryName[index], index: index);
              cubit.changeNavIndex(index);
            },
            currentIndex: cubit.currIndex,
            items: cubit.items,
          ),
        );
      },
    );
  }
}
