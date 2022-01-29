import 'package:amit_app/layout/register/cubit/states.dart';
import 'package:amit_app/models/login_model.dart';
import 'package:amit_app/network/end_points.dart';
import 'package:amit_app/network/remote/dio_helper.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);

      loginModel = LoginModel.fromJson(value.data);

      emit(RegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());

      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = IconBroken.Show;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? IconBroken.Show : IconBroken.Hide;
    emit(RegisterChangePasswordVisibilityState());
  }
}
