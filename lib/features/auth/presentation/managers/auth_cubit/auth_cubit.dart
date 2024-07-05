import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/constants.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> signUpwithEmail({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

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

      users.doc(email).set({
        kEmail: email,
        kUserName: userName,
        kBio: bio,
        kImage: image,
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
