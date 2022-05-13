import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style_gallery/providers/providers.dart';
import 'package:style_gallery/services/services.dart';
import 'package:style_gallery/theme/app_theme.dart';
import 'package:style_gallery/theme/input_decoration.dart';
import 'package:style_gallery/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grayLight,
      body: AuthBackground(
        child: Center(
          heightFactor: 1.05,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 40),
                  child: const Image(
                    height: 75,
                    image: AssetImage(
                      'assets/White_Tegra_CMYK.png',
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                CardContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ChangeNotifierProvider(
                        create: (_) => LoginFormProvider(),
                        child: const _LoginForm(),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 70),
                InkWell(
                  child: const Text(
                    '¿Tiene problemas para ingresar?',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  onTap: () => launchUrl(Uri.parse(
                      'https://tegraglobal.sysaidit.com/servicePortal')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'nombre.apellido',
                labelText: 'Usuario',
                prefixIcon: Icons.person_outline),
            validator: (value) {
              String pattern = '[a-zA-Z]+\.[a-zA-Z]+';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '') ? null : 'Usuario no valido';
            },
            onChanged: (value) => loginForm.usuario = value,
          ),
          const SizedBox(height: 30),
          TextFormField(
              obscureText: true,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '******',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              validator: (value) {
                if (value != null && value.length >= 4) return null;
                return 'La contraseña debe tener almenos 4 caracteres';
              },
              onChanged: (value) => loginForm.password = value),
          const SizedBox(height: 30),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color.fromRGBO(133, 46, 44, 1),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere...' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;
                      final String? errorMessage = await authService.login(
                          loginForm.usuario, loginForm.password);
                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        NotificationsService.showSnackbar(errorMessage);
                        loginForm.isLoading = false;
                      }
                    }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
