// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  data : json['data']
);
Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'data': instance.data,
};



Data _$DataFromJson(Map<String, dynamic> json) => Data(
  id : json['id'],
  email : json['email'],
  firstName : json['firstName'],
  lastName : json['lastName'],
  avatar : json['avatar'],
);
Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'avatar': instance.avatar,
};