import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Finding Outlier"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeInitial) {
            return Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Input array',
                  ),
                  onSubmitted: (value) => BlocProvider.of<HomeBloc>(context)
                      .add(FindOutlierEvent(value)),
                )
              ],
            );
          }
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is OutlierFoundState) {
            return Center(
                child: Column(
              children: [
                Text(state.outlier.toString()),
                ElevatedButton(
                    onPressed: () => BlocProvider.of<HomeBloc>(context)
                        .add(BackButtonPressedEvent()),
                    child: const Text("Back"))
              ],
            ));
          }
          return Container();
        }),
      ),
    );
  }
}
