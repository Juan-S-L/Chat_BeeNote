import "package:chat_app/helpers/mostrar_alerta.dart";
import "package:chat_app/services/auth_service.dart";
import "package:chat_app/services/socket_service.dart";
import "package:chat_app/widgets/widgsts.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  bool _obscureText1 = true;

  final emailTextController = TextEditingController();
  final passwodrTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formState,

      child: Column(
        children: [
          const SizedBox(height: 30),
        
          // Nombre Usuario
          MyTextFormField(
            controller: emailTextController,
            hintText: 'Correo',
            obscureText: false,
            validator: (value) {

              return (value == null || value.isEmpty)
                ? 'El campo no puede estar vacio'
                : null;

            },
          ),
      
          // Password
          MyTextFormField(
            controller: passwodrTextController,
            hintText: 'Contraseña',
            obscureText: _obscureText1,
            suffixIcon: GestureDetector(
              onTap: (){
                setState(() {
                  _obscureText1 = !_obscureText1;
                });
              },
              child: Icon(_obscureText1 ? Icons.visibility : Icons.visibility_off),
            ),
            validator: (value) {

              return (value != null && value.length >= 6) 
                ? null 
                : 'La contraseña debe de ser de 6 caracteres';

            },
          ),
        
          // Boton Iniciar Sesion
          const SizedBox(height: 25),
          HexagonalButton(
            onTap: authService.autenticando 
              ? () => {} 
              : () async {

               FocusScope.of(context).unfocus();

               final loginOk = await authService.login( emailTextController.text.trim(), passwodrTextController.text.trim() );

                if ( loginOk ) {
                  socketService.connect();
                  Navigator.pushReplacementNamed(context, 'usuarios');
                } else {
                  // Mostara alerta
                  mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
                }

            },
            text: 'Iniciar Sesion'
          ),
        
          // Registrar
          GestureDetector(
            onTap: () {
              // Lógica para el evento de tap (registro)
              Navigator.pushReplacementNamed(context, 'register');
            },
            child: const SizedBox(
              child: Text(
                'Registrate',
                style: TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 30,
                  color: Color(0xFFF3753D),
                ),
              ),
            ),
          ),
        
          const Text(
            'o',
            style: TextStyle(
              fontFamily: 'Letters_for_Learners',
              fontSize: 35,
              color: Color(0xFFF3753D),
            ),
          ),
        
          // Boton de registro con Google
          const SizedBox(height: 10),
          MyButtonGoogle(onTap: (){}, text: 'Google')
        ],
      ),

    );
  }
}
