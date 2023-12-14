import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
  });

  /// User id
  final String id;
  final String name;
  final String mobile;
  final String email;

  @override
  List<Object?> get props => [id, name, mobile, email];

  static const empty = User(
    id: '',
    name: '',
    email: '',
    mobile: '',
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserAddress extends Equatable {
  const UserAddress({
    required this.houseNo,
    required this.locality,
    required this.panchayat,
    required this.village,
    required this.district,
    required this.state,
  });

  final String houseNo;
  final String locality;
  final String village;
  final String panchayat;
  final String district;
  final String state;

  @override
  List<Object> get props =>
      [houseNo, locality, village, panchayat, district, state];

  static const empty = UserAddress(
    houseNo: '',
    locality: '',
    panchayat: '',
    village: '',
    district: '',
    state: '',
  );

  factory UserAddress.fromJson(Map<String, dynamic> json) =>
      _$UserAddressFromJson(json);

  Map<String, dynamic> toJson() => _$UserAddressToJson(this);
}
