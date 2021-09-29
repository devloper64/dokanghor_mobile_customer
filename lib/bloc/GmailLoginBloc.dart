import 'package:ecommerce_customer_app/model/body/gmaillogin/GmailLoginBody.dart';
import 'package:ecommerce_customer_app/model/body/login/LoginBody.dart';
import 'package:ecommerce_customer_app/model/response/login/LoginResponse.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:rxdart/rxdart.dart';


class GmailLoginBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<LoginResponse> _subject = BehaviorSubject<LoginResponse>();
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>();

  login(GmailLoginBody gmailLoginBody) async {
    _isLoading.add(true);
    LoginResponse response = await _appRepository.loginGmail(gmailLoginBody);
    _subject.sink.add(response);

    if(response.id_token.isNotEmpty){
      _isLoading.add(false);
    }

    if(response.id_token.isEmpty){
      _isLoading.add(false);
    }

  }
  dispose() {
    _subject.close();
  }

  drain(){
    _subject.sink.add(LoginResponse(id_token: ""));
  }

  BehaviorSubject<LoginResponse> get subject => _subject;
  BehaviorSubject<bool> get isLoading => _isLoading;

}

final gmailLoginBloc = GmailLoginBloc();
