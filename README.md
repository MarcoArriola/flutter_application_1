# FuelBar - Aplicación Flutter

Una aplicación Flutter multiplataforma que permite a los usuarios iniciar sesión con código QR y acceder a su perfil a través de un WebView.

## 📱 Características

- ✅ **Autenticación con QR**: Ingresa tu código para iniciar sesión
- ✅ **WebView Integrado**: Visualiza tu perfil en una ventana web
- ✅ **Persistencia de Sesión**: La sesión se guarda y se recupera automáticamente
- ✅ **Manejo de Conectividad**: Detecta y maneja estados sin conexión
- ✅ **Multiplataforma**: Android, iOS, Web, Windows y Linux
- ✅ **Material Design 3**: Interfaz moderna y consistente

## 🚀 Inicio Rápido

### Requisitos Previos
- Flutter SDK 3.9.2+
- Dart 3.0+
- Un editor (Android Studio, VS Code, etc.)

### Instalación

```bash
# Clonar el repositorio
git clone <repository-url>
cd flutter_application_1

# Obtener dependencias
flutter pub get

# Ejecutar en desarrollo
flutter run
```

### Compilación para Plataformas

```bash
# Android
flutter build apk --release

# iOS (requiere Mac)
flutter build ios --release

# Web
flutter build web --release

# Windows
flutter build windows --release
```

## 📂 Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada
├── screens/
│   ├── splash_screen.dart      # Pantalla de arranque
│   ├── login_screen.dart       # Pantalla de login con QR
│   ├── webview_screen.dart     # Pantalla del perfil
│   └── offline_screen.dart     # Pantalla sin conexión
└── utils/
    └── network_utils.dart      # Utilidades de red
```

## 🔐 Flujo de Autenticación

1. **App Inicia** → SplashScreen verifica sesión guardada
2. **Sin Sesión** → LoginScreen permite ingresar código QR
3. **Código Válido** → Se carga perfil en WebViewScreen
4. **Con Sesión** → WebViewScreen se abre automáticamente

## 📚 Documentación Completa

Consulta [FUELBAR_DOCUMENTATION.md](./FUELBAR_DOCUMENTATION.md) para:
- Descripción detallada de cada pantalla
- Especificaciones técnicas
- Flujos de usuario
- API endpoints
- Recomendaciones de testing

## 🔧 Dependencias Principales

- **http**: Peticiones HTTP
- **webview_flutter**: WebView para mostrar perfil
- **shared_preferences**: Almacenamiento local de sesión
- **connectivity_plus**: Verificación de conectividad

Para la lista completa, ver [pubspec.yaml](pubspec.yaml)

## 🤖 GitHub Actions

Este proyecto tiene configurados workflows automáticos para compilar en múltiples plataformas. Ver [.github/workflows/README.md](.github/workflows/README.md)

## 📋 Desarrollo

### Analizar código
```bash
flutter analyze
```

### Formatear código
```bash
flutter format .
```

### Ejecutar tests
```bash
flutter test
```

## 🐛 Troubleshooting

### La app no compila
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Problemas de conexión
- Verifica que el servidor `https://fuelbarbla.com` esté disponible
- Revisa los permisos de internet en Android/iOS

### WebView no carga
- Verifica que JavaScript esté habilitado
- Comprueba que la URL sea válida

## 📞 Contacto y Soporte

Para reportar issues o sugerencias:
1. Abre un issue en GitHub
2. Describe el problema y los pasos para reproducirlo
3. Incluye versión de Flutter y sistema operativo

## 📄 Licencia

Este proyecto está bajo licencia MIT. Ver LICENSE para más detalles.
