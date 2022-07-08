import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          title: Text("Finding Outlier"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeInitial) {
            return Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onSubmitted: (value) =>
                      BlocProvider.of<HomeBloc>(context).add(FindOutlierEvent()),
                )
              ],
            );
          }
          if (state is HomeLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeLoadedState) {
            return Center(
                child: Column(
              children: [
                Text(state.outlier.toString()),
                ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<HomeBloc>(context).add(BackButtonPressedEvent()),
                    child: Text("Back"))
              ],
            ));
          }
          return Container();
        }),
      ),
    );
  }
}
