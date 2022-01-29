import 'package:amit_app/layout/login/cubit/states.dart';
import 'package:amit_app/models/login_model.dart';
import 'package:amit_app/network/end_points.dart';
import 'package:amit_app/network/remote/dio_helper.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);

      loginModel = LoginModel.fromJson(value.data);

      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());

      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = IconBroken.Show;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? IconBroken.Show : IconBroken.Hide;
    emit(LoginChangePasswordVisibilityState());
  }
}
