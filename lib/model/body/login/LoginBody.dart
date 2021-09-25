class LoginBody {
    String password;
    bool rememberMe;
    String username;

    LoginBody({required this.password, required this.rememberMe, required this.username});

    factory LoginBody.fromJson(Map<String, dynamic> json) {
        return LoginBody(
            password: json['password'], 
            rememberMe: json['rememberMe'], 
            username: json['username'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['password'] = this.password;
        data['rememberMe'] = this.rememberMe;
        data['username'] = this.username;
        return data;
    }
}