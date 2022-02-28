class CategoriesModel{

  bool? status;
  CategoriesDataModel? categoriesDataModel;


  CategoriesModel.fromJson(Map<String, dynamic>json)
  {
    status=json['status'];
    categoriesDataModel= CategoriesDataModel.fromjson(json['data']);



  }


}



class CategoriesDataModel{
  int ? currentPage;
  List<DataModel>categories=[];

  CategoriesDataModel.fromjson(Map<String, dynamic>json){
    currentPage =json['current_page'];

    json['data'].forEach((element){

      categories.add(DataModel.fromJson(element));

    });

  }

}




class DataModel{

int? id;
late String name;
late String image;

DataModel.fromJson(Map<String, dynamic>json){
  id=json['id'];
  name=json['name'];
  image=json['image'];

}


}