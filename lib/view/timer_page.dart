import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/bloc/timer_bloc.dart';
import 'package:flutter_timer/bloc/timer_state.dart';
import 'package:flutter_timer/view/widgets/background.dart';
import 'package:flutter_timer/view/widgets/button_actions.dart';

import '../bloc/timer_event.dart';
import '../model/ticker.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: Ticker()),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final durationTextController = TextEditingController();
    final size = MediaQuery.of(context).size;
    final foc = FocusNode();
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Timer')),
      body: Stack(
        children: [
          Background(),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text('Enter time in minutes',style: TextStyle(fontSize: size.height * .022),),
              ),
              SizedBox(height: size.height *.019,),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 2)
                ),
                height: size.height * .05,
                width: size.width *.36,
                child: TextFormField(
                  enabled: true,
                  controller: durationTextController,
                  keyboardType:TextInputType.number,
                  onChanged: (val){
                    print(val);
                  },
                )
              ),
              ElevatedButton(onPressed: (){
                print(durationTextController.text);
                int dur = int.parse(durationTextController.text);
                context.read<TimerBloc>().setTimer(dur*60);
                context.read<TimerBloc>().add(TimerReset());
                FocusScope.of(context).unfocus();
              }, child: Text('done')),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(child: TimerText()),
              ),
              ButtonActions(),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
