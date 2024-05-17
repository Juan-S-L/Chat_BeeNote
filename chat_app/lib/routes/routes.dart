import 'package:flutter/material.dart';

import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/usuario_page.dart';

final Map<String, Widget  Function(BuildContext)> appRoutes = {
  'usuarios': ( _ ) => const UsuariosPage(),
  'chat': ( _ ) => const ChatPage(),
  'loading': ( _ ) => LoadingPage(),
  'register': ( _ ) => const RegisterPage1(),
  'login': ( _ ) => const LoginPage(),
};