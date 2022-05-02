import 'package:api_call_rx_dart2/Model/data_model.dart';
import 'package:api_call_rx_dart2/bloc/api_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiBlock _apiBlock = ApiBlock();

  fetch() async {
    _apiBlock.apiSink();
  }

  @override
  void initState() {
    fetch();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DataModel>(
        stream: _apiBlock.apiStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.results.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${snapshot.data?.results[index].title}"),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
