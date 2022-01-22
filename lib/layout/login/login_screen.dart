import 'package:amit_app/layout/register/register_screen.dart';
import 'package:amit_app/shared/component.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void changePasswordVisibility() {
    setState(() {
      isPassword = !isPassword;
      suffix = isPassword ? IconBroken.Show : IconBroken.Hide;
    });
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Image(
                image: const AssetImage('assets/images/logo.png'),
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
                          return 'please enter your email';
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
                          borderRadius: BorderRadius.circular(16.0),
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
                        //return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      obscureText: isPassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(
                          IconBroken.Lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            suffix,
                          ),
                          onPressed: () {
                            changePasswordVisibility();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        if (formKey.currentState != null &&
                            formKey.currentState!.validate()) {}
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState != null &&
                              formKey.currentState!.validate()) {
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          print('nav bar');
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(IconBroken.Home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconBroken.Category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconBroken.Buy),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconBroken.More_Square),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
