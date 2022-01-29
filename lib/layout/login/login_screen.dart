import 'package:amit_app/layout/home/home.dart';
import 'package:amit_app/layout/login/cubit/cubit.dart';
import 'package:amit_app/layout/login/cubit/states.dart';
import 'package:amit_app/layout/register/register_screen.dart';
import 'package:amit_app/network/constants.dart';
import 'package:amit_app/network/local/cache_helper.dart';
import 'package:amit_app/shared/component.dart';
import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                      key: token.toString(),
                      value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token!;
                navigateAndFinish(context, Home());
              });
              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  backgroundColor: ColorManager.swatch,
                  message: '${state.loginModel.message}',
                ),
              );
            } else {
              showTopSnackBar(
                context,
                CustomSnackBar.error(
                  message: 'sec if ${state.loginModel.message}',
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppPadding.p14),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s16),
                        color: ColorManager.swatch,
                      ),
                      //login logo
                      child: Column(
                        children: [
                          Center(
                            child: DefaultTextStyle(
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                              child: AnimatedTextKit(
                                pause: const Duration(seconds: 3),
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                      'Orange Digital Center'),
                                ],
                                onTap: () {
                                  print("Tap Event");
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s12,
                          ),
                          const Image(
                            image: AssetImage('assets/images/logo.png'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Email is required';
                              }

                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value.toString())) {
                                return 'Please enter a valid email address';
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: const Icon(
                                IconBroken.Message,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s16),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s16,
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 5 || value.length > 20) {
                                return 'Password must be betweem 5 and 20 characters';
                              }
                              //return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            obscureText: LoginCubit.get(context).isPassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(
                                IconBroken.Lock,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(LoginCubit.get(context).suffix),
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s16),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              if (formKey.currentState != null &&
                                  formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s28),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState != null &&
                                      formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                    print(emailController.text);
                                    print(passwordController.text);
                                  } else {
                                    print('not validated');
                                  }
                                },
                                child: const Text(
                                  'Login',
                                ),
                              ),
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, const RegisterScreen());
                            },
                            child: const Text('Go SignUp'),
                          ),
                        ],
                      ),
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
