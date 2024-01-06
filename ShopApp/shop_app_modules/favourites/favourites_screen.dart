import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/models/shop_model/favorites_model.dart';

import '../../../layout/shop_app/cupit/cupit.dart';
import '../../../layout/shop_app/cupit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/color.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCupit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        final favoritesModel = ShopCupit.get(context).favoritesModel;

        if (favoritesModel == null || favoritesModel.data == null) {
          // Handle the case when favoritesModel or its data is null
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState ,
          builder: (context)=>ListView.separated(
              itemBuilder: (context,index)=>buildListProduct(favoritesModel.data!.data![index].product ,context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: favoritesModel.data!.data!.length),
           fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

}
