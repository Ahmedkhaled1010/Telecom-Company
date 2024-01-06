import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/modules/shop_app/search/cupit/cubit.dart';
import 'package:untitled4/modules/shop_app/search/cupit/state.dart';
import 'package:untitled4/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
var formKey =GlobalKey<FormState>();
var searchControler =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCupit(),

      child: BlocConsumer<SearchCupit,SearchState>(
        listener:(context,state ){} ,
        builder: (context,state)
        {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: searchControler,
                          keyType: TextInputType.text,
                          validate: (String value)
                          {
                            if(value!.isEmpty)
                              {
                                return "enter the text to search";
                              }
                            return null;
                          },
                          label: "Search",
                          prefix: Icons.search,
                          onSubmitted: (String text)
                          {
                            SearchCupit.get(context).search(text);
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      if(state is SearchLoadingState)
                        LinearProgressIndicator(),

                      SizedBox(
                        height: 15.0,
                      ),
                      if(state is SearchSuccessState)
                       Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index)=>buildListProduct(SearchCupit.get(context).model!.data!.data![index],context,isSearch: false),
                            separatorBuilder: (context,index)=>myDivider(),
                            itemCount: SearchCupit.get(context).model!.data!.data!.length),
                      ),
                    ],
                  ),
                ),
              ),
          );
        },

      ),
    );
  }
}
