// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evievm_app/core/base_bloc/base_bloc.dart';
import 'package:evievm_app/core/base_bloc/base_event.dart';
import 'package:evievm_app/core/base_bloc/base_state.dart';
import 'package:evievm_app/src/config/di/injection.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

HomeBloc get homeBloc => getIt<HomeBloc>();

@lazySingleton
class HomeBloc extends BaseBloc {
  HomeBloc() : super(InitialState()) {}
}
