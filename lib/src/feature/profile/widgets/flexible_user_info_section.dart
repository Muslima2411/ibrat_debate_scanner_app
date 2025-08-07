import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/entity/user_model/user_model.dart';

class FlexibleUserInfoSection extends StatelessWidget {
  final bool isLoading;
  final bool isUserLoading;
  final String? error;
  final String? userError;
  final UserModel? user;
  final String displayUsername;
  final VoidCallback? onRetry;
  final VoidCallback? onRefresh;

  const FlexibleUserInfoSection({
    super.key,
    required this.isLoading,
    required this.isUserLoading,
    this.error,
    this.userError,
    this.user,
    required this.displayUsername,
    this.onRetry,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine layout size based on screen width
    final config = _getLayoutConfig(screenWidth);

    return Container(
      constraints: BoxConstraints(
        minHeight: config.minHeight,
        maxHeight: config.maxHeight,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (isLoading || isUserLoading) {
            return _buildLoadingState(context, colors, config);
          }

          final currentError = error ?? userError;
          if (currentError != null) {
            return _buildErrorState(
              context,
              colors,
              textTheme,
              currentError,
              config,
            );
          }

          return _buildUserInfoContent(context, colors, textTheme, config);
        },
      ),
    );
  }

  UserInfoLayoutConfig _getLayoutConfig(double screenWidth) {
    if (screenWidth < 350) {
      // Very small screens
      return const UserInfoLayoutConfig(
        avatarRadius: 28,
        spacing: 12,
        minHeight: 80, // Increased for 2 lines
        maxHeight: 100,
        titleFontSize: 14,
        subtitleFontSize: 12,
        avatarFontSize: 18,
        useCompactLayout: true,
      );
    } else if (screenWidth < 400) {
      // Small screens
      return const UserInfoLayoutConfig(
        avatarRadius: 32,
        spacing: 14,
        minHeight: 90, // Increased for 2 lines
        maxHeight: 110,
        titleFontSize: 16,
        subtitleFontSize: 13,
        avatarFontSize: 20,
        useCompactLayout: false,
      );
    } else {
      // Normal screens
      return UserInfoLayoutConfig(
        avatarRadius: math.min(40.r, 45),
        spacing: 16,
        minHeight: 100, // Increased for 2 lines
        maxHeight: 130,
        titleFontSize: math.min(18.sp, 22),
        subtitleFontSize: math.min(14.sp, 16),
        avatarFontSize: math.min(22.sp, 26),
        useCompactLayout: false,
      );
    }
  }

