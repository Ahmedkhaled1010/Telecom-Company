import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/models/shop_model/login_model.dart';
import 'package:untitled4/modules/shop_app/register/cupit/states.dart';
import 'package:untitled4/shared/network/end_points.dart';
import 'package:untitled4/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState>{
  ShopRegisterCubit() :super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) =>BlocProvider.of(context);

  ShopLoginModel? model;
  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,



})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER,
        data:
        {
          "email":email,
          "password":password,
          "name":name,
          "phone":phone,
        }).then((value) {
          print(value!.data);
         model= ShopLoginModel.fromjson(value!.data);


          emit(ShopRegisterSuccessState(model!));
    }).catchError((onError)
    {
      print("sssssssssssssss");
      print(onError.toString());

      emit(ShopRegisterErrorState(onError.toString()));
    });
  }

IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;

  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix = isPassword ? Icons.visibility_outlined:Icons.visibility_off_outlined;
    // emit(ShopChangeVisibilityState());
  }
}