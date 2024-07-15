import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/profile/presentation/managers/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:instagram_clone/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.email});
  final String email;
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool yours = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (FirebaseAuth.instance.currentUser!.email == widget.email) {
      setState(() {
        yours = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: yours
            ? null
            : AppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
              ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: BlocProvider(
          create: (context) => GetProfileDataCubit()
            ..getProfileData(
              email: widget.email,
            ),
          child: ProfileViewBody(
            email: widget.email,
            yours: yours,
          ),
        )),
      ),
    );
  }
}
