import 'package:dio/dio.dart';
import 'package:kasbli_merchant/features/cart/model/cart_calculation_response.dart';
import 'package:kasbli_merchant/features/cart/model/cart_response.dart';
import 'package:kasbli_merchant/features/cart/model/request_order_response.dart';
import 'package:kasbli_merchant/features/categories/model/category_model.dart';
import 'package:kasbli_merchant/features/login/model/login_response.dart';
import 'package:kasbli_merchant/features/notifications/model/notifications_count_response.dart';
import 'package:kasbli_merchant/features/notifications/model/notifications_respons.dart';
import 'package:kasbli_merchant/features/orders/model/order_detail_response.dart';
import 'package:kasbli_merchant/features/orders/model/order_response.dart';
import 'package:kasbli_merchant/features/product/model/product_details_response.dart';
import 'package:kasbli_merchant/features/product/model/product_model.dart';
import 'package:kasbli_merchant/features/profile/model/customers_details_response.dart';
import 'package:kasbli_merchant/features/customer_information/model/shipping_places_response.dart';
import 'package:kasbli_merchant/features/profile/model/payment_history_response.dart';
import 'package:kasbli_merchant/features/profile/model/static_pages_response.dart';
import 'package:kasbli_merchant/features/profile/model/statistics_response_model.dart';
import 'package:kasbli_merchant/features/profile/model/trader_profit_response.dart';
import 'package:kasbli_merchant/features/register/model/register_response.dart';
import 'package:kasbli_merchant/features/search_screen/search_response.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/register/model/unique_phone_response.dart';
import 'api_endpoints.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiEndPoints.login)
  Future<LoginResponse> login(@Body() Map<String, dynamic> data);

  @POST(ApiEndPoints.logout)
  Future<void> logout();

  @POST(ApiEndPoints.register)
  Future<RegisterResponse> register(@Body() Map<String, dynamic> data);

  @POST(ApiEndPoints.checkPhonesUniques)
  Future<UniquePhoneResponse> checkPhonesUniques(
    @Body() Map<String, dynamic> data,
  );

  @POST(ApiEndPoints.sendOTPCode)
  Future<void> sendOTPCode(@Body() Map<String, dynamic> data);

  @POST(ApiEndPoints.requestPassword)
  Future<void> requestPassword(@Body() Map<String, dynamic> data);

  @POST(ApiEndPoints.verifyResetPassword)
  Future<void> verifyResetPassword(@Body() Map<String, dynamic> data);

  @POST(ApiEndPoints.submitResetPassword)
  Future<void> submitResetPassword(@Body() Map<String, dynamic> data);

  @GET(ApiEndPoints.categoriesWithSub)
  Future<CategoriesResponse> getCategoriesWithSubCategories();

  @GET(ApiEndPoints.allProducts)
  Future<ProductsResponse> getAllProducts({
    @Query("page") int page = 1,
    @Query("min_price") int? minPrice,
    @Query("max_price") int? maxPrice,

    /// name || total_quantity || created_at  || wholesale
    @Query("sort_field") String? sortField,

    /// asc || desc
    @Query("sort_direction") int? sortDirection,
    @Query("with_offer") bool? withOffer,
  });

  @GET(ApiEndPoints.productBySection)
  Future<ProductsResponse> getProductsBySection({
    @Query("section_id") int? sectionId,
    @Query("page") int page = 1,
    @Query("min_price") int? minPrice,
    @Query("max_price") int? maxPrice,

    /// name || total_quantity || created_at  || wholesale
    @Query("sort_field") String? sortField,

    /// asc || desc
    @Query("sort_direction") int? sortDirection,
    @Query("with_offer") bool? withOffer,
  });

  @GET(ApiEndPoints.productsByCategory)
  Future<ProductsResponse> getProductsByCategory({
    @Query("category_id") int? categoryId,
    @Query("page") int page = 1,
    @Query("min_price") int? minPrice,
    @Query("max_price") int? maxPrice,

    /// name || total_quantity || created_at  || wholesale
    @Query("sort_field") String? sortField,

    /// asc || desc
    @Query("sort_direction") int? sortDirection,
    @Query("with_offer") bool? withOffer,
  });

  @GET(ApiEndPoints.productsBySubCategory)
  Future<ProductsResponse> getProductsBySubCategory({
    @Query("sub_category_id") int? subCategoryId,
    @Query("page") int page = 1,
    @Query("min_price") int? minPrice,
    @Query("max_price") int? maxPrice,

    /// name || total_quantity || created_at  || wholesale
    @Query("sort_field") String? sortField,

    /// asc || desc
    @Query("sort_direction") int? sortDirection,
    @Query("with_offer") bool? withOffer,
  });

  @GET(ApiEndPoints.productDetails)
  Future<ProductDetailsResponse> getProductDetails(@Query("product_id") int id);

  @POST(ApiEndPoints.addToFavorites)
  Future<void> addToFavorites(@Body() Map<String, dynamic> data);

  @GET(ApiEndPoints.getFavorites)
  Future<ProductsResponse> getFavorites();

  @GET(ApiEndPoints.cart)
  Future<CartResponse> getCart();

  @GET(ApiEndPoints.paymentHistory)
  Future<PaymentHistoryResponse> getPaymentHistory();

  @GET(ApiEndPoints.statistics)
  Future<StatisticsResponseModel> getStatistics();

  @GET(ApiEndPoints.traderProfits)
  Future<TraderProfitResponse> getTraderProfit();

  @POST(ApiEndPoints.deleteAccount)
  Future<void> deleteAccount();

  @POST(ApiEndPoints.updateProfile)
  Future<void> updateProfile(@Body() FormData data);

  @GET(ApiEndPoints.getProfile)
  Future<LoginResponse> getProfile();

  @POST(ApiEndPoints.updateWallet)
  Future<void> updateWallet(@Body() FormData data);
  @GET(ApiEndPoints.staticPages)
  Future<StaticPagesResponse> getStaticPages();

  @POST(ApiEndPoints.updateFcm)
  Future<void> updateFcm(@Body() FormData data);

  @GET(ApiEndPoints.getNotifications)
  Future<NotificationsResponse> getNotifications();

  @GET(ApiEndPoints.getNotificationsCount)
  Future<NotificationsCountResponse> getNotificationsCount();

  @GET(ApiEndPoints.getCartCount)
  Future<NotificationsCountResponse> getCartCount();

  /// Body ex -> {"product_id": 1, "quantity": 1, "product_variation_id"}
  @POST(ApiEndPoints.addToCart)
  Future<void> addToCart(@Body() Map<String, dynamic> data);

  @POST(ApiEndPoints.removeAllCart)
  Future<void> removeAllCart();

  /// Body ex -> {"product_id": 1, "quantity": 1, "product_variation_id"}
  @POST(ApiEndPoints.updateCart)
  Future<void> updateCart(@Body() FormData data);

  /// Body ex -> {"shipping_cost": 1, "shipping_paid_by_trader": 1, "coupon_code" : "3C33", "items" : "[{"product_id": 1, "quantity": 1, "product_variation_id"}]"}
  @POST(ApiEndPoints.calculateCustomerPrice)
  Future<CartCalculationResponse> calculateCustomerPrice(@Body() FormData data);

  @GET(ApiEndPoints.pendingOrders)
  Future<OrderResponse> getPendingOrders();

  @GET(ApiEndPoints.returnByUser)
  Future<OrderResponse> getReturnByUser();

  @GET(ApiEndPoints.failOrders)
  Future<OrderResponse> getFailOrders();

  @GET(ApiEndPoints.completedOrders)
  Future<OrderResponse> getCompletedOrders();

  @GET(ApiEndPoints.orderDetail)
  Future<OrderDetailResponse> getOrderDetails(@Query("order_id") int orderId);

  /// Return/cancel an order by ID
  @POST(ApiEndPoints.returnOrder)
  Future<void> returnOrder(@Body() FormData orderId);

  // Customers
  @GET(ApiEndPoints.getCustomers)
  Future<CustomersDetailsResponse> getCustomers();

  @POST(ApiEndPoints.deleteCustomer)
  Future<void> deleteCustomer(@Body() FormData data);

  @POST(ApiEndPoints.updateCustomer)
  Future<void> updateCustomer(@Body() FormData data);

  @POST(ApiEndPoints.addCustomer)
  Future<void> addCustomer(@Body() FormData data);

  @GET(ApiEndPoints.getShippingPlaces)
  Future<ShippingPlacesResponse> getShippingPlaces();

  @POST(ApiEndPoints.requestOrder)
  Future<RequestOrderResponse> requestOrder(@Body() FormData data);

  @GET(ApiEndPoints.search)
  Future<SearchResponse> search(@Query("search") String search);
}

