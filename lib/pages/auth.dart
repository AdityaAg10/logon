import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> SignUserUp({
    required String email,
    required String dob,
    required String password,
    required String confirm,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty && dob.isNotEmpty && password.isNotEmpty && confirm.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print(cred.user!.uid);

        await _firebaseFirestore.collection('Users').doc(cred.user!.uid).set({
          'Email': email,
          'DOB': dob,
          'Pass': password,
        });

        res = 'Success';
      }
      // else {
      //   res = 'Fail';
      // }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Email is badly formatted.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }




  Future LogUserIn({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'Success';
      } else {
        res = "Please enter all the details";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
