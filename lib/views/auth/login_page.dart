import 'package:events_app/generated/assets.dart';
import 'package:events_app/provider/events_provider.dart';
import 'package:events_app/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///start
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesAeLogoPortraitVector, height: 100.h),
            20.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15).r,
              child: AppButtonWidget(
                onPressed: () {
                  ref.read(authRepositoryProvider).signInWithGoogle();
                },
                text: "Sign in with Google",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///end
