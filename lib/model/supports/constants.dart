class Constants {
  static const String appName = "BookStore";

  static const String addressStoreServer = "http://localhost:8081";
  static const String addressAuthenticationServer = "http://localhost:8080";

  static const String realm = "BookStore";
  static const String clientId = "BookStore-API";
  static const String requestLogin = "/realms/$realm/protocol/openid-connect/token";
  static const String requestLogout = "/realms/$realm/protocol/openid-connect/logout";

}