library TimerEvent;
import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}
class TimerStarted extends TimerEvent {
  final int duration;
  const TimerStarted(this.duration);
}
class TimerPaused extends TimerEvent {
  const TimerPaused();
}

class TimerResumed extends TimerEvent {
  const TimerResumed();
}
class TimerReset extends TimerEvent {
  const TimerReset();
}
class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}