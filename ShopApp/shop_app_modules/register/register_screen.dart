import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/modules/shop_app/register/cupit/cubit.dart';
import 'package:untitled4/modules/shop_app/register/cupit/states.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';


class RegisterScreen extends StatelessWidget {
  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  var nameController =TextEditingController();
  var phoneController =TextEditingController();
  var emailKey = GlobalKey<FormState>();
  var passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopRegisterCubit(),

      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
        listener: (context,state) {
          if (state is ShopRegisterSuccessState) {
            if (state.RegisterModel.status == true) {
              print(state.RegisterModel.data!.token);
              print(state.RegisterModel.message);
              CacheHelper.saveData(
                  key: "token", value: state.RegisterModel.data!.token).then(
                      (value) {
                    token = state.RegisterModel.data!.token;
                    navigateAndFinish(context, ShopLayout());
                  });
            }
            else {
              print("555555555555555555555555555555");
              print(state.RegisterModel.message);
              showToast(
                message:state.RegisterModel.message!,
                state: ToastsState.ERORR,
              );

            }
          }
        },
        builder: (context,state)
        {
          return  Scaffold(
            appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: emailKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Register now to browse our hot offers",
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey,
                          ),

                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        TextFormField(

                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value)
                          {
                            print(value);
                          },
                          validator: ( value)
                          {

                            if(value!.isEmpty){
                              return "Please enter email";
                            }
                            return null;

                          },
                          decoration: InputDecoration(
                            labelText: "Email Address",
                            border:  OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.email,
                            ),


                          ),







                        ),

                        SizedBox(
                          height: 30.0,
                        ),

                        defaultFormField(
                            controller: nameController,
                            keyType: TextInputType.text,
                            validate: (String value)
                            {
                              if(value!.isEmpty)
                              {
                                return " Please enter name";
                              }
                            },
                            label: "name",
                            prefix: Icons.person,
                            onSubmitted: (){}),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: ShopRegisterCubit.get(context).isPassword,
                          onFieldSubmitted: (value)
                          {

                          },
                          validator: (value)
                          {
                            if(value!.isEmpty) {
                              return " The Password  must no be empty";
                            }
                            return null;


                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.lock,
                            ),



                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        defaultFormField(
                            controller: phoneController,
                            keyType: TextInputType.phone,
                            validate: ( value)
                            {
                              if(value!.isEmpty)
                              {
                                return " Please enter phone";
                              }
                              return null;
                            },
                            label: "phone",
                            prefix: Icons.phone,
                            onSubmitted: (){}),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context)=> defaultButton(
                              width: double.infinity,
                              color: Colors.blue,
                              function: ()
                              {
                                if(emailKey.currentState!.validate() )
                                {
                                  print("sssssssssssss");
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                     phone: phoneController.text);
                                }

                              },
                              name: "REGISTER"),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        },

      ),
    );
  }
}
