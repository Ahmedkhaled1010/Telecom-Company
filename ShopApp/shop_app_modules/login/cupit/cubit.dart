import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/models/shop_model/login_model.dart';
import 'package:untitled4/modules/shop_app/login/cupit/states.dart';
import 'package:untitled4/shared/network/end_points.dart';
import 'package:untitled4/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit() :super(ShopLoginInitialState());
  static ShopLoginCubit get(context) =>BlocProvider.of(context);

  ShopLoginModel? model;
  void userLogin({
    required String email,
    required String password,

})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN,
        data:
        {
          "email":email,
          "password":password,
        }).then((value) {
          print(value!.data);
         model= ShopLoginModel.fromjson(value!.data);
         // print(model!.status.toString());
         //  print(model!.data!.id.toString());
         //  print(model!.data!.token.toString());

          // print(value!.data["message"]);

          emit(ShopLoginSuccessState(model!));
    }).catchError((onError)
    {
      print("sssssssssssssss");
      print(onError.toString());

      emit(ShopLoginErrorState(onError.toString()));
    });
  }

IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;

  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix = isPassword ? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangeVisibilityState());
  }
}