part of 'amit_cubit.dart';

abstract class AppStates {}

class AppInitial extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppLoadingHomeDataState extends AppStates {}

class AppSuccessHomeDataState extends AppStates {}

class AppErrorHomeDataState extends AppStates {
  final String error;

  AppErrorHomeDataState(this.error);
}

class AppSuccessCategoriesDataState extends AppStates {}

class AppErrorCategoriesDataState extends AppStates {
  final String error;

  AppErrorCategoriesDataState(this.error);
}

class AppChangeFavoritesState extends AppStates {}

class AppSuccessChangeFavoritesState extends AppStates {
  final ChangeFavoritesModel model;

  AppSuccessChangeFavoritesState(this.model);
}

class AppErrorChangeFavoritesState extends AppStates {}

class AppLoadingGetFavoritesState extends AppStates {}

class AppSuccessGetFavoritesState extends AppStates {}

class AppErrorGetFavoritesState extends AppStates {}

class AppLoadingGetCartState extends AppStates {}

class AppSuccessGetCartState extends AppStates {}

class AppErrorGetCartState extends AppStates {}

class AppLoadingChangeCartsState extends AppStates {}

class AppSuccessChangeCartsState extends AppStates {
  final ChangeCartsModel model;

  AppSuccessChangeCartsState(this.model);
}

class AppErrorChangeCartsState extends AppStates {}

class AppLoadingGetUserDataState extends AppStates {}

class AppSuccessGetUserDataState extends AppStates {
  final LoginModel userModel;

  AppSuccessGetUserDataState(this.userModel);
}

class AppErrorGetUserDataState extends AppStates {}

class AppLoadingUpdateUserDataState extends AppStates {}

class AppSuccessUpdateUserDataState extends AppStates {
  final LoginModel userModel;

  AppSuccessUpdateUserDataState(this.userModel);
}

class AppErrorUpdateUserDataState extends AppStates {}

class LogOutUserSuccessState extends AppStates {}

class LogOutUserErrorState extends AppStates {
  final String error;

  LogOutUserErrorState(this.error);
}
