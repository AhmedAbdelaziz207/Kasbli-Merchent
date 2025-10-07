import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasbli_merchant/core/di/di.dart';
import 'package:kasbli_merchant/core/network/api_service.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final ApiService _apiService = getIt<ApiService>();
  
  CategoriesCubit() : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final response = await _apiService.getCategoriesWithSubCategories();
      
      if (response.status == 200 && response.data != null) {
        if (response.data!.isEmpty) {
          emit(CategoriesEmpty());
        } else {
          emit(CategoriesLoaded(categories: response.data!));
        }
      } else {
        emit(CategoriesFailure(message: response.msg ?? 'Failed to load categories'));
      }
    } catch (e) {
      if (isClosed) return; 
      emit(CategoriesFailure(message: 'Failed to fetch categories: $e'));
    }
  }

  Future<void> refresh() async {
    await fetchCategories();
  }
}
