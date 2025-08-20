// lib/widgets/loading_button.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class LoadingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? loadingColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isDisabled;
  final BoxShadow? shadow;
  final BorderSide? borderSide;

  const LoadingButton({
    Key? key,
    required this.onPressed,
    required this.isLoading,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.loadingColor,
    this.width,
    this.height,
    this.borderRadius = 12.0,
    this.padding,
    this.isDisabled = false,
    this.shadow,
    this.borderSide,
  }) : super(key: key);

  // Primary button style
  LoadingButton.primary({
    Key? key,
    required VoidCallback onPressed,
    required bool isLoading,
    required Widget child,
    double borderRadius = 12.0,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    bool isDisabled = false,
  }) : this(
          key: key,
          onPressed: onPressed,
          isLoading: isLoading,
          child: child,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          loadingColor: Colors.white,
          borderRadius: borderRadius,
          width: width,
          height: height,
          padding: padding,
          isDisabled: isDisabled,
          shadow: BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        );

  // Secondary button style
  LoadingButton.secondary({
    Key? key,
    required VoidCallback onPressed,
    required bool isLoading,
    required Widget child,
    double borderRadius = 12.0,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    bool isDisabled = false,
  }) : this(
          key: key,
          onPressed: onPressed,
          isLoading: isLoading,
          child: child,
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primary,
          loadingColor: AppColors.primary,
          borderRadius: borderRadius,
          width: width,
          height: height,
          padding: padding,
          isDisabled: isDisabled,
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2.0,
          ),
        );

  // Accent button style
  LoadingButton.accent({
    Key? key,
    required VoidCallback onPressed,
    required bool isLoading,
    required Widget child,
    double borderRadius = 12.0,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    bool isDisabled = false,
  }) : this(
          key: key,
          onPressed: onPressed,
          isLoading: isLoading,
          child: child,
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          loadingColor: Colors.white,
          borderRadius: borderRadius,
          width: width,
          height: height,
          padding: padding,
          isDisabled: isDisabled,
          shadow: BoxShadow(
            color: AppColors.accent.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        );

  // Outline button style
  LoadingButton.outline({
    Key? key,
    required VoidCallback onPressed,
    required bool isLoading,
    required Widget child,
    Color borderColor = AppColors.primary,
    double borderRadius = 12.0,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    bool isDisabled = false,
  }) : this(
          key: key,
          onPressed: onPressed,
          isLoading: isLoading,
          child: child,
          backgroundColor: Colors.transparent,
          foregroundColor: borderColor,
          loadingColor: borderColor,
          borderRadius: borderRadius,
          width: width,
          height: height,
          padding: padding,
          isDisabled: isDisabled,
          borderSide: BorderSide(
            color: borderColor,
            width: 2.0,
          ),
        );

  // Success button style
  LoadingButton.success({
    Key? key,
    required VoidCallback onPressed,
    required bool isLoading,
    required Widget child,
    double borderRadius = 12.0,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    bool isDisabled = false,
  }) : this(
          key: key,
          onPressed: onPressed,
          isLoading: isLoading,
          child: child,
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
          loadingColor: Colors.white,
          borderRadius: borderRadius,
          width: width,
          height: height,
          padding: padding,
          isDisabled: isDisabled,
          shadow: BoxShadow(
            color: AppColors.success.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        );

  // Error button style
  LoadingButton.error({
    Key? key,
    required VoidCallback onPressed,
    required bool isLoading,
    required Widget child,
    double borderRadius = 12.0,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    bool isDisabled = false,
  }) : this(
          key: key,
          onPressed: onPressed,
          isLoading: isLoading,
          child: child,
          backgroundColor: AppColors.error,
          foregroundColor: Colors.white,
          loadingColor: Colors.white,
          borderRadius: borderRadius,
          width: width,
          height: height,
          padding: padding,
          isDisabled: isDisabled,
          shadow: BoxShadow(
            color: AppColors.error.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        );

  @override
  Widget build(BuildContext context) {
    final bool isButtonDisabled = isDisabled || isLoading;
    final Color effectiveBackgroundColor = isButtonDisabled
        ? (backgroundColor ?? AppColors.primary).withOpacity(0.5)
        : backgroundColor ?? AppColors.primary;

    final Color effectiveForegroundColor = isButtonDisabled
        ? (foregroundColor ?? Colors.white).withOpacity(0.7)
        : foregroundColor ?? Colors.white;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: isButtonDisabled ? null : [shadow ?? _defaultShadow()],
      ),
      child: ElevatedButton(
        onPressed: isButtonDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderSide ?? BorderSide.none,
          ),
          elevation: 0,
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          disabledBackgroundColor: effectiveBackgroundColor,
          disabledForegroundColor: effectiveForegroundColor,
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: loadingColor ?? effectiveForegroundColor,
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    loadingColor ?? effectiveForegroundColor,
                  ),
                ),
              )
            : child,
      ),
    );
  }

  BoxShadow _defaultShadow() {
    return BoxShadow(
      color: AppColors.primary.withOpacity(0.3),
      blurRadius: 10,
      offset: const Offset(0, 4),
    );
  }

  // Small button variant
  LoadingButton.small({
    Key? key,
    required VoidCallback onPressed,
    required bool isLoading,
    required Widget child,
    Color? backgroundColor,
    Color? foregroundColor,
    double borderRadius = 8.0,
    bool isDisabled = false,
  }) : this(
          key: key,
          onPressed: onPressed,
          isLoading: isLoading,
          child: child,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          borderRadius: borderRadius,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          isDisabled: isDisabled,
        );

  // Large button variant
  LoadingButton.large({
    Key? key,
    required VoidCallback onPressed,
    required bool isLoading,
    required Widget child,
    Color? backgroundColor,
    Color? foregroundColor,
    double borderRadius = 16.0,
    bool isDisabled = false,
  }) : this(
          key: key,
          onPressed: onPressed,
          isLoading: isLoading,
          child: child,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          borderRadius: borderRadius,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
          isDisabled: isDisabled,
        );

  // Full width button
  LoadingButton.fullWidth({
    Key? key,
    required VoidCallback onPressed,
    required bool isLoading,
    required Widget child,
    Color? backgroundColor,
    Color? foregroundColor,
    double borderRadius = 12.0,
    double height = 56.0,
    bool isDisabled = false,
  }) : this(
          key: key,
          onPressed: onPressed,
          isLoading: isLoading,
          child: child,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          width: double.infinity,
          height: height,
          borderRadius: borderRadius,
          isDisabled: isDisabled,
        );
}