class ShopLoginModel
{
  bool ?status;
  String? message;
  UserData? userData;

  ShopLoginModel.fromJson(Map<String, dynamic>? json)
  {
    status = json?['status'];
    message = json?['message'];
    userData =  UserData.fromJson(json?['data']);
  }
}

class UserData
{
  int? id;
  dynamic name;
  dynamic email;
  dynamic phone;
  String ?image;
  int? points;
  int ?credit;
  String ?token;

  // UserData({
  //   this.id,
  //   this.name,
  //   this.email,
  //   this.phone,
  //   this.image,
  //   this.points,
  //   this.credit,
  //   this.token,
  // });

  // named constructor
  UserData.fromJson(Map<String, dynamic> ?json)
  {
    id = json?['id'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    image = json?['image'];
    points = json?['points'];
    credit = json?['credit'];
    token = json?['token'];
  }
}