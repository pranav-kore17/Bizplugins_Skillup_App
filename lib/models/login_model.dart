class LoginModel {
  String? companyID;
  String? companyName;
  String? branchID;
  String? branchAPIRefCode;
  String? branchName;
  String? defaultExecutive;
  String? defaultExecutiveCode;
  String? defaultExecutiveName;
  String? isExecutiveChanged;
  String? searchCriteriaTypeCode;
  String? userGroup;
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? latitude;
  String? longitude;
  LoginModel(
      {this.companyID,
        this.companyName,
        this.branchID,
        this.branchAPIRefCode,
        this.branchName,
        this.defaultExecutive,
        this.defaultExecutiveCode,
        this.defaultExecutiveName,
        this.isExecutiveChanged,
        this.searchCriteriaTypeCode,
        this.userGroup,
        this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.latitude,
        this.longitude});

  LoginModel.fromJson(Map<String, dynamic> json) {
    companyID = json['CompanyID'];
    companyName = json['CompanyName'];
    branchID = json['BranchID'];
    branchAPIRefCode = json['BranchAPIRefCode'];
    branchName = json['BranchName'];
    defaultExecutive = json['DefaultExecutive'];
    defaultExecutiveCode = json['DefaultExecutiveCode'];
    defaultExecutiveName = json['DefaultExecutiveName'];
    isExecutiveChanged = json['IsExecutiveChanged'];
    searchCriteriaTypeCode = json['SearchCriteriaTypeCode'];
    userGroup = json['UserGroup'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CompanyID'] = this.companyID;
    data['CompanyName'] = this.companyName;
    data['BranchID'] = this.branchID;
    data['BranchAPIRefCode'] = this.branchAPIRefCode;
    data['BranchName'] = this.branchName;
    data['DefaultExecutive'] = this.defaultExecutive;
    data['DefaultExecutiveCode'] = this.defaultExecutiveCode;
    data['DefaultExecutiveName'] = this.defaultExecutiveName;
    data['IsExecutiveChanged'] = this.isExecutiveChanged;
    data['SearchCriteriaTypeCode'] = this.searchCriteriaTypeCode;
    data['UserGroup'] = this.userGroup;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;

    return data;
  }
}
