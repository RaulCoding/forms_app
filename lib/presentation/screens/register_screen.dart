import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';



class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      )
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


class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;
    
    
    return Form(
      child: Column(
        children: [
        
        CustomTextFormField(
          label: 'Nombre de usuario',
          onChanged: registerCubit.usernameChanged,
          suffixIcon: const Icon(Icons.person_outline),
          erroMessage: username.isPure || username.isValid
          ? null
          : 'Usuario no Valido',
        ),
        
        const SizedBox(height: 10),
        
        CustomTextFormField(
          label: 'Correo Electrónico',
          onChanged: (value) {
            registerCubit.emailChanged(value);
          },
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
          onChanged:  (value) {
            registerCubit.passwordChanged(value);
          },
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
                  
                  
                  registerCubit.onSubmit();
                }, 
                icon: const Icon(Icons.save),  
                label: const Text('Crear Usuario'),
              ),
      ]),
    );
  }
}