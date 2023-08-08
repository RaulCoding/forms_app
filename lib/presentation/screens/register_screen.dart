import 'package:flutter/material.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: const _RegisterView(),
    );
  }
  
}



class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              
               FlutterLogo( size: 100),
                       
              _RegisterForm(),

              
               SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}


class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String username = '';
  String email = '';
  String password = '';
  
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
        
        CustomTextFormField(
          label: 'Nombre de usuario',
          onChanged: (value) => username = value,
          validator: (value) {
            if( value == null || value.isEmpty) return 'Campo Requerido';
            if( value.trim().isEmpty) return 'Campo Requerido'; 
            if(value.length < 6) return 'Mínimo 6 letras' ;
            return null;
          },
          suffixIcon: const Icon(Icons.person_outline),
        ),
        
        const SizedBox(height: 10),
        
        CustomTextFormField(
          label: 'Correo Electrónico',
          onChanged: (value) => email = value,
          suffixIcon: const Icon(Icons.email_outlined),
          validator: (value) {
            if( value == null || value.isEmpty) return 'Campo Requerido';
            if( value.trim().isEmpty) return 'Campo Requerido';
            final emailRegExp = RegExp(
              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
            ); 
            
            if (!emailRegExp.hasMatch(value)) return 'No es un formato de correo válido';
            
            return null;
          },
        ),
        
        const SizedBox(height: 10),     
        
        CustomTextFormField(
          label: 'Contraseña',
          onChanged: (value) => password = value,
          obscureText: true,
          suffixIcon: const Icon(Icons.password_outlined),
          validator: (value) {
            if( value == null || value.isEmpty) return 'Campo Requerido';
            if( value.trim().isEmpty) return 'Campo Requerido'; 
            if(value.length < 6) return 'Mínimo 6 caracteres' ;
            return null;
          },
        ),
        
        const SizedBox(height:20),
        
        
        FilledButton.tonalIcon(
                onPressed: (){
                  
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) return;
                  
                  print('$username, $email, $password');
                }, 
                icon: const Icon(Icons.save),  
                label: const Text('Crear Usuario'),
              ),
      ]),
    );
  }
}