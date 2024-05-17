import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/usuarios_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/models/usuario.dart';

class UsuarioService{

  Future<List<Usuario>> getUsuarios() async {

    String? token = await AuthService.getToken();

    try {
      final uri = Uri.parse('${ Enviroment.apiUrl }/usuarios');
      final resp = await http.get(uri, 
        headers: {
          'Content-Type': 'application/json',
          'x-token': token.toString()
        }
      );

      final usuarioResponsive = usuarioResponsiveFromJson(resp.body);

      return usuarioResponsive.usuarios;
    } catch (e) {
      return [];
    }
  }

}