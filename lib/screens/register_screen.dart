import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/primary_button.dart';
import '../utils/app_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = Get.put(AuthController());
  String _selectedRole = 'customer';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      _authController.register(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        role: _selectedRole,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Register',
          style: AppTextStyles.headline4.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),

                // Header
                Text('Create Account', style: AppTextStyles.headline2),
                SizedBox(height: 1.h),
                Text(
                  'Fill in your details to get started',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(height: 3.h),

                // Full Name Field
                CustomTextField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                  validator: Validators.validateName,
                ),
                SizedBox(height: 2.h),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                SizedBox(height: 2.h),

                // Phone Field
                CustomTextField(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),
                SizedBox(height: 2.h),

                // Password Field
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                SizedBox(height: 2.h),

                // Role Selection
                Text('I am a:', style: AppTextStyles.subheading2),
                SizedBox(height: 1.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: AppConstants.lightShadow,
                  ),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: Row(
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: _selectedRole == 'customer'
                                  ? AppColors.primary
                                  : AppColors.textGrey,
                              size: 5.w,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Customer',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: _selectedRole == 'customer'
                                    ? AppColors.primary
                                    : AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                        value: 'customer',
                        groupValue: _selectedRole,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() => _selectedRole = value!);
                        },
                      ),
                      Divider(height: 0, color: AppColors.border),
                      RadioListTile<String>(
                        title: Row(
                          children: [
                            Icon(
                              Icons.agriculture,
                              color: _selectedRole == 'farmer'
                                  ? AppColors.primary
                                  : AppColors.textGrey,
                              size: 5.w,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Farmer',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: _selectedRole == 'farmer'
                                    ? AppColors.primary
                                    : AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                        value: 'farmer',
                        groupValue: _selectedRole,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() => _selectedRole = value!);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),

                // Register Button
                Obx(
                      () => PrimaryButton(
                    label: 'Register',
                    onPressed: _handleRegister,
                    isLoading: _authController.isLoading.value,
                  ),
                ),
                SizedBox(height: 2.h),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyles.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        'Login',
                        style: AppTextStyles.subheading2.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
