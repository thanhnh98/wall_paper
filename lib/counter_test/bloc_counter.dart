import 'package:bloc/bloc.dart';
import 'package:flutter_app_new/counter_test/counter_event.dart';
import 'package:flutter_app_new/repository/image_repository.dart';

class CounterBloc extends Bloc<CounterEvent, int>{
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {

    switch(event){
      case CounterEvent.INCREMENT:
        yield (state + 1);
        break;
      case CounterEvent.DECREMENT:
        yield (state - 1);
        break;
    }

    throw UnimplementedError();
  }

}