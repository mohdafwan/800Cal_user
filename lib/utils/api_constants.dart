class ApiConstants {
  //static String baseUrl = "https://800cal-backend.vercel.app";
  // static String baseUrl =
  //     "https://800cal-backend-git-v2-mrudulkolambe.vercel.app";
  static String baseUrl = "https://800cal-backend.vercel.app";
  static String login = "$baseUrl/customer/signin";
  static String register = "$baseUrl/customer/signup";
  static String profile = "$baseUrl/customer/profile";
  static String updateProfile = "$baseUrl/customer/update";
  static String allRestaurant = "$baseUrl/restaurant/all";
  static String checkUserExists = "$baseUrl/customer/email-registred";
  static String restaurantDetails = "$baseUrl/restaurant/profile/";
  // static String groupRestaurant = "$baseUrl/restaurant/group";
  static String groupRestaurant = "$baseUrl/meal-application/meal/";
  static String program = "$baseUrl/program";
  // static String meals = "$baseUrl/meal/";
  static String meals = "$baseUrl/meal/program/";
  static String ingredients = "$baseUrl/ingredients/";
  static String fetchTransaction = "$baseUrl/customer-transaction/customer";
  static String createTransaction = "$baseUrl/customer-transaction/create";
  static String discount = "$baseUrl/discount/apply-coupon";
  static String createOrder = "$baseUrl/order/create";
  static String fetchOrder = "$baseUrl/order/user";
  static String updateOrder = "$baseUrl/order/user/";
  static String createCalendar = "$baseUrl/calendar/create";
  static String food = "$baseUrl/food/";
  static String updateCalendar = "$baseUrl/calendar/update/";
  static String forgetPassword = "$baseUrl/customer/forget-password";
  static String adminDetails = '$baseUrl/admin/details';
  static String authentication =
      'https://yashdev19.pythonanywhere.com/authentication';
  static String otp = 'https://www.kwtsms.com/API/send/';
  static String restaurantTransactionCreate =
      '$baseUrl/restaurant-transaction/create';
  static String restaurantAmount = '$baseUrl/meal-application/restaurant/';
  static String deleteProfile = '$baseUrl/customer/delete-account';
}
