// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  bool _passwordVisible = false;
  bool _isPasswordValid = true;
  bool _isPasswordMatch = true;
  bool _isEmailValid = true;
  bool _isZipCodeValid = true;

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _validateZipCode(String zipCode) {
    final zipCodeRegex = RegExp(r'^\d{5}-\d{3}$');
    return zipCodeRegex.hasMatch(zipCode);
  }

  void _register() {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final email = _emailController.text;
    final zipCode = _zipCodeController.text;

    setState(() {
      _isPasswordValid = password.length >= 8;
      _isPasswordMatch = password == confirmPassword;
      _isEmailValid = _validateEmail(email);
      _isZipCodeValid = _validateZipCode(zipCode);

      if (_isPasswordValid &&
          _isPasswordMatch &&
          _isEmailValid &&
          _isZipCodeValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro bem-sucedido!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        if (!_isPasswordValid) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Senha deve ter pelo menos 8 caracteres'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (!_isPasswordMatch) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('As senhas não coincidem'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (!_isEmailValid) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('E-mail inválido'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (!_isZipCodeValid) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('CEP inválido (deve estar no formato XXXXX-XXX)'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'images/image.png',
                  height: 210.0,
                  width: 210.0,
                ),
                const Text(
                  'Crie sua conta',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 10, 10, 10),
                    fontFamily: 'DancingScript',
                  ),
                ),
                const SizedBox(height: 20.0),
                _buildTextField(
                  controller: _usernameController,
                  label: 'Usuário',
                  prefixIcon: Icons.person,
                ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: _emailController,
                  label: 'E-mail',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                if (!_isEmailValid)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'E-mail inválido',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: _passwordController,
                  label: 'Senha',
                  prefixIcon: Icons.lock,
                  obscureText: !_passwordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.teal,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                if (!_isPasswordValid)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Senha deve ter pelo menos 8 caracteres',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirmar Senha',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                if (!_isPasswordMatch)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'As senhas não coincidem',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: _streetController,
                  label: 'Rua',
                  prefixIcon: Icons.home,
                ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: _zipCodeController,
                  label: 'CEP',
                  prefixIcon: Icons.location_on,
                  keyboardType: TextInputType.number,
                  maxLength: 9,
                ),
                if (!_isZipCodeValid)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'CEP inválido (deve estar no formato XXXXX-XXX)',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFDA291C), // Cor igual à tela de login
                    minimumSize: const Size(double.infinity, 50.0),
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Já tem uma conta?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Voltar para a tela de login
                      },
                      child: const Text(
                        'Faça login',
                        style: TextStyle(
                          color: Color(0xFFDA291C),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon, color: Colors.teal),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength,
    );
  }
}
