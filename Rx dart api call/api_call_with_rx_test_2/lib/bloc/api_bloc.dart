import 'package:api_call_with_rx_test_2/model/api_model.dart';
import 'package:api_call_with_rx_test_2/provider/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class ApiBlock {
  ApiProvider apiProvider = ApiProvider();

  final streamController = PublishSubject<CustomApiProvider<ApiModel>>();

  Stream<CustomApiProvider<ApiModel>> get apiStream => streamController.stream;

  Future<CustomApiProvider<ApiModel>> apiSink() async {
    CustomApiProvider<ApiModel> response = await apiProvider.apiProvider();
    streamController.sink.add(response);
    return response;
  }
}
