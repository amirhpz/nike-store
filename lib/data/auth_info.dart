class AuthInfo {
  final String email;
  final String accessToken;
  final String refreshToken;

  AuthInfo(this.accessToken, this.refreshToken, this.email);
}
