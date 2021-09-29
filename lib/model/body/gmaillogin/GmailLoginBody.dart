class GmailLoginBody {
    String email;
    String fcm;
    String firstName;
    String imageUrl;
    String lastName;


    GmailLoginBody({required this.email, required this.fcm, required this.firstName, required this.imageUrl, required this.lastName});

    factory GmailLoginBody.fromJson(Map<String, dynamic> json) {
        return GmailLoginBody(
            email: json['email'], 
            fcm: json['fcm'], 
            firstName: json['firstName'], 
            imageUrl: json['imageUrl'], 
            lastName: json['lastName'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['fcm'] = this.fcm;
        data['firstName'] = this.firstName;
        data['imageUrl'] = this.imageUrl;
        data['lastName'] = this.lastName;
        return data;
    }
}