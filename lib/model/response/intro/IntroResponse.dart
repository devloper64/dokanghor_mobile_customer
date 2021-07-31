class IntroResponse {
    int id;
    String image;
    String text;

    IntroResponse({required this.id, required this.image, required this.text});

    factory IntroResponse.fromJson(Map<String, dynamic> json) {
        return IntroResponse(
            id: json['id'], 
            image: json['image'], 
            text: json['text'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['image'] = this.image;
        data['text'] = this.text;
        return data;
    }
}