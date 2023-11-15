
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleServices {

  // Se crea una instancia de la clase 'FirebaseAuth'.
  // La variable _auth se puede utilizar en el resto del código para 
  // realizar operaciones de autenticación, como iniciar sesión, cerrar sesión, etc.
  static final FirebaseAuth _authIstance = FirebaseAuth.instance;

  // Crea una instancia de la clase GoogleSignIn, que se utiliza para interactuar con el 
  // inicio de sesión de Google.
  static final GoogleSignIn _googleSignIn = GoogleSignIn();


  //  Declara una variable user que almacenará la información del usuario después de iniciar sesión.
  static User? user;

  static Future<User?> signIn() async{

    // Inicia sesión con Google y obtiene la cuenta del usuario que ha iniciado sesión. 
    // El resultado se almacena en googleSignInAccount. (Sale la venta emergente de log in)
    // En este punto la variable 'googleSingInAccount' amacenara los datos del usuario.
    GoogleSignInAccount? googleSingInAccount = await _googleSignIn.signIn();

    // Validamos que el perfin no sea null
    if(googleSingInAccount != null){
      // Se obtiene la información de autenticación de la cuenta de Google.
      GoogleSignInAuthentication googleSignInAuthentication = await googleSingInAccount.authentication;
      // Crea un objeto AuthCredential utilizando la información de autenticación de Google. 
      // Este objeto se utiliza para autenticar al usuario en Firebase.
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );
      
      // Autentica al usuario en Firebase utilizando las credenciales proporcionadas. 
      // El resultado se almacena en userCredential.
      UserCredential userCredential = await _authIstance.signInWithCredential(credential);
      user = userCredential.user;
      return user;
    }

    return user;
  }


  static Future<void> signOut() async{
    _authIstance.signOut();
    _googleSignIn.signOut();
  }
}