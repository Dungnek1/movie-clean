import 'package:flutter/material.dart';

/// App localization strings for Vietnamese and English
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en', ''),
    Locale('vi', ''),
  ];

  // Common strings
  String get appName => locale.languageCode == 'vi' ? 'CineStream' : 'CineStream';
  String get home => locale.languageCode == 'vi' ? 'Trang chủ' : 'Home';
  String get search => locale.languageCode == 'vi' ? 'Tìm kiếm' : 'Search';
  String get downloads => locale.languageCode == 'vi' ? 'Tải xuống' : 'Downloads';
  String get profile => locale.languageCode == 'vi' ? 'Hồ sơ' : 'Profile';

  // Search page
  String get searchHint => locale.languageCode == 'vi' ? 'Tìm phim...' : 'Search movies...';
  String get searchPlaceholder => locale.languageCode == 'vi'
      ? 'Nhập từ khóa để tìm phim'
      : 'Enter keywords to search movies';
  String get noResults => locale.languageCode == 'vi' ? 'Không tìm thấy' : 'No results found';
  String get searchError => locale.languageCode == 'vi' ? 'Lỗi tìm kiếm' : 'Search error';

  // Home page
  String get noMovies => locale.languageCode == 'vi' ? 'Chưa có phim' : 'No movies yet';
  String get trending => locale.languageCode == 'vi' ? 'Xu hướng' : 'Trending';
  String get topRated => locale.languageCode == 'vi' ? 'Đánh giá cao' : 'Top Rated';
  String get seeAll => locale.languageCode == 'vi' ? 'Xem tất cả' : 'See all';
  String get play => locale.languageCode == 'vi' ? 'Phát' : 'Play';
  String get moreInfo => locale.languageCode == 'vi' ? 'Thông tin thêm' : 'More info';
  String get loadError => locale.languageCode == 'vi'
      ? 'Lỗi tải danh sách phim'
      : 'Error loading movies';

  // Player page
  String get player => locale.languageCode == 'vi' ? 'Trình phát' : 'Player';
  String get videoUrlMissing => locale.languageCode == 'vi'
      ? 'Thiếu URL video'
      : 'Video URL is missing';
  String get videoLoadError => locale.languageCode == 'vi'
      ? 'Lỗi tải video'
      : 'Error loading video';
  String get videoPlayError => locale.languageCode == 'vi'
      ? 'Lỗi phát video'
      : 'Error playing video';

  // Downloads page
  String get noDownloads => locale.languageCode == 'vi'
      ? 'Chưa có tải xuống'
      : 'No downloads yet';
  String get downloadError => locale.languageCode == 'vi'
      ? 'Lỗi tải xuống'
      : 'Download error';

  // Profile page
  String get settings => locale.languageCode == 'vi' ? 'Cài đặt' : 'Settings';
  String get language => locale.languageCode == 'vi' ? 'Ngôn ngữ' : 'Language';
  String get logout => locale.languageCode == 'vi' ? 'Đăng xuất' : 'Logout';

  // Common actions
  String get retry => locale.languageCode == 'vi' ? 'Thử lại' : 'Retry';
  String get cancel => locale.languageCode == 'vi' ? 'Hủy' : 'Cancel';
  String get ok => locale.languageCode == 'vi' ? 'OK' : 'OK';
  String get close => locale.languageCode == 'vi' ? 'Đóng' : 'Close';
  String get save => locale.languageCode == 'vi' ? 'Lưu' : 'Save';
  String get delete => locale.languageCode == 'vi' ? 'Xóa' : 'Delete';

  // Error messages
  String get networkError => locale.languageCode == 'vi'
      ? 'Lỗi kết nối mạng'
      : 'Network connection error';
  String get unknownError => locale.languageCode == 'vi'
      ? 'Lỗi không xác định'
      : 'Unknown error';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
