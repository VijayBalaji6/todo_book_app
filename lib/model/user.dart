import 'dart:convert';

class UserModel {
  String userName;
  String userId;
  String loginType;
  String userProfileImage;
  UserModel({
    required this.userName,
    required this.userId,
    required this.loginType,
    required this.userProfileImage,
  });

  UserModel copyWith({
    String? userName,
    String? accountId,
    String? loginType,
    String? userProfileImage,
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      userId: accountId ?? userId,
      loginType: loginType ?? this.loginType,
      userProfileImage: userProfileImage ?? this.userProfileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'accountId': userId,
      'loginType': loginType,
      'userProfileImage': userProfileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] as String,
      userId: map['accountId'] as String,
      loginType: map['loginType'] as String,
      userProfileImage: map['userProfileImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}