import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';

import '../../../models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => builderCategoryItem(
            ShopCubit.get(context).categoriesModel!.categoriesDataModel!.categories[index],),

          separatorBuilder: (context, index) =>myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.categoriesDataModel!.categories.length,
        );

      },

    );
  }





  Widget builderCategoryItem( DataModel model){

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(

        children: [
          Image(
            image: NetworkImage(model.image),
            width: 90,
            height: 90,
            fit: BoxFit.cover,

          ),

SizedBox(width: 20,),

          Text(
            model.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,


            ),
          ),
          Spacer(),


          Icon(Icons.arrow_forward_ios),




        ],
      ),



    );


  }









}
