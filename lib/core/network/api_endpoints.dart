class ApiEndPoints {
  // private constructor
  ApiEndPoints._();
  static const baseUrl = "https://kasbli.msarweb.net/";
  //Auth Endpoints
  static const login = "api/auth/vendor/login";
  static const register = "api/auth/vendor/register";
  static const checkPhonesUniques = "api/auth/vendor/check-phones-unique";
  static const verifyResetPassword = "api/auth/vendor/verify_reset_password";
  static const requestPassword = "api/auth/vendor/request_reset_password";
  static const submitResetPassword = "api/auth/vendor/submit_new_password";
  static const logout = "api/auth/vendor/logout";
  static const categoriesWithSub =
      "api/application/kasbli/get-categories-with-sub";
  static const banners = "api/application/kasbli/get-banners";
  static const sections = "api/application/kasbli/get-sections";
  static const productsByCategory =
      "api/application/kasbli/get-products-by-category";
  static const productsBySection =
      "api/application/kasbli/get-products-by-section";
  static const productsBySubCategory =
      "api/application/kasbli/get-products-by-subcategory";
  static const allProducts = "api/application/kasbli/get-all-products";
  static const productBySection =
      "api/application/kasbli/get-products-by-section";
  static const productDetails = "api/application/kasbli/product-details";
  static const sendOTPCode = "api/auth/send-otp";
  static const addToFavorites = "api/application/kasbli/add-to-favourite";
  static const getFavorites = "api/application/kasbli/get-favourites";
  static const cart = "api/application/kasbli/get-carts";
  static const addToCart = "api/application/kasbli/add-to-cart";
  static const removeAllCart = "api/application/kasbli/remove-all-cart";
  static const updateCart = "api/application/kasbli/update-cart";
  static const calculateCustomerPrice =
      "api/application/kasbli/calculate-customer-prices-cart";
  // Profile
  static const editProfile = "api/application/kasbli/edit-profile";
  static const deleteAccount = "api/application/kasbli/delete-account";

  static const paymentHistory = "api/application/kasbli/payment-history";
  static const statistics = "api/application/kasbli/statistics";
  static const updateProfile = "api/application/kasbli/update-profile";
  static const getProfile = "api/application/kasbli/get-profile";
  static const traderProfits = "api/application/kasbli/trader-profits";
  static const staticPages = "api/application/kasbli/static-pages";

  static const updateFcm = "api/application/kasbli/update-fcm";

  static const getNotifications = "api/application/kasbli/get-notifications";
  static const getNotificationsCount =
      "api/application/kasbli/get-count-notifications";

  static const getCartCount = "api/application/kasbli/get-count-cart";

  static const pendingOrders = "api/application/kasbli/Pending-orders";
  static const returnByUser = "api/application/kasbli/return-orders";
  static const failOrders = "api/application/kasbli/fail-orders";
  static const completedOrders = "api/application/kasbli/complete-orders";
  static const orderDetail = "api/application/kasbli/order-details";
  static const returnOrder = "api/application/kasbli/return-order";

  static const getCustomers = "api/application/kasbli/get-customers";
  static const deleteCustomer = "api/application/kasbli/delete-customer";
  static const updateCustomer = "api/application/kasbli/update-customer";
  static const addCustomer = "api/application/kasbli/add-customer";
  static const updateWallet = "api/application/kasbli/update-wallet";
  // Shipping places (governorates with cities and price)
  static const getShippingPlaces = "api/application/kasbli/get-shipping-places";
  static const requestOrder = "api/application/kasbli/order-request";
  static const search = "api/application/kasbli/search";
}
