# FuelBar App - Documentación de Implementación

## 📱 Resumen del Proyecto

**FuelBar** es una aplicación Flutter que ha sido completamente refactorizada desde su versión Android nativa. La aplicación permite a los usuarios:

1. Iniciar sesión ingresando un código QR en un campo de texto
2. Autenticarse contra un servidor backend
3. Ver su perfil en un WebView
4. Manejar estados offline

## 📋 Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada de la aplicación
├── screens/
│   ├── splash_screen.dart      # Pantalla de arranque (SplashScreen)
│   ├── login_screen.dart       # Pantalla de inicio de sesión
│   ├── webview_screen.dart     # Pantalla del perfil del cliente
│   └── offline_screen.dart     # Pantalla sin conexión
└── utils/
    └── network_utils.dart      # Utilidades de conectividad

```

## 🔧 Dependencias Utilizadas

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0                          # Peticiones HTTP
  webview_flutter: ^4.4.2               # WebView para mostrar perfil
  shared_preferences: ^2.2.2            # Persistencia local de sesión
  connectivity_plus: ^5.0.1             # Verificación de conectividad
```

## 🔄 Flujo de la Aplicación

### 1. **Usuario Nuevo**
```
App Inicia
    ↓
SplashScreen (verifica sesión guardada)
    ↓ (no hay sesión)
LoginScreen (usuario ingresa código)
    ↓ (petición exitosa)
Guardar URL → WebViewScreen
```

### 2. **Usuario Recurrente**
```
App Inicia
    ↓
SplashScreen (verifica sesión guardada)
    ↓ (sesión existe)
WebViewScreen (carga perfil)
```

### 3. **Sin Conexión**
```
LoginScreen → Clic en "Ingresar"
    ↓ (sin internet)
OfflineScreen (muestra error)
    ↓ (usuario presiona "Reintentar")
LoginScreen
```

## 📄 Descripción de Pantallas

### 1. **SplashScreen** (`splash_screen.dart`)
**Propósito:** Pantalla inicial que verifica si el usuario ya tiene sesión activa.

**Funcionalidad:**
- Muestra logo y nombre de la app
- Verifica `SharedPreferences` por clave `user_url`
- Si existe sesión guardada → navega a `WebViewScreen` con la URL
- Si no existe → navega a `LoginScreen`
- Tiempo de espera: 2 segundos (simula carga)

**Widgets Principales:**
- `CircularProgressIndicator` durante la carga
- `FlutterLogo` como placeholder del logo

---

### 2. **LoginScreen** (`login_screen.dart`)
**Propósito:** Permite al usuario iniciar sesión ingresando un código QR.

**Funcionalidad:**
1. Usuario ingresa código en `TextField`
2. Al presionar "Ingresar":
   - ✓ Verifica conexión a internet
   - ✓ Si sin conexión → navega a `OfflineScreen`
   - ✓ Si con conexión → realiza petición POST a `https://fuelbarbla.com/clientes/login.php`
   - ✓ Petición envía: `{'qr': '<código>'}`

**Manejo de Respuestas:**
- **Exitosa** (`{'success': true, 'qr': '...'}`):
  - Extrae valor del campo `qr` (usr)
  - Construye URL: `https://fuelbarbla.com/clientes/cliente.php?usr={usr}`
  - Guarda URL en `SharedPreferences` con clave `user_url`
  - Navega a `WebViewScreen` (sin permitir volver atrás)
  
- **Fallida** (`{'success': false, 'message': '...'}`):
  - Muestra el mensaje de error en `SnackBar`
  - Mantiene la pantalla de login activa

- **Error de red o JSON**:
  - Muestra `SnackBar` genérico: "Error del servidor, inténtalo de nuevo"

**Widgets Principales:**
- `TextField` para ingresar código
- `ElevatedButton` para enviar
- `CircularProgressIndicator` mientras se realiza petición

---

### 3. **WebViewScreen** (`webview_screen.dart`)
**Propósito:** Muestra el perfil del cliente en un WebView.

**Funcionalidad:**
- Recibe URL como argumento
- Carga la página web en `WebViewController`
- JavaScript habilitado
- Muestra `CircularProgressIndicator` mientras carga
- Botón de logout en la esquina superior derecha

**Características Adicionales:**
- **Logout:** 
  - Muestra diálogo de confirmación
  - Elimina `user_url` de `SharedPreferences`
  - Navega a `LoginScreen`
  - Usuario debe ingresar código nuevamente

**Widgets Principales:**
- `WebViewWidget` para mostrar contenido
- `AppBar` con botón de logout
- `Stack` para superponer indicador de carga

