import 'package:untitled4/models/shop_model/categories_model.dart';
import 'package:untitled4/models/shop_model/change_favorites.dart';
import 'package:untitled4/models/shop_model/login_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottom extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErorrHomeDataState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErorrCategoriesState extends ShopStates{}
class ShopChangeFavoritesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);

}
class ShopErorrChangeFavoritesState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErorrGetFavoritesState extends ShopStates{}
class ShopLoadingGetUserDataState extends ShopStates{}
class ShopSuccessGetUserDataState extends ShopStates
{
  final ShopLoginModel? userModel;

  ShopSuccessGetUserDataState(this.userModel);
}
class ShopErorrGetUserDataState extends ShopStates{}
class ShopLoadingUpdateUserDataState extends ShopStates{}
class ShopSuccessUpdateUserDataState extends ShopStates
{
  final ShopLoginModel? userModel;

  ShopSuccessUpdateUserDataState(this.userModel);
}
class ShopErorrUpdateUserDataState extends ShopStates{}