import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injector.dart';
import '../../../../app/router/route_paths.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/user_status.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../bloc/register/register_bloc.dart';
import '../bloc/register/register_event.dart';
import '../bloc/register/register_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/status_selection_card.dart';

class AuthPage extends StatefulWidget {
  final bool initialTabIsRegister;

  const AuthPage({super.key, this.initialTabIsRegister = false});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Login controllers
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  bool _obscureLoginPassword = true;

  // Register controllers
  final _fullNameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureRegisterPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIsRegister ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _fullNameController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final t = context.l10n;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LoginBloc>()),
        BlocProvider(create: (_) => getIt<RegisterBloc>()),
      ],
      child: Scaffold(
        backgroundColor: colors.background,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.l),

              // Header
              AuthHeader(
                title: t.authWelcome,
                subtitle: t.authWelcomeSubtitle,
              ),
              const SizedBox(height: AppSpacing.l),

              // Tab bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: colors.border),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: colors.textSubtle,
                    labelStyle: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600),
                    unselectedLabelStyle: AppTypography.bodyMd,
                    tabs: [
                      Tab(text: t.authLoginTitle),
                      Tab(text: t.authRegisterTitle),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.m),

              // Tab content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLoginTab(context),
                    _buildRegisterTab(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LOGIN TAB
  // ---------------------------------------------------------------------------
  Widget _buildLoginTab(BuildContext context) {
    final colors = context.appColors;
    final t = context.l10n;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.go(RoutePaths.home);
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: colors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        final emailError = state is LoginInitial ? state.emailError : null;
        final passwordError = state is LoginInitial ? state.passwordError : null;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.l),

              // Email
              _buildTextField(
                controller: _loginEmailController,
                label: t.authEmail,
                hint: t.authEmailHint,
                error: emailError,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                colors: colors,
                onChanged: (v) => context.read<LoginBloc>().add(LoginEmailChanged(v)),
              ),
              const SizedBox(height: AppSpacing.m),

              // Password
              _buildTextField(
                controller: _loginPasswordController,
                label: t.authPassword,
                hint: t.authPasswordHint,
                error: passwordError,
                prefixIcon: Icons.lock_outline_rounded,
                obscureText: _obscureLoginPassword,
                colors: colors,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureLoginPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: colors.textSubtle,
                    size: 22,
                  ),
                  onPressed: () => setState(() => _obscureLoginPassword = !_obscureLoginPassword),
                ),
                onChanged: (v) => context.read<LoginBloc>().add(LoginPasswordChanged(v)),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => context.read<LoginBloc>().add(
                            LoginSubmitted(
                              email: _loginEmailController.text.trim(),
                              password: _loginPasswordController.text,
                            ),
                          ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: colors.primary.withValues(alpha: 0.6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        )
                      : Text(
                          t.authLoginButton,
                          style: AppTypography.bodyLg.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: AppSpacing.m),

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: colors.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                    child: Text(t.authOrDivider, style: AppTypography.bodySm.copyWith(color: colors.textSubtle)),
                  ),
                  Expanded(child: Divider(color: colors.border)),
                ],
              ),
              const SizedBox(height: AppSpacing.m),

              // Guest button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () => context.go(RoutePaths.home),
                  icon: Icon(Icons.person_outline_rounded, color: colors.textMain, size: 20),
                  label: Text(
                    t.authGuestLogin,
                    style: AppTypography.bodyLg.copyWith(color: colors.textMain, fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colors.border),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // REGISTER TAB
  // ---------------------------------------------------------------------------
  Widget _buildRegisterTab(BuildContext context) {
    final colors = context.appColors;
    final t = context.l10n;

    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.go(RoutePaths.home);
        } else if (state is RegisterFormState && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: colors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final formState = state is RegisterFormState ? state : const RegisterFormState();

        return Column(
          children: [
            // Step indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l, vertical: AppSpacing.xs),
              child: _buildStepIndicator(formState.currentStep, colors, t),
            ),

            // Step content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                child: _buildStepContent(formState, colors, t, context),
              ),
            ),

            // Bottom bar
            _buildRegisterBottomBar(formState, colors, t, context),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // STEP INDICATOR
  // ---------------------------------------------------------------------------
  Widget _buildStepIndicator(int currentStep, AppColorsExtension colors, dynamic t) {
    final labels = [t.authStepCredentials, t.authStepStatus, t.authStepDetails];

    return Row(
      children: List.generate(3, (index) {
        final isActive = index <= currentStep;
        final isCurrent = index == currentStep;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            child: Column(
              children: [
                Row(
                  children: [
                    if (index > 0)
                      Expanded(
                        child: Container(height: 2, color: isActive ? colors.primary : colors.border),
                      ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isCurrent ? 30 : 26,
                      height: isCurrent ? 30 : 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? colors.primary : colors.surface,
                        border: Border.all(
                          color: isActive ? colors.primary : colors.border,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: index < currentStep
                            ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                            : Text(
                                '${index + 1}',
                                style: AppTypography.caption.copyWith(
                                  color: isActive ? Colors.white : colors.textSubtle,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    if (index < 2)
                      Expanded(
                        child: Container(height: 2, color: index < currentStep ? colors.primary : colors.border),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  labels[index],
                  style: AppTypography.caption.copyWith(
                    color: isActive ? colors.primary : colors.textSubtle,
                    fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP CONTENT
  // ---------------------------------------------------------------------------
  Widget _buildStepContent(RegisterFormState formState, AppColorsExtension colors, dynamic t, BuildContext context) {
    switch (formState.currentStep) {
      case 0:
        return _buildCredentialsStep(formState, colors, t, context);
      case 1:
        return _buildStatusStep(formState, colors, t, context);
      case 2:
        return _buildDetailsStep(formState, colors, t, context);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCredentialsStep(RegisterFormState formState, AppColorsExtension colors, dynamic t, BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.l),
        _buildTextField(
          controller: _fullNameController,
          label: t.authFullName,
          hint: t.authFullNameHint,
          error: formState.fullNameError,
          prefixIcon: Icons.person_outline_rounded,
          colors: colors,
          onChanged: (_) => _emitFormChanged(context),
        ),
        const SizedBox(height: AppSpacing.m),
        _buildTextField(
          controller: _registerEmailController,
          label: t.authEmail,
          hint: t.authEmailHint,
          error: formState.emailError,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          colors: colors,
          onChanged: (_) => _emitFormChanged(context),
        ),
        const SizedBox(height: AppSpacing.m),
        _buildTextField(
          controller: _registerPasswordController,
          label: t.authPassword,
          hint: t.authPasswordHint,
          error: formState.passwordError,
          prefixIcon: Icons.lock_outline_rounded,
          obscureText: _obscureRegisterPassword,
          colors: colors,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureRegisterPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: colors.textSubtle, size: 22,
            ),
            onPressed: () => setState(() => _obscureRegisterPassword = !_obscureRegisterPassword),
          ),
          onChanged: (_) => _emitFormChanged(context),
        ),
        const SizedBox(height: AppSpacing.m),
        _buildTextField(
          controller: _confirmPasswordController,
          label: t.authConfirmPassword,
          hint: t.authConfirmPasswordHint,
          error: formState.confirmPasswordError,
          prefixIcon: Icons.lock_outline_rounded,
          obscureText: _obscureConfirmPassword,
          colors: colors,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: colors.textSubtle, size: 22,
            ),
            onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
          ),
          onChanged: (_) => _emitFormChanged(context),
        ),
        const SizedBox(height: AppSpacing.l),
      ],
    );
  }

  Widget _buildStatusStep(RegisterFormState formState, AppColorsExtension colors, dynamic t, BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.l),
        Text(t.authSelectStatus, style: AppTypography.h3.copyWith(color: colors.textMain)),
        const SizedBox(height: AppSpacing.l),
        StatusSelectionCard(
          icon: Icons.school_rounded,
          title: t.authHighSchool,
          subtitle: t.authHighSchoolDesc,
          isSelected: formState.selectedStatus == UserStatus.highSchool,
          onTap: () => context.read<RegisterBloc>().add(const RegisterStatusSelected(UserStatus.highSchool)),
        ),
        const SizedBox(height: AppSpacing.s),
        StatusSelectionCard(
          icon: Icons.account_balance_rounded,
          title: t.authUniversity,
          subtitle: t.authUniversityDesc,
          isSelected: formState.selectedStatus == UserStatus.university,
          onTap: () => context.read<RegisterBloc>().add(const RegisterStatusSelected(UserStatus.university)),
        ),
        const SizedBox(height: AppSpacing.s),
        StatusSelectionCard(
          icon: Icons.workspace_premium_rounded,
          title: t.authGraduate,
          subtitle: t.authGraduateDesc,
          isSelected: formState.selectedStatus == UserStatus.graduate,
          onTap: () => context.read<RegisterBloc>().add(const RegisterStatusSelected(UserStatus.graduate)),
        ),
        const SizedBox(height: AppSpacing.l),
      ],
    );
  }

  Widget _buildDetailsStep(RegisterFormState formState, AppColorsExtension colors, dynamic t, BuildContext context) {
    switch (formState.selectedStatus) {
      case UserStatus.highSchool:
        return _buildGradeSelection(formState, colors, t, context);
      case UserStatus.university:
        return _buildUniversitySelection(formState, colors, t, context);
      case UserStatus.graduate:
      case null:
        return _buildGraduateComplete(colors, t);
    }
  }

  Widget _buildGradeSelection(RegisterFormState formState, AppColorsExtension colors, dynamic t, BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.l),
        Text(t.authSelectGrade, style: AppTypography.h3.copyWith(color: colors.textMain)),
        const SizedBox(height: AppSpacing.l),
        Wrap(
          spacing: AppSpacing.s,
          runSpacing: AppSpacing.s,
          children: [9, 10, 11, 12].map((grade) {
            final isSelected = formState.selectedGrade == grade;
            return GestureDetector(
              onTap: () => context.read<RegisterBloc>().add(RegisterGradeSelected(grade)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: (MediaQuery.of(context).size.width - AppSpacing.l * 2 - AppSpacing.s) / 2,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.l),
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary.withValues(alpha: 0.1) : colors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: isSelected ? colors.primary : colors.border,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      '$grade',
                      style: AppTypography.h2.copyWith(
                        color: isSelected ? colors.primary : colors.textMain,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      t.authGrade(grade),
                      style: AppTypography.bodySm.copyWith(
                        color: isSelected ? colors.primary : colors.textSubtle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.l),
      ],
    );
  }

  Widget _buildUniversitySelection(RegisterFormState formState, AppColorsExtension colors, dynamic t, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.l),
        Center(child: Text(t.authSelectUniversity, style: AppTypography.h3.copyWith(color: colors.textMain))),
        const SizedBox(height: AppSpacing.l),

        // University dropdown
        Text(t.authSelectUniversity, style: AppTypography.label.copyWith(color: colors.textMain)),
        const SizedBox(height: AppSpacing.xs),
        _buildDropdown<String>(
          value: formState.selectedUniversityId,
          hint: t.authSelectUniversity,
          isLoading: formState.isUniversitiesLoading,
          items: formState.universities.map((u) => DropdownMenuItem(value: u.id, child: Text(u.name))).toList(),
          colors: colors,
          onChanged: (v) {
            if (v != null) context.read<RegisterBloc>().add(RegisterUniversitySelected(v));
          },
        ),
        const SizedBox(height: AppSpacing.l),

        // Department dropdown
        Text(t.authSelectDepartment, style: AppTypography.label.copyWith(color: colors.textMain)),
        const SizedBox(height: AppSpacing.xs),
        _buildDropdown<String>(
          value: formState.selectedDepartmentId,
          hint: t.authSelectDepartment,
          isLoading: formState.isDepartmentsLoading,
          items: formState.departments.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name))).toList(),
          colors: colors,
          onChanged: formState.selectedUniversityId != null
              ? (v) { if (v != null) context.read<RegisterBloc>().add(RegisterDepartmentSelected(v)); }
              : null,
        ),
        const SizedBox(height: AppSpacing.l),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required bool isLoading,
    required List<DropdownMenuItem<T>> items,
    required AppColorsExtension colors,
    required ValueChanged<T?>? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 14),
              child: Row(
                children: [
                  SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: colors.primary)),
                  const SizedBox(width: AppSpacing.s),
                  Text(hint, style: AppTypography.bodyMd.copyWith(color: colors.textSubtle.withValues(alpha: 0.5))),
                ],
              ),
            )
          : DropdownButtonFormField<T>(
              initialValue: items.any((item) => item.value == value) ? value : null,
              hint: Text(hint, style: AppTypography.bodyMd.copyWith(color: colors.textSubtle.withValues(alpha: 0.5))),
              items: items,
              onChanged: onChanged,
              dropdownColor: colors.surface,
              style: AppTypography.bodyMd.copyWith(color: colors.textMain),
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: colors.textSubtle),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
                border: InputBorder.none,
              ),
            ),
    );
  }

  Widget _buildGraduateComplete(AppColorsExtension colors, dynamic t) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.xxl),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.success.withValues(alpha: 0.15),
          ),
          child: Icon(Icons.check_circle_outline_rounded, size: 44, color: colors.success),
        ),
        const SizedBox(height: AppSpacing.l),
        Text(t.authStepDetails, style: AppTypography.h3.copyWith(color: colors.textMain)),
        const SizedBox(height: AppSpacing.xs),
        Text(t.authGraduateDesc, style: AppTypography.bodyMd.copyWith(color: colors.textSubtle), textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // REGISTER BOTTOM BAR
  // ---------------------------------------------------------------------------
  Widget _buildRegisterBottomBar(RegisterFormState formState, AppColorsExtension colors, dynamic t, BuildContext context) {
    final isLastStep = formState.currentStep == 2;
    final isFirstStep = formState.currentStep == 0;

    return Container(
      padding: const EdgeInsets.fromLTRB(AppSpacing.l, AppSpacing.s, AppSpacing.l, AppSpacing.s),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (!isFirstStep) ...[
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => context.read<RegisterBloc>().add(const RegisterPreviousStep()),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.textMain,
                      side: BorderSide(color: colors.border),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
                    ),
                    child: Text(t.authBack, style: AppTypography.bodyMd.copyWith(color: colors.textMain, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.s),
            ],
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: formState.isSubmitting
                      ? null
                      : () {
                          if (isLastStep) {
                            context.read<RegisterBloc>().add(const RegisterSubmitted());
                          } else {
                            _emitFormChanged(context);
                            context.read<RegisterBloc>().add(const RegisterNextStep());
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: colors.primary.withValues(alpha: 0.6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
                  ),
                  child: formState.isSubmitting
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white.withValues(alpha: 0.9)),
                        )
                      : Text(
                          isLastStep ? t.authRegisterButton : t.authNext,
                          style: AppTypography.bodyMd.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPERS
  // ---------------------------------------------------------------------------
  void _emitFormChanged(BuildContext context) {
    context.read<RegisterBloc>().add(
          RegisterFormChanged(
            fullName: _fullNameController.text.trim(),
            email: _registerEmailController.text.trim(),
            password: _registerPasswordController.text,
            confirmPassword: _confirmPasswordController.text,
          ),
        );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    required AppColorsExtension colors,
    required ValueChanged<String> onChanged,
    String? error,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.label.copyWith(color: colors.textMain)),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: AppTypography.bodyMd.copyWith(color: colors.textMain),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodyMd.copyWith(color: colors.textSubtle.withValues(alpha: 0.5)),
            prefixIcon: Icon(prefixIcon, color: error != null ? colors.error : colors.textSubtle, size: 22),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: colors.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide(color: colors.border)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide(color: colors.border)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide(color: colors.primary, width: 1.5)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide(color: colors.error)),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide(color: colors.error, width: 1.5)),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(error, style: AppTypography.caption.copyWith(color: colors.error)),
        ],
      ],
    );
  }
}
