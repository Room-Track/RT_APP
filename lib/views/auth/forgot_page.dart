import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:room_track_flutterapp/components/input_field.dart';
import 'package:room_track_flutterapp/theme/icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onSend(AppLocalizations lang) async {
    if (emailController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text(lang.error_fields_empty)));
      return;
    }
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(lang.email_sended)));
    } on FirebaseAuthException catch (err) {
      switch (err.code) {
        case 'auth/invalid-email':
          showDialog(
              context: context,
              builder: (context) => AlertDialog(title: Text(lang.error_email)));
          break;
        default:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(title: Text(lang.no_response)));
          break;
      }
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
                     * Info Text
                     */
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        lang.send_to,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 30),
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
                    const SizedBox(height: 30),
                    /**
                     * Send
                     */
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          onSend(lang);
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
                          child: Text(lang.send),
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
