import 'package:evievm_app/core/utils/network/network_info.dart';
import 'package:evievm_app/src/config/di/injection.dart';

class NetworkUtils {
  static Future<bool> get isConnected async => getIt<NetworkInfo>().isConnected;
}
