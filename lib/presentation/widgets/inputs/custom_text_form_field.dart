import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  
  final String? label;
  final String? hint;
  final String? erroMessage;
  final Function(String)? onChanged;  
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  
  
  const CustomTextFormField({
    super.key, 
    this.label, 
    this.hint, 
    this.erroMessage, 
    this.onChanged, 
    this.validator, 
    this.suffixIcon, 
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    
    final colors = Theme.of(context).colorScheme;
    
    final border = OutlineInputBorder(
      // borderSide: BorderSide(color: colors.primary),
      borderRadius: BorderRadius.circular(40),
    );
    
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText ,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith( borderSide: BorderSide(color: colors.primary)),
        errorBorder: border.copyWith( borderSide: BorderSide(color: Colors.red.shade800)),
        focusedErrorBorder: border.copyWith( borderSide: BorderSide(color: Colors.red.shade800)),
        
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        errorText: erroMessage,
        focusColor: colors.primary,
        suffixIcon: suffixIcon,
        
        
      ),
    );
  }
}