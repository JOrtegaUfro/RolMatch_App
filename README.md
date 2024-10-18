# Rol_Match

Rol Match es una aplicación que permite crear y encontrar partidas de juegos de rol rapidamente o en segundo plano.

## Requerimientos
Flutter SDK
Android SDK

## Instalación

```bash
$ flutter pub get
```


## Iniciar el proyecto

Para iniciar el proyecto se necesitan variables de entorno
## Variables de entorno

**APP_IP:** Ip de servidor junto con su puerto en formato string ej: "192.168.0.1:3000".

### Inicio de sesión con Google
Para iniciar sesion con google se debe generar el .jks (uoload keystore)
[documentación oficial de generación de .jks](https://docs.flutter.dev/deployment/android)
Posteriormente se debe generar el SignInReport con el comando ./gradlew SignInReport
El sha-1 se debe copiar e ingresar en un usuario de android en [google console cloud](https://console.cloud.google.com/)
En caso de realizarse una prueba local debe eliminarse sigInConfigs de buil.gradle dentro de /android/app


### Construir aplicación
```bash
$ flutter build apk --debug
```
## Referencias:
[solución ./gradlew]( https://stackoverflow.com/questions/56626319/gitlab-ci-gradlew-does-not-exist-and-remove-not-passed)
[issue de flutter respecto a fallo en .gitignore autogenerado] (https://github.com/flutter/flutter/issues/109749)
