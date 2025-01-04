import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//Logica del uso de notificaciones
//Se conecta a los servicios internos del telefono para mostrar una notificación
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

//Se muestra partido encontrado
Future<void> mostrarNotifications(String type) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your_channel_id', 'your_channel_name');

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await flutterLocalNotificationsPlugin.show(1, 'Partido encontrado',
      'Partida de $type encontrado!!', notificationDetails);
}

//Se muestra la notifacion que no ha encontrado partida
Future<void> negativeNotifications() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your_channel_id', 'your_channel_name');

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await flutterLocalNotificationsPlugin.show(1, 'No encontramos partido',
      'No se ha encontrado partido', notificationDetails);
}
