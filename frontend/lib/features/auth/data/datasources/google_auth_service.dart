import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  // Web Client ID (usado por el Backend/Supabase para verificar el token)
  static const String serverClientId =
      '322101145466-gus3plr3amsd2oj85u5hvsmqjk608gsa.apps.googleusercontent.com';

  // iOS Client ID (o para otros dispositivos)
  static const String clientId =
      '322101145466-5puivltcq3nki2074bj7q4fca4ui2meq.apps.googleusercontent.com';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: serverClientId,
    clientId: clientId,
    scopes: ['email', 'profile', 'openid'],
  );

  /// Abre el flujo de Google Sign-In y obtiene el [idToken] de seguridad.
  Future<String?> signInAndGetIdToken() async {
    try {
      // 1. Mostrar la UI de Google para elegir cuenta
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        // El usuario canceló la autenticación
        return null;
      }

      // 2. Extraer las credenciales de alta seguridad
      final GoogleSignInAuthentication auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken == null) {
        throw Exception(
          'El proveedor de Google no devolvió un IdToken válido.',
        );
      }

      return idToken;
    } catch (e) {
      // Registrar salida limpia del error en UI
      throw Exception('Cancelado / Error en Google Sign In: $e');
    }
  }

  /// Limpia la sesión local de Google.
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
