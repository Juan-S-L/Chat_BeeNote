import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/mensajes_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier{

  Usuario? usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    String? token = await AuthService.getToken();

    try {
      final uri = Uri.parse('${ Enviroment.apiUrl }/mensajes/$usuarioID');
      final resp = await http.get(uri, 
        headers: {
          'Content-Type': 'application/json',
          'x-token': token.toString()
        }
      );

      final mensajeResponsive = mensajesResponseFromJson(resp.body);

      return mensajeResponsive.mensajes;
    } catch (e) {
      return [];
    }
  }

}