import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/layout/shop_app/cupit/cupit.dart';
import 'package:untitled4/layout/shop_app/cupit/states.dart';
import 'package:untitled4/shared/components/components.dart';
import 'package:untitled4/shared/components/constants.dart';
import 'package:untitled4/shared/styles/color.dart';

class SettingsScreen extends StatelessWidget {



  var nameControler =TextEditingController();
  var emailControler =TextEditingController();
  var phoneControler =TextEditingController();
  var formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopCupit,ShopStates>(
      listener: (context,state)
      {
        if(state is ShopSuccessGetUserDataState)
          {

          }
      } ,
      builder: (context,state)
      {

        var model =ShopCupit.get(context).userModel;
        nameControler.text = model!.data!.name??"";
        emailControler.text =model.data!.email??"";
        phoneControler.text = model.data!.phone??"";

        return ConditionalBuilder(
          condition: ShopCupit.get(context).userModel != null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserDataState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      controller: nameControler,
                      keyType: TextInputType.name,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return " name must not be empty";
                        }
                      },
                      label: "Name",
                      prefix: Icons.person,
                      onSubmitted:(){}),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: emailControler,
                      keyType: TextInputType.emailAddress,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return "email must not be empty";
                        }
                      },
                      label: "Email Address",
                      prefix: Icons.email_outlined,
                      onSubmitted:(){}),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: phoneControler,
                      keyType: TextInputType.phone,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return " phone must not be empty";
                        }
                      },
                      label: "phone",
                      prefix: Icons.phone,
                      onSubmitted:(){}),
                  SizedBox(
                    height: 30.0,
                  ),
                  defaultButton(width: double.infinity,
                      color: defaultColor,
                      function: ()
                      {
                        if(formKey.currentState!.validate())
                          {
                            ShopCupit.get(context).UpdateUserData(
                                name: nameControler.text,
                                email: emailControler.text, phone: phoneControler.text);
                          }

                      },
                      name: "UPDATE"),
                  SizedBox(
                    height: 15.0,
                  ),

                  defaultButton(width: double.infinity,
                      color: defaultColor,
                      function: ()
                      {
                        signUp(context);
                      },
                      name: "LOGOUT")
                ],
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),

        );
      },

    );
  }
}
