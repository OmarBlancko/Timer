import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/bloc/timer_bloc.dart';
import 'package:flutter_timer/bloc/timer_event.dart';
import 'package:flutter_timer/bloc/timer_state.dart';

class ButtonActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (state is TimerInitial) ...[
                FloatingActionButton(
                  onPressed: () => context
                      .read<TimerBloc>()
                      .add(TimerStarted(state.duration)),
                  child: Icon(Icons.play_arrow),
                )
              ],
              if (state is TimerRunInProgress) ...[
                FloatingActionButton(
                  onPressed: () => context.read<TimerBloc>().add(TimerPaused()),
                  child: Icon(Icons.pause),
                ),
                FloatingActionButton(
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                  child: Icon(Icons.replay),
                ),
              ],
              if (state is TimerRunPause) ...[
                FloatingActionButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: () => context.read<TimerBloc>().add(TimerResumed()),
                ),
                FloatingActionButton(
                  child: Icon(Icons.replay),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                ),
              ],
              if(state is TimerRunComplete) ...[
                FloatingActionButton(
                  child: Icon(Icons.replay),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                ),
              ]
            ],
          );
        });
  }
}