  Widget _buildLoadingState(
    BuildContext context,
    ColorScheme colors,
    UserInfoLayoutConfig config,
  ) {
    if (config.useCompactLayout) {
      return _buildCompactLoadingState(colors, config);
    }

    return Shimmer.fromColors(
      baseColor: colors.onSurface.withOpacity(0.1),
      highlightColor: colors.onSurface.withOpacity(0.2),
      child: Row(
        children: [
          CircleAvatar(
            radius: config.avatarRadius,
            backgroundColor: colors.primary.withOpacity(0.3),
          ),
          SizedBox(width: config.spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First line shimmer
                Container(
                  width: double.infinity * 0.8,
                  height: config.titleFontSize + 2,
                  decoration: BoxDecoration(
                    color: colors.onSurface.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 6),
                // Second line shimmer
                Container(
                  width: double.infinity * 0.6,
                  height: config.titleFontSize + 2,
                  decoration: BoxDecoration(
                    color: colors.onSurface.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 8),
                // Email/phone shimmer
                Container(
                  width: double.infinity * 0.5,
                  height: config.subtitleFontSize + 2,
                  decoration: BoxDecoration(
                    color: colors.onSurface.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactLoadingState(
    ColorScheme colors,
    UserInfoLayoutConfig config,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: config.avatarRadius,
          backgroundColor: colors.primary.withOpacity(0.3),
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colors.primary,
            ),
          ),
        ),
        SizedBox(width: config.spacing),
        Text(
          'Loading...',
          style: TextStyle(
            fontSize: config.titleFontSize,
            color: colors.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    ColorScheme colors,
    TextTheme textTheme,
    String errorMessage,
    UserInfoLayoutConfig config,
  ) {
    return Container(
      padding: EdgeInsets.all(config.spacing),
      decoration: BoxDecoration(
        color: colors.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: config.useCompactLayout
          ? _buildCompactErrorContent(colors, textTheme, errorMessage, config)
          : _buildNormalErrorContent(colors, textTheme, errorMessage, config),
    );
  }

  Widget _buildCompactErrorContent(
    ColorScheme colors,
    TextTheme textTheme,
    String errorMessage,
    UserInfoLayoutConfig config,
  ) {
    return Row(
      children: [
        Icon(
          Icons.error_outline,
          color: colors.onErrorContainer,
          size: config.titleFontSize + 4,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            errorMessage,
            style: TextStyle(
              color: colors.onErrorContainer,
              fontSize: config.subtitleFontSize,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (onRetry != null)
          TextButton(
            onPressed: onRetry,
            child: Text(
              'Retry',
              style: TextStyle(
                color: colors.onErrorContainer,
                fontSize: config.subtitleFontSize,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNormalErrorContent(
    ColorScheme colors,
    TextTheme textTheme,
    String errorMessage,
    UserInfoLayoutConfig config,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(
              Icons.error_outline,
              color: colors.onErrorContainer,
              size: config.titleFontSize + 4,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                errorMessage,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onErrorContainer,
                  fontSize: config.subtitleFontSize,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (onRetry != null) ...[
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onRetry,
              child: Text(
                'Retry',
                style: TextStyle(
                  color: colors.onErrorContainer,
                  fontSize: config.subtitleFontSize,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildUserInfoContent(
    BuildContext context,
    ColorScheme colors,
    TextTheme textTheme,
    UserInfoLayoutConfig config,
  ) {
    final displayName = displayUsername.isNotEmpty ? displayUsername : 'User';
    final displayEmail = _getDisplayEmail();
    final initials = _getInitials(displayName);

    return config.useCompactLayout
        ? _buildCompactUserInfo(
            colors,
            textTheme,
            displayName,
            initials,
            config,
          )
        : _buildNormalUserInfo(
            colors,
            textTheme,
            displayName,
            displayEmail,
            initials,
            config,
          );
  }

  Widget _buildCompactUserInfo(
    ColorScheme colors,
    TextTheme textTheme,
    String displayName,
    String initials,
    UserInfoLayoutConfig config,
  ) {
    final (topLine, bottomLine) = _arrangeWordsIntoLines(displayName);

    return Row(
      children: [
        _buildAvatar(colors, textTheme, initials, config),
        SizedBox(width: config.spacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top line
              if (topLine.isNotEmpty)
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    topLine,
                    style: TextStyle(
                      fontSize: config.titleFontSize,
                      fontWeight: FontWeight.w500,
                      color: colors.onSurface,
                    ),
                  ),
                ),

              // Bottom line
              if (bottomLine.isNotEmpty) ...[
                SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    bottomLine,
                    style: TextStyle(
                      fontSize: config.titleFontSize - 1,
                      fontWeight: FontWeight.w400,
                      color: colors.onSurface,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNormalUserInfo(
    ColorScheme colors,
    TextTheme textTheme,
    String displayName,
    String displayEmail,
    String initials,
    UserInfoLayoutConfig config,
  ) {
    final (topLine, bottomLine) = _arrangeWordsIntoLines(displayName);

    return Row(
      children: [
        _buildAvatar(colors, textTheme, initials, config),
        SizedBox(width: config.spacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top line of name
              if (topLine.isNotEmpty)
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    topLine,
                    style: TextStyle(
                      fontSize: config.titleFontSize,
                      fontWeight: FontWeight.w500,
                      color: colors.onSurface,
                    ),
                  ),
                ),

              // Bottom line of name
              if (bottomLine.isNotEmpty) ...[
                SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    bottomLine,
                    style: TextStyle(
                      fontSize: config.titleFontSize - 1,
                      fontWeight: FontWeight.w400,
                      color: colors.onSurface,
                    ),
                  ),
                ),
              ],

              // Email/Phone info
              if (displayEmail.isNotEmpty) ...[
                SizedBox(height: 6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    displayEmail,
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.7),
                      fontSize: config.subtitleFontSize,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (onRefresh != null)
          IconButton(
            onPressed: onRefresh,
            icon: Icon(
              Icons.refresh,
              color: colors.primary,
              size: config.titleFontSize + 4,
            ),
          ),
      ],
    );
  }

  /// Arrange words into two lines - trying to balance the content
  (String, String) _arrangeWordsIntoLines(String displayName) {
    final formattedName = _formatDisplayName(displayName);
    final words = formattedName.split(' ');

    if (words.isEmpty) return ('User', '');

    if (words.length == 1) {
      return (words[0], '');
    }

    if (words.length == 2) {
      return (words[0], words[1]);
    }

    if (words.length == 3) {
      // Put 2 words on top, 1 on bottom
      return ('${words[0]} ${words[1]}', words[2]);
    }

    if (words.length == 4) {
      // Perfect split - 2 words each line
      return ('${words[0]} ${words[1]}', '${words[2]} ${words[3]}');
    }

    // For more than 4 words, split roughly in half
    final midpoint = (words.length / 2).ceil();
    final topWords = words.take(midpoint).join(' ');
    final bottomWords = words.skip(midpoint).join(' ');

    return (topWords, bottomWords);
  }

  Widget _buildAvatar(
    ColorScheme colors,
    TextTheme textTheme,
    String initials,
    UserInfoLayoutConfig config,
  ) {
    return CircleAvatar(
      radius: config.avatarRadius,
      backgroundColor: colors.primary,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          initials,
          style: TextStyle(
            color: colors.onPrimary,
            fontSize: config.avatarFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getDisplayEmail() {
    if (user?.name != null && user!.name!.isNotEmpty) {
      return user!.name!;
    }
    if (user?.phone != null && user!.phone!.isNotEmpty) {
      return user!.phone!;
    }
    return '';
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'U';

    final words = name.trim().split(RegExp(r'[\s_]+'));
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, math.min(2, name.length)).toUpperCase();
  }

  String _formatDisplayName(String name) {
    if (name.isEmpty) return 'User';

    // Convert underscores to spaces and capitalize words
    return name
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : word,
        )
        .join(' ');
  }
}

class UserInfoLayoutConfig {
  final double avatarRadius;
  final double spacing;
  final double minHeight;
  final double maxHeight;
  final double titleFontSize;
  final double subtitleFontSize;
  final double avatarFontSize;
  final bool useCompactLayout;

  const UserInfoLayoutConfig({
    required this.avatarRadius,
    required this.spacing,
    required this.minHeight,
    required this.maxHeight,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.avatarFontSize,
    this.useCompactLayout = false,
  });
}
