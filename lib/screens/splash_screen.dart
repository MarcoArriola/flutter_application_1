import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'webview_screen.dart';

/// SplashScreen: Pantalla de arranque que verifica si existe sesión guardada
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserSession();
  }

  /// Verifica si existe una sesión de usuario guardada
  /// Si existe, navega a WebViewScreen
  /// Si no, navega a LoginScreen
  Future<void> _checkUserSession() async {
    await Future.delayed(const Duration(seconds: 2)); // Simular tiempo de carga

    if (!mounted) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final userUrl = prefs.getString('user_url');

      if (!mounted) return;

      if (userUrl != null && userUrl.isNotEmpty) {
        // Usuario recurrente: navegar a WebViewScreen
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WebViewScreen(url: userUrl)),
          );
        }
      } else {
        // Usuario nuevo: navegar a LoginScreen
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    } catch (e) {
      // En caso de error, navegar a LoginScreen
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo del App
            const FlutterLogo(size: 100),
            const SizedBox(height: 24),
            const Text(
              'FuelBar',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            // Indicador de carga
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            const Text('Cargando...'),
          ],
        ),
      ),
    );
  }
}
