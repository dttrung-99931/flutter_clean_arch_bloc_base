import 'package:maingames_flutter_test/core/utils/network/network_info.dart';
import 'package:maingames_flutter_test/src/config/di/injection.dart';

class NetworkUtils {
  static Future<bool> get isConnected async => getIt<NetworkInfo>().isConnected;
}
