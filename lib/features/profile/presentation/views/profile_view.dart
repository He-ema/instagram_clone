import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/profile/presentation/managers/cubit/get_profile_data_cubit.dart';
import 'package:instagram_clone/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: BlocProvider(
          create: (context) => GetProfileDataCubit()..getProfileData(),
          child: const ProfileViewBody(),
        )),
      ),
    );
  }
}
