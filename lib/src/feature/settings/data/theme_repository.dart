import "../../../common/styles/app_theme.dart";
import "theme_datasource.dart";

abstract interface class ThemeRepository {
  Future<AppTheme?> getTheme();

  Future<void> setTheme(AppTheme theme);
}

final class ThemeRepositoryImpl implements ThemeRepository {
  const ThemeRepositoryImpl({required ThemeDataSource themeDataSource})
    : _themeDataSource = themeDataSource;

  final ThemeDataSource _themeDataSource;

  @override
  Future<AppTheme?> getTheme() => _themeDataSource.getTheme();

  @override
  Future<void> setTheme(AppTheme theme) => _themeDataSource.setTheme(theme);
}
