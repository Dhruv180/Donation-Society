// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirebaseAuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<User?> signUpWithEmailAndPassword(
//       String email, String password, String name, String contactNumber, Function(String) showMessage) async {
//     try {
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       User? user = credential.user;

//       // Store user data in Firestore
//       if (user != null) {
//         await _firestore.collection('users').doc(user.uid).set({
//           'name': name,
//           'email': email,
//           'contactNumber': contactNumber,
//           'createdAt': FieldValue.serverTimestamp(),
//         });
//       }

//       return user;
//     } on FirebaseAuthException catch (e) {
//       String message;
//       switch (e.code) {
//         case 'email-already-in-use':
//           message = 'The email address is already in use.';
//           break;
//         case 'weak-password':
//           message = 'The password provided is too weak.';
//           break;
//         case 'invalid-email':
//           message = 'The email address is not valid.';
//           break;
//         default:
//           message = 'An error occurred: ${e.message}';
//       }
//       showMessage(message);
//     } catch (e) {
//       showMessage('An unexpected error occurred. Please try again.');
//     }
//     return null;
//   }
// }
