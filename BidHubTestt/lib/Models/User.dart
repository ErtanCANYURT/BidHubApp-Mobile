class User {
  int id;
  String userName;
  String name;
  String surname;
  String password;
  String phoneNumber;
  String identityNumber;
  String address;
  String signalRConnectionId;
  String email;
  String userAccessToken;

  User({
    required this.id,
    required this.userName,
    required this.name,
    required this.surname,
    required this.password,
    required this.phoneNumber,
    required this.identityNumber,
    required this.address,
    required this.signalRConnectionId,
    required this.email,
    required this.userAccessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      name: json['name'],
      surname: json['surname'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      identityNumber: json['identityNumber'],
      address: json['address'],
      signalRConnectionId: json['signalRConnectionId'],
      email: json['email'],
      userAccessToken: json['userAccessToken'],
    );
  }
}

class UserLoginDto {
  User userInformation;
  String userAccessToken;
  Response response;

  UserLoginDto({
    required this.userInformation,
    required this.userAccessToken,
    required this.response,
  });

  factory UserLoginDto.fromJson(Map<String, dynamic> json) {
    return UserLoginDto(
      userInformation: User.fromJson(json['userInformation']),
      userAccessToken: json['userAccesToken'],
      response: Response.fromJson(json['response']),
    );
  }
}

enum ResponseCode {
  Success,
  NoContent,
  BadRequest,
  UnAuthorized,
  NotFound,
  Fail,
}

extension ResponseCodeExtension on ResponseCode {
  int get value {
    switch (this) {
      case ResponseCode.Success:
        return 200;
      case ResponseCode.NoContent:
        return 204;
      case ResponseCode.BadRequest:
        return 400;
      case ResponseCode.UnAuthorized:
        return 401;
      case ResponseCode.NotFound:
        return 404;
      case ResponseCode.Fail:
        return 500;
      default:
        throw Exception('Invalid ResponseCode');
    }
  }
}


class Response {
  ResponseCode responseCode;
  String? message;

  Response(this.responseCode, {this.message});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      ResponseCode.values.firstWhere(
            (code) => code.toString() == json['responseCode'],
        orElse: () => ResponseCode.Fail,
      ),
      message: json['message'],
    );
  }
}
