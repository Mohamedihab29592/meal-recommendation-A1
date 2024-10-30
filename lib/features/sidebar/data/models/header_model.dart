class HeaderModel{
   String? path;
   String? name;
   String? uid;
  HeaderModel({this.path,this.name,this.uid});
  HeaderModel.fromJson(Map<String, dynamic> json){
    path =json["image"];
    name = json["name"];
    uid = json["uid"];
  }
   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = <String, dynamic>{};
     data['name'] = name;
     data['image'] = path;
     return data;
   }
}