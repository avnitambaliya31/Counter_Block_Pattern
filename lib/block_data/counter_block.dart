import 'dart:async';

import 'package:block_pattern/block_data/counter_event.dart';

class CounterBlock {
  int _counter = 0;

  /// It is used for put data and get data from using Stream
  /// streamsink is used for the inpout the data in stream
  /// stream is used for the output the data
  /// controller ne private j banavo jya suidhi saky hoi tya sudhi
  final _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink;
  Stream<int> get steamcounter => _counterStateController.stream;

  //for events stream controller is used to the two side of ways are used
  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;
  Stream<CounterEvent> get _counterEventStream =>
      _counterEventController.stream;

  CounterBlock() {
    // steamcounter.listen((event) {});
    _counterEventStream.listen(_mapEventState);
  }

  void _mapEventState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    // this is first pipe are used to the data to add and get second pipe data is call this line
    // more about to get show the pipe please visite the image for more informartion
    //imnage path is given the : images/steam data.png
    _inCounter.add(_counter);
  }

  @override
  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
