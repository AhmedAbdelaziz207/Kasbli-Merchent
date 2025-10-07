import 'package:flutter/material.dart';
import 'package:kasbli_merchant/features/categories/model/category_model.dart';

@immutable
sealed class CategoriesState {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

class CategoriesEmpty extends CategoriesState {
  const CategoriesEmpty();
}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryModel> categories;

  const CategoriesLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoriesFailure extends CategoriesState {
  final String message;

  const CategoriesFailure({required this.message});

  @override
  List<Object> get props => [message];
}
