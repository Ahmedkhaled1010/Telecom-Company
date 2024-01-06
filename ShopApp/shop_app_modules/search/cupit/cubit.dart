import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/models/shop_model/search_model.dart';
import 'package:untitled4/modules/shop_app/search/cupit/state.dart';
import 'package:untitled4/shared/components/constants.dart';
import 'package:untitled4/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/end_points.dart';

class SearchCupit extends Cubit<SearchState>
{
  SearchCupit(): super(SearchInitialState());
static  SearchCupit  get(context)=>BlocProvider.of(context);
SearchModel? model;
void search (String text)
{
  DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        "text":text,
      }).then((value)
      {
        model =SearchModel.fromJson(value!.data);
        emit(SearchSuccessState());

      }).catchError((error)
  {
    print(error.toString());
    emit(SearchErorrState());
  });
}
}