---

### 4. **OfflineScreen** (`offline_screen.dart`)
**Propósito:** Informa al usuario que no tiene conexión a internet.

**Funcionalidad:**
- Muestra ícono de WiFi desconectado
- Texto descriptivo
- Botón "Reintentar" que cierra la pantalla
- Usuario vuelve a `LoginScreen` automáticamente

**Widgets Principales:**
- `Icons.wifi_off` como indicador visual
- `ElevatedButton` con ícono de refresh

---

## 🌐 Utilidades

### NetworkUtils (`utils/network_utils.dart`)
**Funciones:**
- `isNetworkAvailable()`: Verifica si hay conexión a internet
  - Retorna `Future<bool>`
  - Maneja excepciones internamente
  
- `onConnectivityChanged()`: Stream de cambios de conectividad
  - Útil para monitoreo en tiempo real (futuras mejoras)

```dart
// Ejemplo de uso
final isOnline = await NetworkUtils.isNetworkAvailable();
if (isOnline) {
  // Realizar petición
}
```

---

## 🔐 Persistencia de Datos

### SharedPreferences
- **Clave:** `user_url`
- **Valor:** URL completa del perfil del usuario
- **Almacenamiento:** Local en el dispositivo (encriptado por iOS/Android)

**Ciclo de vida:**
1. Se guarda al login exitoso
2. Se carga en `SplashScreen` para redirigir automáticamente
3. Se elimina al hacer logout

---

## 🚀 Peticiones HTTP

### Endpoint de Login
- **URL:** `https://fuelbarbla.com/clientes/login.php`
- **Método:** POST
- **Headers:** `Content-Type: application/x-www-form-urlencoded`
- **Body:** `{'qr': '<código_usuario>'}`

### Respuesta Esperada (Exitosa)
```json
{
  "success": true,
  "qr": "12345",
  "additional_fields": "..."
}
```

### Respuesta Esperada (Fallida)
```json
{
  "success": false,
  "message": "Código inválido",
  "additional_fields": "..."
}
```

---

## 🧪 Testing Recomendado

### Pruebas de Navegación
- [ ] SplashScreen muestra correctamente
- [ ] SplashScreen navega a LoginScreen sin sesión
- [ ] SplashScreen navega a WebViewScreen con sesión
- [ ] LoginScreen permite ingresar código
- [ ] WebViewScreen muestra página correctamente

### Pruebas de Conectividad
- [ ] Sin internet → OfflineScreen aparece
- [ ] Con internet → LoginScreen continúa
- [ ] Cambio de conexión durante petición

### Pruebas de Lógica de Login
- [ ] Campo vacío → Muestra error
- [ ] Código inválido → Muestra mensaje del servidor
- [ ] Código válido → URL se guarda y navega
- [ ] Sesión persiste después de cerrar app

### Pruebas de Logout
- [ ] Botón logout aparece en WebViewScreen
- [ ] Diálogo de confirmación se muestra
- [ ] URL se elimina de SharedPreferences
- [ ] Usuario vuelve a LoginScreen

---

## 📝 Mejoras Futuras

1. **Seguridad:**
   - Encriptación de URL guardada
   - Expiración de sesión
   - Validación de certificados SSL

2. **UX/UI:**
   - Animaciones de transición
   - Tema oscuro (dark mode)
   - Indicador de versión de app

3. **Conectividad:**
   - Caché offline de contenido web
   - Reintentos automáticos
   - Indicador de estado de conexión

4. **Logging y Analytics:**
   - Tracking de eventos
   - Crash reporting
   - Error logging

5. **Backend Integration:**
   - Manejo de tokens JWT
   - Refresh automático de sesión
   - Rate limiting

---

## 🔧 Comandos Útiles

```bash
# Ejecutar app
flutter run

# Compilar para release
flutter build apk          # Android
flutter build ios          # iOS (requiere Mac)
flutter build web          # Web
flutter build windows      # Windows

# Análisis de código
flutter analyze

# Formato de código
flutter format .

# Limpiar build
flutter clean
```

---

## 📦 Publicación en Stores

### Android Play Store
1. Generar keystore: `keytool -genkey -v -keystore ~/key.jks ...`
2. Compilar release: `flutter build appbundle --release`
3. Subir a Play Console

### iOS App Store
1. Tener cuenta Apple Developer
2. Configurar provisioning profiles
3. Compilar: `flutter build ios --release`
4. Subir a App Store Connect

---

## 📞 Soporte y Contacto

Para más información sobre las especificaciones técnicas:
- Revisar `.github/copilot-instructions.md`
- Consultar README.md del proyecto
