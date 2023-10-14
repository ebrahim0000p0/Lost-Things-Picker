import 'package:meta/meta.dart';

import '../utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class UserModelChat {
  final String idUser;
  final String name;
  final String picture;
  final DateTime lastMessageTime;

  const UserModelChat({
    this.idUser,
    @required this.name,
    @required this.picture,
    @required this.lastMessageTime,
  });

  UserModelChat copyWith({
    String idUser,
    String name,
    String urlAvatar,
    String lastMessageTime,
  }) =>
      UserModelChat(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        picture: urlAvatar ?? this.picture,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      );

  static UserModelChat fromJson(Map<String, dynamic> json) => UserModelChat(
        idUser: json['id'],
        name: json['name'],
        picture: json['picture'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'id': idUser,
        'name': name,
        'picture': picture,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
      };
}
