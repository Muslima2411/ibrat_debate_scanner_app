import "dart:convert";

CheckPhone checkPhoneFromJson(String str) => CheckPhone.fromJson(json.decode(str) as Map<String, dynamic>);

String checkPhoneToJson(CheckPhone data) => json.encode(data.toJson());

class CheckPhone {

  CheckPhone({
    this.success,
    this.data,
  });

  factory CheckPhone.fromJson(Map<String, dynamic> json) => CheckPhone(
    success: json["success"] as bool,
    data: json["data"] == null ? null : Data.fromJson(json["data"] as Map<String, dynamic>),
  );
  final bool? success;
  final Data? data;

  CheckPhone copyWith({
    bool? success,
    Data? data,
  }) =>
      CheckPhone(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {

  Data({
    this.status,
    this.smsCodeId,
    this.code,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"] as String,
    smsCodeId: json["smsCodeId"] as String,
    code: json["code"] as String,
  );
  final String? status;
  final String? smsCodeId;
  final String? code;

  Data copyWith({
    String? status,
    String? smsCodeId,
    String? code,
  }) =>
      Data(
        status: status ?? this.status,
        smsCodeId: smsCodeId ?? this.smsCodeId,
        code: code ?? this.code,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "smsCodeId": smsCodeId,
    "code": code,
  };
}
