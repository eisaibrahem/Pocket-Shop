import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter/models/shop_app/categories_model.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';

import '../../../models/shop_app/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavoritesState)
        {
          if(state.changeFavoritesModel.status)
          {
            showToast(text: state.changeFavoritesModel.message??'success', state: ToastStates.SUCCESS,);
            print(state.changeFavoritesModel.status);
            print(state.changeFavoritesModel.message);
          }else{
            showToast(text: state.changeFavoritesModel.message??'error', state: ToastStates.ERROR,);
            print(state.changeFavoritesModel.status);
          }

        }

      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ConditionalBuilder(
                  condition: ShopCubit.get(context).homeModel != null &&
                      ShopCubit.get(context).categoriesModel != null,
                  builder: (context) => builderWidget(
                      ShopCubit.get(context).homeModel!,
                      ShopCubit.get(context).categoriesModel!,context),
                  fallback: (context) {
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        );
      },
    );
  }

  Widget builderWidget(HomeModel homeModel, CategoriesModel categoriesModel,context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel.homeDataModel?.banners
                .map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.scaleDown,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoryItem(
                        categoriesModel.categoriesDataModel!.categories[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                    itemCount: categoriesModel.categoriesDataModel!.categories.length,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                childAspectRatio: 1 / 1.6,
                children:
                    List.generate(homeModel.homeDataModel!.products.length, (index)
                    {
                  return buildGridProduct(homeModel.homeDataModel!.products[index],context);
                })),
          )
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel productModel , context) {
    return Container(
      padding: EdgeInsets.all(0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(productModel.image),
                width: double.infinity,
                height: 200,
              ),
              if (productModel.discount > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all( 10),
            child: Container(
              height: 83,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${productModel.price.round()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (productModel.discount != 0)
                        Text(
                          '${productModel.oldPrice.round()}',

                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                          onPressed: () {
                          ShopCubit.get(context).changeFavorites(productModel.id);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopCubit.get(context).favorites![productModel.id]??false ? kPrimaryColor : Colors.grey,
                            radius: 15,
                            child: Icon(
                              Icons.star_border,
                            color:  Colors.white,
                              size: 18,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel dataModel) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(
            dataModel.image
              ),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: 100,
          child: Text(
            dataModel.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
