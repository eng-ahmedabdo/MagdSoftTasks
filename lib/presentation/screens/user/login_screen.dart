// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/login_cubit/login_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/login_cubit/login_states.dart';
import 'package:magdsoft_flutter_structure/data/network/requests/login_request.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/register_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/user_profile.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/custom_text_form_field.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../view/loading_view.dart';
import '../../widget/custom_button.dart';
import '../../widget/change_lang_button.dart';

class LoginScreen extends StatelessWidget {
  static const String id = "LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) {
        return LoginCubit();
      },
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ErrorLoginState) {
            showToast(text: AppLocalizations.of(context)!.errorSignIn);
          }

          if (state is SuccessLoginState) {
            showToast(
                text: "مبروك تم انشاء الحساب بنجاح يمكنك تسجيل الدخول الأن");
          }
        },
        builder: (context, state) {
          final loginCubit = LoginCubit.get(context);

          return Scaffold(
            backgroundColor: AppColor.blue,
            body: SafeArea(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ChangeLangButton(),
                      Image.asset(
                        "assets/images/logo_flutter.png",
                        fit: BoxFit.cover,
                        height: 100,
                        width: 150,
                      ),
                      SizedBox(height: 30,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 494,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 16.0),
                        decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            child: state is LoadingLoginState
                                ? const LoadingView()
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 50,),
                                      Container(
                                        color: AppColor.grey,
                                        child: CustomTextFormFiled(
                                            controller: emailController,
                                            inputType: TextInputType.emailAddress,
                                            hint:
                                                AppLocalizations.of(context)!.email,
                                            context: context,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(context)!
                                                    .required;
                                              }

                                              return null;
                                            }),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      Container(
                                        color: AppColor.grey,
                                        child: CustomTextFormFiled(
                                            controller: passwordController,
                                            hint: AppLocalizations.of(context)!
                                                .password,
                                            inputType: TextInputType.text,
                                            obSecure: loginCubit.isPassword,
                                            context: context,
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  loginCubit.toggleIsPassword();
                                                },
                                                icon: loginCubit.isPassword
                                                    ? const Icon(
                                                        Icons.visibility_outlined)
                                                    : const Icon(Icons
                                                        .visibility_off_outlined)),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(context)!
                                                    .required;
                                              }

                                              return null;
                                            }),
                                      ),
                                      const SizedBox(
                                        height: 140,
                                      ),
                                      Row(
                                        children: [
                                          CustomButton(
                                            text: AppLocalizations.of(context)!
                                                .login,
                                            backgroundColor: AppColor.blue,
                                            onPressedCallback: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                final result =
                                                    await loginCubit.login(
                                                        loginRequest: LoginRequest(
                                                            email:
                                                                emailController
                                                                    .text
                                                                    .trim(),
                                                            password:
                                                                passwordController
                                                                    .text));

                                                if (result) {
                                                  // navigate to next screen

                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          UserProfile.id,
                                                          (route) => false);
                                                }
                                              }
                                            },
                                          ),
                                          Spacer(flex: 1),
                                          CustomButton(
                                              text: AppLocalizations.of(
                                                      context)!
                                                  .register,
                                              onPressedCallback: () {
                                                Navigator.pushNamed(context,
                                                    RegisterScreen.id);
                                              },
                                              backgroundColor:
                                                  AppColor.blue),
                                        ],
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
