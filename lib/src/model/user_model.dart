class UserModel {
  Data? data;
  Meta? meta;

  UserModel({this.data, this.meta});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  Tokens? tokens;

  Data({this.user, this.tokens});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tokens =
    json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? bio;
  String? profilePicture;
  String? dateOfBirth;
  String? dateJoined;
  String? countryId;
  String? cityId;
  bool? enabled;

  User(
      {this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.bio,
        this.profilePicture,
        this.dateOfBirth,
        this.dateJoined,
        this.countryId,
        this.cityId,
        this.enabled});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    bio = json['bio'];
    profilePicture = json['profile_picture'];
    dateOfBirth = json['date_of_birth'];
    dateJoined = json['date_joined'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['bio'] = this.bio;
    data['profile_picture'] = this.profilePicture;
    data['date_of_birth'] = this.dateOfBirth;
    data['date_joined'] = this.dateJoined;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['enabled'] = this.enabled;
    return data;
  }
}

class Tokens {
  String? refresh;
  String? access;

  Tokens({this.refresh, this.access});

  Tokens.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    return data;
  }
}

class Meta {
  bool? onboardingComplete;
  String? message;

  Meta({this.onboardingComplete, this.message});

  Meta.fromJson(Map<String, dynamic> json) {
    onboardingComplete = json['onboarding_complete'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onboarding_complete'] = this.onboardingComplete;
    data['message'] = this.message;
    return data;
  }
}
