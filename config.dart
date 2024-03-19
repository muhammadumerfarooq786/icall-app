class Config {
  static const String appName = "CrimeAlert";
  static const String apiURL = '10.7.104.33:8000'; //PROD_URL
  static const cnicAPI = "/api/users/verifycnic";
  static const emailAPI = "/api/users/verifyemail";
  static const phoneAPI = "/api/users/verifyphone";
  static const registerAPI = "/api/users/register";
  static const userNameAPI = "/api/users/verifyname";
  static const loginAPI = "/api/users/login";
  static const postsAPI = "/api/users/get/posts";
  static const newsAPI = "/api/admin/get/news";
  // static const casesAPI = "/api/police/get/cases";
  static const newPostAPI = "/api/users/add/postfromphone";
}
