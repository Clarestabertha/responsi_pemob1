class ApiUrl {
  static const String baseUrl = "http://responsi.webwizards.my.id/api";

  static const String registrasi = baseUrl + '/registrasi'; // URL registrasi
  static const String login = baseUrl + '/login'; // URL login
  static const String listHutang = baseUrl + '/keuangan/hutang_piutang/hutang'; // URL list hutang
  static const String createHutang = baseUrl + '/keuangan/hutang_piutang/hutang'; // URL untuk membuat hutang

  static String updateHutang(int id) {
    return baseUrl + '/keuangan/hutang_piutang/hutang/' + id.toString(); // URL untuk memperbarui hutang
  }

  static String showHutang(int id) {
    return baseUrl + '/keuangan/hutang_piutang/hutang/' + id.toString(); // URL untuk menampilkan hutang
  }

  static String deleteHutang(int id) {
    return baseUrl + '/keuangan/hutang_piutang/hutang/' + id.toString(); // URL untuk menghapus hutang
  }
}
