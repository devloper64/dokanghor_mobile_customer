class PhoneLoginBody {
    String fcm;
    String phone;

    PhoneLoginBody({required this.fcm, required this.phone});

    factory PhoneLoginBody.fromJson(Map<String, dynamic> json) {
        return PhoneLoginBody(
            fcm: json['fcm'], 
            phone: json['phone'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['fcm'] = this.fcm;
        data['phone'] = this.phone;
        return data;
    }
}