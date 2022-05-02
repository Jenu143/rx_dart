import 'package:api_call_with_rx_test_2/bloc/api_bloc.dart';
import 'package:api_call_with_rx_test_2/model/api_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiBlock apiBlock = ApiBlock();

  fetchData() {
    apiBlock.apiSink();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<CustomApiProvider<ApiModel>>(
        stream: apiBlock.apiStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.data?.results.length,
              shrinkWrap: true,
              itemBuilder: (context, i) => Column(
                children: [
                  Text("${snapshot.data?.data?.results[i].postarPath}"),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
