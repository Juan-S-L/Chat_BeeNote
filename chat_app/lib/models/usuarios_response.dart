// To parse this JSON data, do
//
//     final usuarioResponsive = usuarioResponsiveFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

UsuarioResponsive usuarioResponsiveFromJson(String str) => UsuarioResponsive.fromJson(json.decode(str));

String usuarioResponsiveToJson(UsuarioResponsive data) => json.encode(data.toJson());

class UsuarioResponsive {
    bool ok;
    List<Usuario> usuarios;

    UsuarioResponsive({
        required this.ok,
        required this.usuarios,
    });

    factory UsuarioResponsive.fromJson(Map<String, dynamic> json) => UsuarioResponsive(
        ok: json["ok"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}
