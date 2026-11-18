class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;

  Login({this.code, this.status, this.token, this.userID, this.userEmail});

  factory Login.fromJson(Map<String, dynamic> obj) {
    var rawUserId = obj['data']?['user']?['id'];
    var rawCode = obj['code'];
    return Login(
      code: rawCode is int ? rawCode : int.tryParse(rawCode?.toString() ?? ''),
      status: obj['status'],
      token: obj['data']?['token'],
      userID: rawUserId is int
          ? rawUserId
          : (rawUserId != null ? int.tryParse(rawUserId.toString()) : null),
      userEmail: obj['data']?['user']?['email'],
    );
  }
}
