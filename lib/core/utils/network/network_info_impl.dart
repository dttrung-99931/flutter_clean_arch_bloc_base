import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_base_app/core/utils/network/network_info.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    return (await Connectivity().checkConnectivity()) != ConnectivityResult.none;
  }
}
