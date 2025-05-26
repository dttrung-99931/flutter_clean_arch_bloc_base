import 'package:base_project/core/utils/network/network_info.dart';
import 'package:base_project/src/config/di/injection.dart';

class NetworkUtils {
  static Future<bool> get isConnected async => getIt<NetworkInfo>().isConnected;
}
