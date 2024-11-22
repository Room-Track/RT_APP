// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:room_track_flutterapp/components/input_field.dart';
import 'package:room_track_flutterapp/theme/icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_track_flutterapp/views/auth/forgot_page.dart';
import 'package:room_track_flutterapp/views/auth/signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onForgotPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPage()));
  }

  void onSignUp(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  void onGuest() {
    FirebaseAuth.instance.signInAnonymously();
  }

  void onSignIn(AppLocalizations lang) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (err) {
      Navigator.pop(context);
      wrongField(err.code, lang);
    }
  }

  void wrongField(String errCode, AppLocalizations lang) {
    String message;
    switch (errCode) {
      case "user-not-found" || "invalid-email":
        message = lang.error_email;
        break;
      case "invalid-credential":
        message = lang.error_password;
        break;
      case 'channel-error':
        message = lang.must_complete;
        break;
      default:
        //message = lang.no_response;
        message = errCode;
        break;
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2),
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
                    const SizedBox(height: 10),
                    /**
                     * Forgot your password?
                     */
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: onForgotPassword,
                        child: Text(lang.forgot_password),
                      ),
                    ),
                    const SizedBox(height: 20),
                    /**
                     * Sign in
                     */
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          onSignIn(lang);
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
                          child: Text(lang.sign_in),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    /**
                     * Outlook
                     */
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                          /**
                           * Sign up
                           */
                          ElevatedButton.icon(
                            onPressed: () {
                              onSignUp(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.surface,
                              foregroundColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 0,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(lang.sign_up),
                            ),
                          ),
                          /**
                           * Enter as guest
                           */
                          ElevatedButton.icon(
                            onPressed: onGuest,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.surface,
                              foregroundColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 0,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(lang.guest),
                            ),
                          ),
                        ],
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
          )
        ],
      ),
    );
  }
}
