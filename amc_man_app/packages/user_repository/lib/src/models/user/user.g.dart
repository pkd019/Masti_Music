// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    mobile: json['mobile'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
    };

UserAddress _$UserAddressFromJson(Map<String, dynamic> json) {
  return UserAddress(
    houseNo: json['houseNo'] as String,
    locality: json['locality'] as String,
    panchayat: json['panchayat'] as String,
    village: json['village'] as String,
    district: json['district'] as String,
    state: json['state'] as String,
  );
}

Map<String, dynamic> _$UserAddressToJson(UserAddress instance) =>
    <String, dynamic>{
      'houseNo': instance.houseNo,
      'locality': instance.locality,
      'village': instance.village,
      'panchayat': instance.panchayat,
      'district': instance.district,
      'state': instance.state,
    };
