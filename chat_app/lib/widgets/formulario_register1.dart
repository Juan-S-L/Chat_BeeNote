import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/widgets/widgsts.dart';

class FormRegister1 extends StatefulWidget {
  const FormRegister1({super.key});

  @override
  State<FormRegister1> createState() => _FormRegister1State();
}

class _FormRegister1State extends State<FormRegister1> {

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Form(

      key: _formState,

      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
          children: [
            const SizedBox(height: 15),
      
            // Nombres
            MyTextFormField(
              controller: nameTextController, 
              hintText: 'Nombre', 
              obscureText: false,
              paddingVertical: 0,
              validator: (value) {
                return (value == null || value.isEmpty)
                  ? 'El campo no puede estar vacio'
                  : null;
              },
            ),

            // Correo
            MyTextFormField(
              controller: emailTextController, 
              hintText: 'Correo', 
              obscureText: false,
              paddingVertical: 0,
              suffixIcon: const Icon(Icons.email),
              validator: (value) {
                
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
 
                RegExp regExp  = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
              },
            ),

            // contraseña
            MyTextFormField(
              controller: passwordTextController, 
              hintText: 'Contraseña', 
              obscureText: false,
              paddingVertical: 0,
              validator: (value) {

                return (value != null && value.length >= 6) 
                  ? null 
                  : 'La contraseña debe de ser de 6 caracteres';

              },
            ),
      
            // Boton Siguiente
            const SizedBox(height: 30),
            HexagonalButton(
              onTap: authService.autenticando ? null : () async {
                // Lógica para el evento de tap (Siguiente)
                print(nameTextController.text);
                print(emailTextController.text);
                print(passwordTextController.text);

                final registroOk = await authService.register(
                  nameTextController.text.trim(), 
                  emailTextController.text.trim(), 
                  passwordTextController.text.trim()
                );

                if(registroOk == true){
                  socketService.connect();
                  Navigator.pushReplacementNamed(context, 'usuarios');
                }else{
                  mostrarAlerta(
                    context, 
                    'Registro incorrecto', 
                    registroOk
                  );
                }

              },
              text: 'Registro'
            ),
            const SizedBox(height: 30),
          ],
        ),
    );
  }
}