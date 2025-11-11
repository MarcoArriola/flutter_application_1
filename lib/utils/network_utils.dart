import 'package:connectivity_plus/connectivity_plus.dart';

/// Utilidad para verificar la conectividad a internet
class NetworkUtils {
  static final Connectivity _connectivity = Connectivity();

  /// Verifica si hay conexión a internet disponible
  /// Retorna true si hay conexión, false en caso contrario
  static Future<bool> isNetworkAvailable() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }

  /// Escucha cambios en la conectividad a internet
  /// Retorna un Stream con los cambios de conectividad
  static Stream<ConnectivityResult> onConnectivityChanged() {
    return _connectivity.onConnectivityChanged;
  }
}
