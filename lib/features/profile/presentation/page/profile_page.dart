import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekart/core/widgets/custom_scaffold.dart';
import 'package:ekart/features/home/presentation/Widgets/custom_text_view.dart';
import 'package:ekart/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:ekart/features/profile/presentation/widget/custom_profile_action_button.dart';
import 'package:ekart/features/sign_login/presentation/cubit/auth_cubit.dart';
import 'package:ekart/features/sign_login/presentation/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    final token = context.read<AuthCubit>().token;
    if (token != null) {
      context.read<ProfileCubit>().getUserProfile(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "Profile",
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
            if (state is ProfileLoaded) {
              final profile = state.profile;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    spacing: 10,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            profile.avatar,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )),
                      CustomTextView(
                          text: profile.name,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                      CustomTextView(
                          text: profile.email,
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomProfileActionButton(
                          leadIcon: Icons.person_outline_rounded,
                          title: "Edit Profile",
                          onTap: () {},
                          actionWidget: const Icon(Icons.arrow_forward_ios),
                          color: Colors.black),
                      CustomProfileActionButton(
                          leadIcon: Icons.location_on_outlined,
                          title: 'Address',
                          actionWidget: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                          color: Colors.black),
                      CustomProfileActionButton(
                          leadIcon: Icons.notification_important_outlined,
                          title: 'Notification',
                          actionWidget: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                          color: Colors.black),
                      CustomProfileActionButton(
                          leadIcon: Icons.payment_rounded,
                          title: 'Payment',
                          actionWidget: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                          color: Colors.black),
                      CustomProfileActionButton(
                          leadIcon: Icons.security_rounded,
                          title: 'Security',
                          actionWidget: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                          color: Colors.black),
                      CustomProfileActionButton(
                          leadIcon: Icons.language_rounded,
                          title: 'Language',
                          actionWidget: Row(
                            children: const [
                              CustomTextView(
                                text: 'English (US)',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                          onTap: () {},
                          color: Colors.black),
                      CustomProfileActionButton(
                          leadIcon: Icons.lock_outline_rounded,
                          title: 'Privacy',
                          actionWidget: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                          color: Colors.black),
                      CustomProfileActionButton(
                          leadIcon: Icons.help_outline_rounded,
                          title: 'Help Center',
                          actionWidget: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                          color: Colors.black),
                      CustomProfileActionButton(
                          leadIcon: Icons.groups_rounded,
                          title: 'Invite Friends',
                          actionWidget: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                          color: Colors.black),
                      CustomProfileActionButton(
                          leadIcon: Icons.logout_rounded,
                          title: 'Logout',
                          actionWidget: const SizedBox(),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (route) => false);
                          },
                          color: Colors.redAccent),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text("No user Data"),
              );
            }
          }),
        ));
  }
}
