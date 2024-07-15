class AddEmployeeModel {
  String? message;
  SubEmployee? subEmployee;

  AddEmployeeModel({this.message, this.subEmployee});

  AddEmployeeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    subEmployee = json['subEmployee'] != null
        ? new SubEmployee.fromJson(json['subEmployee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.subEmployee != null) {
      data['subEmployee'] = this.subEmployee!.toJson();
    }
    return data;
  }
}

class SubEmployee {
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? adminCompanyName;
  String? sId;
  int? iV;

  SubEmployee(
      {this.name,
        this.phoneNumber,
        this.email,
        this.password,
        this.adminCompanyName,
        this.sId,
        this.iV});

  SubEmployee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'];
    adminCompanyName = json['adminCompanyName'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['adminCompanyName'] = this.adminCompanyName;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
