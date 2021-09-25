import 'package:ecommerce_customer_app/model/body/sign-up/SignUpBody.dart';
import 'package:ecommerce_customer_app/model/response/sign-up/SignUpCustom.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:rxdart/rxdart.dart';


class RegisterBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<SignUpCustom> _subject = BehaviorSubject<SignUpCustom>();
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>();

  register(SignUpBody signUpBody) async {
    _isLoading.add(true);
    SignUpCustom response = await _appRepository.register(signUpBody);
    _subject.sink.add(response);

    if(response.code==201){
      _isLoading.add(false);
    }

    if(response.code!=201){
      _isLoading.add(false);
    }

  }
  dispose() {
    _subject.close();
  }
  BehaviorSubject<SignUpCustom> get subject => _subject;
  BehaviorSubject<bool> get isLoading => _isLoading;

}

final registerBloc = RegisterBloc();
