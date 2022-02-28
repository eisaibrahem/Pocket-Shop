
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../modules/shop_app/categories/categories_screen.dart';
import '../../../modules/shop_app/favorites/favorites_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }


  HomeModel? homeModel;

  Map<int, bool> ?favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDateState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

// باخد من ليست ال products احط فى لست ال favorites
      homeModel?.homeDataModel?.products.forEach((element) {
        favorites!.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());

      emit(ShopSuccessHomeDateState());
    }).catchError((error) {
      print('fffffffffffffffff');
      print(error.toString());
      print('fffffffffffffffff');
      emit(ShopErrorHomeDateState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

 late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int? productId) {
    favorites![productId!] = !favorites![productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel.status) {
        favorites![productId] = !favorites![productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      print('ffffffffffffffffffffffffffffffffffffffffffffffffff');
      print(error.toString());
      print('ffffffffffffffffffffffffffffffffffffffffffffffffff');
      favorites![productId] = !favorites![productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print('fffffffffffffffffffffffffffffffffffffffffff');
      print(error.toString());
      print('fffffffffffffffffffffffffffffffffffffffffff');
      emit(ShopErrorGetFavoritesState());
    });
  }



//profile
  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopShopLoadingUserDataState ());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
      print(userModel!.userData!.name);
      print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print('fffffffffffffffffffffffffffffffffffffffffff');
      print(error.toString());
      print('fffffffffffffffffffffffffffffffffffffffffff');
      emit(ShopErrorUserDataState());
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.userData!.name);

      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }






}
