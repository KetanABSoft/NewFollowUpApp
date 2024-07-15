class AllEmployeeModel {
  String? sId;
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? adminUserId;
  String? adminCompanyName;
  int? iV;

  AllEmployeeModel(
      {this.sId,
        this.name,
        this.phoneNumber,
        this.email,
        this.password,
        this.adminUserId,
        this.adminCompanyName,
        this.iV});

  AllEmployeeModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'];
    adminUserId = json['adminUserId'];
    adminCompanyName = json['adminCompanyName'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['adminUserId'] = this.adminUserId;
    data['adminCompanyName'] = this.adminCompanyName;
    data['__v'] = this.iV;
    return data;
  }
}
