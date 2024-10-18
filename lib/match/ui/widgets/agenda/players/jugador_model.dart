import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rol_match/match/data/services/action_service.dart';
import 'package:rol_match/user/ui/views/profile/vista_player.dart';
import 'package:rol_match/user/ui/views/user_model.dart';

class JugadorModel {
  Widget Jugador(BuildContext context, String name, int id) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.dialogBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: Offset(4.0, 4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-4.0, -4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                //placeholder
              },
              child: Row(children: [
                const Icon(Icons.person),
                SizedBox(
                  width: 20,
                ),
                Text(
                  name,
                )
              ])),
          Spacer(),
          botonConfig(context, id),
        ],
      ),
    );
  }

  Widget botonConfig(context, int id) {
    return Container(
      height: 50.0,
      width: 50.0,
      child: TextButton(
        child: Icon(Icons.view_timeline),
        onPressed: () {
          showOptionsDialog(context, id);
        },
      ),
    );
  }

  void showOptionsDialog(BuildContext context, int id) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Seleccionar opción'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              showConfirmationDialog(context, 'recomendar', id);
            },
            child: const Text('Recomendar'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              showConfirmationDialog(context, 'Reportar', id);
            },
            child: const Text('Reportar'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              showProfileDialog(context, 'ver usuario', id);
            },
            child: const Text('Ver usuario'),
          ),
        ],
      ),
    );
  }

  void showConfirmationDialog(BuildContext context, String action, int id) {
    ActionService service = new ActionService();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Confirmar acción'),
        content: Text('¿Estás seguro de que deseas $action?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (action == "Reportar") {
                service.reportUser(id);
              } else {
                service.recommendUser(id);
              }

              print(action);
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showProfileDialog(BuildContext context, String action, int id) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Confirmar acción'),
        content: Text('¿Estás seguro de que deseas ver el Perfil?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              print(action);
              Navigator.pop(context, 'OK');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VistaPlayer(userId: id)));
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
