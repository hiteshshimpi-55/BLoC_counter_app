import 'dart:async';
import './counter_event.dart';

//  sink -------> | StreamController | ------> stream
class CounterBloc{
  int _counter = 0;

  final _counterStateController = StreamController<int>();

  // Sink to add the add
  StreamSink<int> get _inCounter => _counterStateController.sink;
  // For state, exposing only a stream which outputs the data
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();

  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc(){
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event){
    if( event is IncrementEvent){
      _counter ++;
    }
    else{
      _counter --;
    }
    _inCounter.add(_counter);    
  }

  void dispose(){
    _counterEventController.close();
    _counterStateController.close();
  }
}