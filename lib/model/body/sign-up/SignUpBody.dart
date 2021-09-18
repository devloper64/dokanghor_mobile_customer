class SignUpBody {
    bool activated;
    String email;
    String fcmToken;
    String firstName;
    String imageUrl;
    String langKey;
    String lastName;
    String login;
    String password;
    String phone;

    SignUpBody({required this.activated, required this.email, required this.fcmToken, required this.firstName, required this.imageUrl, required this.langKey, required this.lastName, required this.login, required this.password, required this.phone});

    factory SignUpBody.fromJson(Map<String, dynamic> json) {
        return SignUpBody(
            activated: json['activated'], 
            email: json['email'], 
            fcmToken: json['fcmToken'], 
            firstName: json['firstName'], 
            imageUrl: json['imageUrl'], 
            langKey: json['langKey'], 
            lastName: json['lastName'], 
            login: json['login'], 
            password: json['password'], 
            phone: json['phone'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['activated'] = this.activated;
        data['email'] = this.email;
        data['fcmToken'] = this.fcmToken;
        data['firstName'] = this.firstName;
        data['imageUrl'] = this.imageUrl;
        data['langKey'] = this.langKey;
        data['lastName'] = this.lastName;
        data['login'] = this.login;
        data['password'] = this.password;
        data['phone'] = this.phone;
        return data;
    }
}