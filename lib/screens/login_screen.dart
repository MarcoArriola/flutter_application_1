import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../utils/network_utils.dart';
import 'webview_screen.dart';
import 'offline_screen.dart';

/// LoginScreen: Pantalla de inicio de sesión con código QR
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _qrController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _qrController.dispose();
    super.dispose();
  }

  /// Maneja el proceso de login
  /// 1. Verifica conexión a internet
  /// 2. Realiza petición HTTP POST
  /// 3. Guarda URL y navega a WebViewScreen o muestra error
  Future<void> _handleLogin() async {
    final qrValue = _qrController.text.trim();

    if (qrValue.isEmpty) {
      _showSnackBar('Por favor, ingresa tu código');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Verificar conexión a internet
      final isOnline = await NetworkUtils.isNetworkAvailable();
      if (!isOnline) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const OfflineScreen()),
          );
        }
        return;
      }

      // Realizar petición HTTP POST
      final response = await http
          .post(
            Uri.parse('https://fuelbarbla.com/clientes/login.php'),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: {'qr': qrValue},
          )
          .timeout(const Duration(seconds: 10));

      if (!mounted) return;

      // Decodificar respuesta JSON
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['success'] == true) {
        // Login exitoso
        final usr = jsonResponse['qr'];
        final finalUrl = 'https://fuelbarbla.com/clientes/cliente.php?usr=$usr';

        // Guardar URL en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_url', finalUrl);

        // Navegar a WebViewScreen sin permitir volver atrás
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: finalUrl),
            ),
          );
        }
      } else {
        // Login fallido
        final errorMessage = jsonResponse['message'] ?? 'Error desconocido';
        _showSnackBar(errorMessage);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      _showSnackBar('Error del servidor, inténtalo de nuevo');
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Muestra un SnackBar con el mensaje especificado
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FuelBar Login'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const FlutterLogo(size: 80),
              const SizedBox(height: 32),

              // Título
              const Text(
                'Ingresa tu código',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Campo de texto para el código QR
              TextField(
                controller: _qrController,
                decoration: InputDecoration(
                  hintText: 'Ingresa tu código',
                  labelText: 'Código QR',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.qr_code),
                  enabled: !_isLoading,
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 24),

              // Botón de login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Ingresar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
