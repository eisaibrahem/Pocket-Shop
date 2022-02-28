import 'package:udemy_flutter/models/shop_app/change_favorites_model.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';

import '../../../models/shop_app/favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDateState extends ShopStates{}

class ShopSuccessHomeDateState extends ShopStates{}

class ShopErrorHomeDateState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}


class ShopSuccessChangeFavoritesState extends ShopStates
{
   final ChangeFavoritesModel changeFavoritesModel;

  ShopSuccessChangeFavoritesState(this.changeFavoritesModel);

}

class ShopChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}


class ShopSuccessUserDataState extends ShopStates
{

  ShopLoginModel? shopLoginModel;

  ShopSuccessUserDataState(this.shopLoginModel);
}

class ShopShopLoadingUserDataState extends ShopStates{}

class ShopErrorUserDataState extends ShopStates{}


class ShopSuccessUpdateUserState extends ShopStates
{

  ShopLoginModel? shopLoginModel;

  ShopSuccessUpdateUserState(this.shopLoginModel);
}

class ShopLoadingUpdateUserState extends ShopStates{}

class ShopErrorUpdateUserState extends ShopStates{}



