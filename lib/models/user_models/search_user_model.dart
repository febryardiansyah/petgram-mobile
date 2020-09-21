import 'package:equatable/equatable.dart';

class SearchUserModel extends Equatable{
  bool status;
  String message;
  List<SearchResultModel> searchResult;

  SearchUserModel({this.status, this.message, this.searchResult});


  factory SearchUserModel.fromMap(Map<String,dynamic>json){
    return SearchUserModel(
      message: json['message'],
      status: json['status'],
      searchResult: List<SearchResultModel>.from(json['users'].map((i)=>SearchResultModel.fromMap(i)))
    );
  }

  @override
  List<Object> get props => [status,message,searchResult];

}
class SearchResultModel{
  String id;
  String name;
  String petname;
  String profilePic;

  SearchResultModel({this.id, this.name, this.petname, this.profilePic});

  factory SearchResultModel.fromMap(Map<String,dynamic>json){
    return SearchResultModel(
      id: json['_id'],
      name: json['name'],
      petname: json['petname'],
      profilePic: json['profilePic']
    );
  }
}