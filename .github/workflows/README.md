# GitHub Actions - Build Workflows

## Workflows disponibles

Este proyecto incluye dos workflows de GitHub Actions para compilar la aplicación Flutter:

### 1. **build-ios.yml** - Build iOS (iPad)
- Compila la app para iOS en macOS
- Genera un archivo `.app` y un `.ipa`
- Se ejecuta automáticamente al hacer push a `main` o `develop`
- Se puede activar manualmente desde la pestaña "Actions"

**Triggers:**
- Push a `main` o `develop`
- Pull requests a `main` o `develop`
- Manual (workflow_dispatch)

### 2. **build-all-platforms.yml** - Build Múltiples Plataformas
- Android APK y App Bundle
- Web (SPA)
- Windows Desktop
- iOS (iPad) y macOS

Cada plataforma se compila en su runner más adecuado (Ubuntu, Windows, macOS).

## Cómo usar

### Opción 1: Activación automática
1. Haz push a la rama `main` o `develop`
2. Abre la pestaña "Actions" en GitHub
3. El workflow se ejecutará automáticamente

### Opción 2: Activación manual
1. Ve a la pestaña "Actions" en GitHub
2. Selecciona el workflow que deseas
3. Haz clic en "Run workflow"
4. Elige la rama
5. Haz clic en "Run workflow"

## Descargar artefactos

Después de que el workflow se complete:
1. Ve a "Actions"
2. Abre la ejecución del workflow
3. Descarga el artefacto correspondiente en la sección "Artifacts"

### Ubicaciones de artefactos:
- **iOS/iPad**: `ios-build` → `Runner.ipa`
- **Android**: `android-build` → `.apk` y `.aab`
- **Web**: `web-build` → Carpeta compilada
- **Windows**: `windows-build` → Ejecutable

## Notas importantes

### Para iOS/iPad en App Store:
- Se requieren provisioning profiles y certificados de firma
- Los workflows actuales generan `.ipa` sin firmar
- Para distribuir en App Store, necesitarás:
  1. Apple Developer Account
  2. Provisioning profiles
  3. Code signing certificates
  4. Configurar secrets en GitHub

### Configuración de signing (opcional)
Para agregar code signing automático:
1. Agrega secrets en Settings → Secrets → Actions:
   - `APPLE_DEVELOPER_CERTIFICATE_P12_BASE64`
   - `APPLE_DEVELOPER_CERTIFICATE_PASSWORD`
   - `APPLE_PROVISIONING_PROFILE_BASE64`
   - `APPLE_DEVELOPER_TEAM_ID`

2. Actualiza el workflow con los pasos de signing

### Para Android en Play Store:
- Se requiere un keystore de firma
- Configurar secrets similares para automatizar la firma

## Monitoreo

- Los logs detallados están disponibles en cada ejecución del workflow
- Puedes ver el estado de compilación en la pestaña "Actions"
- Notificaciones por email si la compilación falla

## Troubleshooting

### El workflow falla
1. Abre la ejecución fallida
2. Expande los pasos para ver los logs
3. Busca el error en la salida
4. Verifica que `pubspec.yaml` sea válido
5. Asegúrate de que las dependencias sean compatibles

### Los artefactos no se generan
- Verifica que el build no tenga errores en los logs
- Comprueba que los paths en `upload-artifact` sean correctos
- Algunos artefactos pueden requerir configuración adicional

## Próximos pasos

Para mejorar estos workflows:
1. Agregar tests automáticos (`flutter test`)
2. Agregar análisis de código (`flutter analyze`)
3. Agregar publicación automática en stores
4. Configurar notificaciones
