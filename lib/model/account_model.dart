import 'dart:convert';

class AccountModel {
  String userName;
  String accountId;
  String loginType;
  String userProfileImage;
  AccountModel({
    required this.userName,
    required this.accountId,
    required this.loginType,
    required this.userProfileImage,
  });

  AccountModel copyWith({
    String? userName,
    String? accountId,
    String? loginType,
    String? userProfileImage,
  }) {
    return AccountModel(
      userName: userName ?? this.userName,
      accountId: accountId ?? this.accountId,
      loginType: loginType ?? this.loginType,
      userProfileImage: userProfileImage ?? this.userProfileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'accountId': accountId,
      'loginType': loginType,
      'userProfileImage': userProfileImage,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      userName: map['userName'] as String,
      accountId: map['accountId'] as String,
      loginType: map['loginType'] as String,
      userProfileImage: map['userProfileImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
