import 'package:untitled4/models/shop_model/login_model.dart';

abstract class ShopRegisterState{}
class ShopRegisterInitialState extends ShopRegisterState{}
class ShopRegisterLoadingState extends ShopRegisterState{}
class ShopRegisterSuccessState extends ShopRegisterState
{
  final ShopLoginModel RegisterModel;

  ShopRegisterSuccessState(this.RegisterModel);
}
class ShopRegisterErrorState extends ShopRegisterState
{
  final String error;

  ShopRegisterErrorState(this.error);

}
// class ShopChangeVisibilityState extends ShopRegisterState{}