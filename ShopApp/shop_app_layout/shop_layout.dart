import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/layout/shop_app/cupit/cupit.dart';
import 'package:untitled4/layout/shop_app/cupit/states.dart';
// import 'package:untitled4/modules/news_app/search/search_screen.dart';
import 'package:untitled4/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled4/shared/components/components.dart';
import 'package:untitled4/shared/network/local/cache_helper.dart';

import '../../modules/shop_app/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer< ShopCupit,ShopStates>(
      listener: (context,state){} ,
      builder: (context,state)
      {
        var cubit =ShopCupit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Salla",
            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                  ))
            ],
          ),
          body: cubit.shopScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeNav(index);
            }
            ,
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,

                  ),
                  label: "home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,

                ),
                label: "categor",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,

                ),
                label: "favorite",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,

                ),
                label: "settings",
              ),


            ],
          ),
        );
      }
      ,
    );
  }
}
