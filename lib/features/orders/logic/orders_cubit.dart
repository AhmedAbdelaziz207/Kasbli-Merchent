import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersCubit extends Cubit<int> {
  OrdersCubit() : super(0);
  static OrdersCubit create() => OrdersCubit();
}
