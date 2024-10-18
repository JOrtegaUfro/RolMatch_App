import 'package:flutter/material.dart';
import 'package:rol_match/user/ui/views/user_model.dart';

//Se construye vista de jugador
class VistaPlayer extends StatelessWidget {
  const VistaPlayer({super.key, required this.userId});
  final int? userId;
  @override
  Widget build(BuildContext context) {
    UserModel userModel = new UserModel();
    return userModel.build(context, userId!);
  }
}
