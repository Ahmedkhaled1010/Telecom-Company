import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/layout/shop_app/cupit/cupit.dart';
import 'package:untitled4/layout/shop_app/cupit/states.dart';
import 'package:untitled4/models/shop_model/categories_model.dart';
import 'package:untitled4/shared/components/components.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCupit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ListView.separated(
            itemBuilder: (context,index)=>buildCategoryItem(ShopCupit.get(context).categorymodel!.data!.data[index]),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: ShopCupit.get(context).categorymodel!.data!.data.length);
      },

    );
  }

  Widget buildCategoryItem (DataModel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage("${model.image}"),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,

        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          "${model.name}",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios),

      ],
    ),
  );
}
