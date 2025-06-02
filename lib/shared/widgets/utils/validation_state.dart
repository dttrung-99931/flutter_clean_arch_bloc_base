import 'package:maingames_flutter_test/core/base_bloc/base_bloc.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_event.dart';
import 'package:maingames_flutter_test/config/di/injection.dart';
import 'package:flutter/widgets.dart';

abstract class ValidationState<T extends StatefulWidget, Bloc extends BaseBloc> extends State<T> {
  final formKey = GlobalKey<FormState>();
  final bloc = getIt<Bloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(
      OnSetFormValidateCallBack(() {
        return formKey.currentState?.validate() ?? false;
      }),
    );
  }

  @override
  void dispose() {
    bloc.add(OnUnsetFormValidateCallBack());
    super.dispose();
  }
}
