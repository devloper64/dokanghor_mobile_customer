class LoginResponse {
    String id_token;

    LoginResponse({required this.id_token});

    factory LoginResponse.fromJson(Map<String, dynamic> json) {
        return LoginResponse(
            id_token: json['id_token'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id_token'] = this.id_token;
        return data;
    }
}