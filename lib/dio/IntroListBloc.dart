
import 'package:ecommerce_customer_app/model/reponse/intro/IntroResponse.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:rxdart/rxdart.dart';

class IntroListBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<List<IntroResponse>> _subject = BehaviorSubject<List<IntroResponse>>();


  getIntros() async {
    List<IntroResponse> response = await _appRepository.getIntros();
    _subject.sink.add(response);
  }
  dispose() {
    _subject.close();
  }
  BehaviorSubject<List<IntroResponse>> get subject => _subject;

}

final introsBloc = IntroListBloc();
