import 'package:bloc_demo/counter_bloc.dart';
import 'package:bloc_demo/counter_event.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final counterBloc = CounterBloc();
  
  @override
  void dispose() {
    super.dispose();
    counterBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLoC Demo"),
      ),
      body: StreamBuilder<int>(
          stream: counterBloc.counter,
          initialData: 0,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "${snapshot.data}",
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          counterBloc.counterEventSink.add(IncrementEvent());
                        },
                        icon: const Icon(Icons.add)),
                    IconButton(
                        onPressed: () {
                          counterBloc.counterEventSink.add(DecrementEvent());
                        },
                        icon: const Icon(Icons.remove))
                  ],
                ),
              ],
            );
          }),
    );
  }
}
