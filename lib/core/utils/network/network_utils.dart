import 'package:flutter_base_app/core/utils/network/network_info.dart';
import 'package:flutter_base_app/config/di/injection.dart';

class NetworkUtils {
  static Future<bool> get isConnected async => getIt<NetworkInfo>().isConnected;
}
