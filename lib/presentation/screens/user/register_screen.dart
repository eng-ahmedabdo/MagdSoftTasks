// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/register_cubit/register_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/register_cubit/register_states.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/login_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/view/loading_view.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/network/requests/register_request.dart';
import '../../widget/custom_button.dart';
import '../../widget/toast.dart';
import '../../widget/change_lang_button.dart';

class RegisterScreen extends StatelessWidget {
  static const String id = "RegisterScreen";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (context) {
        return RegisterCubit();
      },
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is ErrorRegisterState) {
            showToast(text: AppLocalizations.of(context)!.errorSignIn);
          }

          if (state is SuccessRegisterState) {
            showToast(text: AppLocalizations.of(context)!.creatingAccountOk);
          }
        },
        builder: (context, state) {
          final registerCubit = RegisterCubit.get(context);

          return Scaffold(
            backgroundColor: AppColor.blue,
            body: SafeArea(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ChangeLangButton(),
                      Image.asset(
                        "assets/images/logo_flutter.png",
                        fit: BoxFit.cover,
                        height: 100,
                        width: 150,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 491,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 16.0),
                        decoration: const BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                            ),),
                        child: state is LoadingRegisterState
                            ? const Center(child: LoadingView())
                            : SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 20,),
                                    Container(
                                      color: AppColor.grey,
                                      child: CustomTextFormFiled(
                                          controller: nameController,
                                          inputType: TextInputType.text,
                                          hint: AppLocalizations.of(context)!
                                              .fullName,
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
                                          controller: emailController,
                                          inputType: TextInputType.emailAddress,
                                          hint: AppLocalizations.of(context)!.email,
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
                                          controller: phoneController,
                                          inputType: TextInputType.text,
                                          hint:
                                              AppLocalizations.of(context)!.phoneNo,
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
                                          obSecure: registerCubit.isPassword,
                                          context: context,
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                registerCubit.toggleIsPassword();
                                              },
                                              icon: registerCubit.isPassword
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
                                      height: 16.0,
                                    ),
                                    Container(
                                      color: AppColor.grey,
                                      child: CustomTextFormFiled(
                                          controller: confirmPasswordController,
                                          hint: AppLocalizations.of(context)!
                                              .confirmPassword,
                                          inputType: TextInputType.text,
                                          obSecure: registerCubit.isPassword,
                                          context: context,
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                registerCubit.toggleIsPassword();
                                              },
                                              icon: registerCubit.isPassword
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
                                      height: 75.0,
                                    ),
                                    Row(
                                      children: [
                                        CustomButton(
                                          text: AppLocalizations.of(context)!
                                              .register,
                                          backgroundColor: AppColor.blue,
                                          onPressedCallback: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              final result =
                                                  await registerCubit.register(
                                                      registerRequest:
                                                          RegisterRequest(
                                                              name: nameController
                                                                  .text,
                                                              email:
                                                                  emailController
                                                                      .text,
                                                              password:
                                                                  passwordController
                                                                      .text,
                                                              phone:
                                                                  phoneController
                                                                      .text));

                                              if (result) {
                                                Navigator.pop(context);
                                              }
                                            }
                                          },
                                        ),
                                        Spacer(flex: 1),
                                        CustomButton(
                                            text: AppLocalizations.of(
                                                context)!
                                                .login,
                                            onPressedCallback: () {
                                              Navigator.pushNamed(context,
                                                  LoginScreen.id);
                                            },
                                            backgroundColor:
                                            AppColor.blue),
                                      ],
                                    ),
                                  ],
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
