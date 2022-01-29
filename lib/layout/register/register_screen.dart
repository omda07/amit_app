import 'package:amit_app/layout/home/home.dart';
import 'package:amit_app/layout/register/cubit/cubit.dart';
import 'package:amit_app/layout/register/cubit/states.dart';
import 'package:amit_app/network/constants.dart';
import 'package:amit_app/network/local/cache_helper.dart';
import 'package:amit_app/shared/component.dart';
import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
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
                  message: '${state.loginModel.message}',
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
                      padding: EdgeInsets.all(AppPadding.p14),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s16),
                        color: ColorManager.swatch,
                      ),
                      child: Column(
                        // alignment: AlignmentDirectional.bottomCenter,
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
                              if (value == null || value.trim().isEmpty) {
                                return 'please enter name';
                              }
                            },
                            keyboardType: TextInputType.text,
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: const Icon(
                                IconBroken.Add_User,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s16),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s14,
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'please enter your email';
                              }
                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value.toString())) {
                                return 'Please enter a valid email address';
                              }
                              // return null;
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
                            height: 15,
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'password too short';
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            obscureText: RegisterCubit.get(context).isPassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(
                                IconBroken.Lock,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(RegisterCubit.get(context).suffix),
                                onPressed: () {
                                  RegisterCubit.get(context)
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
                                  formKey.currentState!.validate()) {}
                            },
                          ),
                          const SizedBox(
                            height: AppSize.s16,
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'please enter your phone number';
                              }
                            },
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            decoration: InputDecoration(
                              label: const Text('Phone Number'),
                              prefixIcon: const Icon(
                                IconBroken.Call,
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
                          SizedBox(
                            width: double.infinity,
                            height: AppSize.s100 / 2,
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
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                  print(emailController.text);
                                  print(passwordController.text);
                                } else {
                                  print('not validated');
                                }
                              },
                              child: const Text(
                                'REGISTER',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Have an account'),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Go Login'),
                              ),
                            ],
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
