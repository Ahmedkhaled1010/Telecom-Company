import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/layout/shop_app/cupit/states.dart';
import 'package:untitled4/models/shop_model/favorites_model.dart';
import 'package:untitled4/models/shop_model/home_model.dart';
import 'package:untitled4/modules/settings/settings_screen.dart';
import 'package:untitled4/modules/shop_app/category/category_screen.dart';
import 'package:untitled4/modules/shop_app/favourites/favourites_screen.dart';
import 'package:untitled4/modules/shop_app/products/products_screen.dart';
import 'package:untitled4/modules/shop_app/search/search_screen.dart';
import 'package:untitled4/shared/components/constants.dart';
import 'package:untitled4/shared/network/remote/dio_helper.dart';

import '../../../models/shop_model/categories_model.dart';
import '../../../models/shop_model/change_favorites.dart';
import '../../../models/shop_model/login_model.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shared/network/end_points.dart';

class ShopCupit extends Cubit<ShopStates>
{
  ShopCupit(): super(ShopInitialState());
  static ShopCupit get(context )=>BlocProvider.of(context);

  int currentIndex=0;

  List<Widget> shopScreen=
      [
        ProductsScreen(),
        CategoryScreen(),
        FavoritesScreen(),
       SettingsScreen(),

      ];
  void changeNav(int index)
  {
    currentIndex =index;
    emit(ShopChangeBottom());
  }
   HomeModel? model;
  Map<int,bool> favorites={};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME,
    token: token,).then(
            (value) {


              model =HomeModel.fromjson(value!.data);

              model!.data!.products.forEach((element)
              {
                favorites.addAll({
                  element.id!:element.in_favorites!,
                });
              });
              print(favorites.toString());
 

            //  printFullText("${value.data}");



              emit(ShopSuccessHomeDataState());
            }).catchError((onError)
    {

      print(onError.toString());
      emit(ShopErorrHomeDataState());
    });


  }
  CategoryModel? categorymodel;

  void getCategory()
  {

    DioHelper.getData(url: GET_CATEGORIES,
     ).then(
            (value) {


          categorymodel=CategoryModel.fromjson(value!.data);


          //  printFullText("${value.data}");



          emit(ShopSuccessCategoriesState());
        }).catchError((onError)
    {

      print(onError.toString());
      emit(ShopErorrCategoriesState());
    });


  }
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int id)
  {
    favorites[id] = (!favorites[id]!);
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
token: token,

        data: {
          "product_id":id,
        }).then((value)
    {
      changeFavoritesModel =ChangeFavoritesModel.fromjson(value!.data);

      if(!changeFavoritesModel!.status!)
        {
          favorites[id] =(!favorites[id]!);
        }else
          {
            getFavorite();
          }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      emit(ShopErorrChangeFavoritesState());
    });
    
  }
  FavoritesModel? favoritesModel;

  void getFavorite()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(url: FAVORITES,token: token,
    ).then(
            (value) {


          favoritesModel=FavoritesModel.fromJson(value!.data);
          printFullText("${value.data}");

          if(favoritesModel?.data?.currentPage!=null)
          {
            print("Success Data");

          }
          else{
            print("aggggggggggg");

          }

          //  printFullText("${value.data}");



          emit(ShopSuccessGetFavoritesState());
        }).catchError((onError)
    {
      print("5555555555555");
      print(onError.toString());
      emit(ShopErorrGetFavoritesState());
    });


  }
  ShopLoginModel? userModel;
  void getUserData()
  {
    emit(ShopLoadingGetUserDataState());

    DioHelper.getData(url: PROFILE,token: token,
    ).then(
            (value) {


              userModel =ShopLoginModel.fromjson(value!.data);
          printFullText("${userModel!.data!.name}");







          emit(ShopSuccessGetUserDataState(userModel ));
        }).catchError((onError)
    {
      print("5555555555555");
      print(onError.toString());
      emit(ShopErorrGetUserDataState());
    });


  }
  void UpdateUserData(
  {
    required String name,
    required String email,
    required String phone,
}
      )
  {
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(url: UPDATE_USER,token: token,
      data:
      {
        "name":name,
        "email":email,
        "phone":phone,
      }
    ).then(
            (value) {


          userModel =ShopLoginModel.fromjson(value!.data);
          printFullText("${userModel!.data!.name}");







          emit(ShopSuccessUpdateUserDataState(userModel ));
        }).catchError((onError)
    {
      print("5555555555555");
      print(onError.toString());
      emit(ShopErorrUpdateUserDataState());
    });


  }
}