# iOS Build - Solución de Code Signing

## 📱 ¿Por qué GitHub Actions no puede firmar para dispositivos reales?

GitHub Actions no tiene acceso a tus certificados privados de Apple. Para compilar para un dispositivo real, necesitas:

1. **Certificado de firma de Apple** (privado)
2. **Provisioning Profile** (específico para tu Bundle ID)
3. **Apple Developer Account**

---

## ✅ Solución Actual - Dos Opciones

El workflow ahora compila en dos modos:

### **Opción 1: iOS Simulator (Recomendado - Funciona sin certificados)**

- ✅ Se compila automáticamente en GitHub Actions
- ✅ No necesita certificados
- ✅ Se puede probar en simulador de Mac o en cloud services
- 📥 Descarga: **ios-simulator.zip**

**Cómo usar:**
1. Ve a Actions → Build iOS App → Última ejecución ✅
2. Descarga artifact: **ios-simulator**
3. Descomprime y obtén `Runner.app`
4. Puedes subirlo a servicios como **Appetize.io** para probarlo en iPad virtual

### **Opción 2: iOS Device (Sin firmar - Necesita configuración manual)**

- 📦 Genera un archivo `Runner.app` sin firmar
- 🔐 Necesitas firmar manualmente con tus certificados
- 👨‍💻 Requiere Xcode + Apple Developer Account
- 📥 Descarga: **ios-ipa-unsigned.zip**

**Cómo usar:**
1. Ve a Actions → Build iOS App → Última ejecución ✅
2. Descarga artifact: **ios-ipa-unsigned**
3. En tu Mac con Xcode:
   ```bash
   # Firma con tus certificados
   codesign -fs "iPhone Developer: tu-email@apple.com" Runner.app
   
   # Crea el IPA
   mkdir -p Payload
   cp -r Runner.app Payload/
   zip -r app.ipa Payload
   ```

---

## 🔒 Configuración Completa (Opcional - Para código signing automático)

Si deseas que GitHub Actions compile y firme automáticamente, necesitas:

### 1. Obtener tus certificados de Apple:

```bash
# En tu Mac
# Ve a Xcode → Preferences → Accounts
# Exporta tus certificados
```

### 2. Crear secrets en GitHub:

1. Ve a tu repositorio → **Settings → Secrets and variables → Actions**
2. Haz clic en **"New repository secret"**
3. Agrega estos secrets:

```
APPLE_CERTIFICATE_P12_BASE64=<tu_certificado_en_base64>
APPLE_CERTIFICATE_PASSWORD=<contraseña_del_certificado>
APPLE_TEAM_ID=<tu_team_id>
APPLE_KEY_ID=<tu_app_store_connect_key>
APPLE_ISSUER_ID=<tu_issuer_id>
PROVISIONING_PROFILE_BASE64=<tu_provisioning_profile>
```

### 3. Actualizar workflow (avanzado - no incluido por ahora)

---

## 🚀 Próximos Pasos - Usa la versión Simulator

1. Ve a: **https://github.com/MarcoArriola/flutter_application_1/actions**

2. Selecciona **"Build iOS App"**

3. Haz clic en **"Run workflow"**

4. Cuando termine (✅):
   - Descarga **"ios-simulator"**
   - O descarga **"ios-ipa-unsigned"** si prefieres firmar manualmente

---

## 📦 Alternativa - Usar Appetize.io

Si quieres probar tu app en un iPad virtual sin necesidad de certificados:

1. Descarga el artifact **ios-simulator**
2. Ve a https://appetize.io
3. Sube el `Runner.app`
4. Prueba tu app en iPad virtual en línea

---

## 📚 Referencias

- [Flutter iOS Build](https://docs.flutter.dev/deployment/ios)
- [Code Signing Guide](https://developer.apple.com/support/code-signing/)
- [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi)

---

## 💡 Resumen

- **Para testing rápido:** Usa **ios-simulator** ✅ (automático)
- **Para producción:** Configura code signing y usa el workflow completo
- **Para desarrollo local:** Abre `ios/Runner.xcworkspace` en Xcode en tu Mac
