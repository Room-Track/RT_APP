// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:room_track_flutterapp/components/input_field.dart';
import 'package:room_track_flutterapp/http/app_fetch.dart';
import 'package:room_track_flutterapp/theme/icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onSignUp(AppLocalizations lang) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    final String? token = await AppFetch.requestSingUpToken(
      emailController.text,
      passwordController.text,
    );
    Navigator.popUntil(context, (route) => route.isFirst);
    if (token != null) {
      FirebaseAuth.instance.signInWithCustomToken(token);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(lang.bad_signup)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          /**
           * Fondo "R"
           */
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(70.0),
              child: SvgPicture.asset(
                IconSchemeBackground.logoSVG,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.surfaceDim.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          /**
           * Pagina
           */
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                /**
                 * Form
                 */
                Column(
                  children: [
                    /**
                     * Correo
                     */
                    InputField(
                      controller: emailController,
                      label: lang.email,
                      hint: '${lang.example}@usm.cl',
                      hide: false,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    /**
                     * Contraseña
                     */
                    InputField(
                      controller: passwordController,
                      label: lang.password,
                      hint: lang.insert_password,
                      hide: true,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(height: 30),
                    /**
                     * Sign up
                     */
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          onSignUp(lang);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onSurface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(lang.sign_up),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                /**
                 * Empresa
                 */
                Text(
                  'PORTALS ©',
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
