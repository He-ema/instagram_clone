import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/constants.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> signUpwithEmail({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required File image,
  }) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('auth done ');
      String file = await uploadImageToFirebase(image: image, email: email);
      print('upload done ');

      await createUser(email: email, userName: userName, bio: bio, image: file);
      print('creating done ');

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailure(
            errorHeader: 'Weak Password',
            errorMessage: 'This Password is Too weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailure(
            errorHeader: 'Email Already exists',
            errorMessage: 'This email is already used'));
      }
    } catch (e) {
      emit(AuthFailure(
          errorHeader: 'Error',
          errorMessage: 'Something went wrong , try again'));
    }
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailure(
            errorHeader: 'User not found',
            errorMessage: 'The Email You entered doesn\'t match a user'));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailure(
            errorHeader: 'Wrong password',
            errorMessage: 'This password is wrong'));
      }
    } catch (e) {
      emit(AuthFailure(
          errorHeader: 'Error',
          errorMessage: 'Something went wrong , try again'));
    }
  }

  Future<void> createUser({
    required String email,
    required String userName,
    required String bio,
    required String image,
  }) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection(kUsersCollectionReference);

      await users.doc(email).set({
        kEmail: email,
        kUserName: userName,
        kBio: bio,
        kImage: image,
        kFollowers: [],
        kFollowing: [],
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> uploadImageToFirebase(
      {required File image, required String email}) async {
    final ref = FirebaseStorage.instance.ref().child(email);
    await ref.putFile(image);
    final url = await ref.getDownloadURL();
    return url;
  }
}
