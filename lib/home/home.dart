import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final arrayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                "Finding Outlier",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is HomeInitial) {
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextField(
                        controller: arrayController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Wprowadź liczby',
                        ),
                        onSubmitted: (value) => BlocProvider.of<HomeBloc>(context)
                            .add(FindOutlierEvent(value)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => BlocProvider.of<HomeBloc>(context)
                          .add(FindOutlierEvent(arrayController.text)),
                      child: const Text(
                        "Wyszukaj",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ))
                ],
              );
            }
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is OutlierFoundState) {
              return WillPopScope(
                onWillPop: () async {
                  BlocProvider.of<HomeBloc>(context)
                      .add(BackButtonPressedEvent());
                  return false;
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        AutoSizeText(
                          state.outlier.toString(),
                          style: const TextStyle(
                            fontSize: 80,
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const BackButton()
                      ],
                    ),
                  ),
                ),
              );
            }
            if (state is OutlierNotFoundState) {
              return WillPopScope(
                onWillPop: () async {
                  BlocProvider.of<HomeBloc>(context)
                      .add(BackButtonPressedEvent());
                  return false;
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        AutoSizeText(
                          state.message.toString(),
                          style: const TextStyle(
                            fontSize: 40,
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const BackButton()
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          }),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          BlocProvider.of<HomeBloc>(context).add(BackButtonPressedEvent()),
      child: const Text(
        "Powrót",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
