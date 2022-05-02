import 'package:api_call_rx_dart2/Model/data_model.dart';
import 'package:api_call_rx_dart2/Provider/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class ApiBlock {
  ApiProvider apiProvider = ApiProvider();
  final apiControll = PublishSubject<DataModel>();

  Stream<DataModel> get apiStream => apiControll.stream;

  Future apiSink() async {
    DataModel response = await apiProvider.apiProvider();
    apiControll.sink.add(response);
    return response;
  }
}
