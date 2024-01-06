import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled4/layout/shop_app/shop_layout.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled4/modules/shop_app/login/cupit/cubit.dart';
import 'package:untitled4/modules/shop_app/login/cupit/states.dart';
import 'package:untitled4/modules/shop_app/register/register_screen.dart';
import 'package:untitled4/shared/components/components.dart';
import 'package:untitled4/shared/components/constants.dart';
import 'package:untitled4/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  var emailKey = GlobalKey<FormState>();
  var passwordKey = GlobalKey<FormState>();
  bool secure =true;



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:   (context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: (context,state)
        {
          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status==true)
                {
                  print(state.loginModel.data!.token);
                  print(state.loginModel.message);
                  CacheHelper.saveData(key: "token", value: state.loginModel.data!.token).then(
                          (value)
                      {

                        token =state.loginModel.data!.token;
                        navigateAndFinish(context, ShopLayout());
                      } );

                }
              else {
                print("555555555555555555555555555555");
                print(state.loginModel.message);
                showToast(
                  message:state.loginModel.message!,
                  state: ToastsState.ERORR,
                );

              }
            }
        },
        builder: (context,state)
        {
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: emailKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Login now to browse our hot offers",
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
                              return "paassssss";
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

                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: ShopLoginCubit.get(context).isPassword,
                          onFieldSubmitted: (value)
                          {
                            if(emailKey.currentState!.validate() )
                            {
                              print("sssssssssssss");
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
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
                            suffixIcon: MaterialButton(
                              onPressed: (){
                              ShopLoginCubit.get(context).changePasswordVisibility();

                              },
                              child: Icon(
                                  ShopLoginCubit.get(context).suffix ,
                              ),
                            ),

                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=> defaultButton(
                              width: double.infinity,
                              color: Colors.blue,
                              function: ()
                              {
                                if(emailKey.currentState!.validate() )
                                  {
                                    if(passwordKey.currentState!.validate())
                                      {
                                        print("sssssssssssss");
                                        ShopLoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }

                                  }

                              },
                              name: "LOGIN"),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don\'t have an Account? ",

                            ),
                            defaultTextButton(
                              name: "Register",
                              pressed: ()
                              {
                                navigateTo(context, RegisterScreen());
                              },
                            ),

                          ],
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
