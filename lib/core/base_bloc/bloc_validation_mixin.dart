import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/base_bloc/base_event.dart';
import 'package:flutter_base_app/core/base_bloc/base_state.dart';
import 'package:flutter_base_app/core/utils/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BlocValidationMixin on Bloc<BaseEvent, BaseState> {
  bool Function()? _formValidateCallBack;

  void setupOnValidations() {
    on<OnValidateData>(_onValidateData, transformer: BlocConcurrency.sequential());
    on<OnSetFormValidateCallBack>(_onSetFormValidateCallBack);
    on<OnUnsetFormValidateCallBack>(_onUnsetFormValidateCallBack);
  }

  Future<void> _onValidateData(OnValidateData event, Emitter<BaseState> emit) async {
    ValidateDataState validateResult = handleValidate(emit, event);
    emit(validateResult);
  }

  Either<String?, bool> validateMoreData() {
    return const Right(true);
  }

  Future<void> _onSetFormValidateCallBack(OnSetFormValidateCallBack event, Emitter<BaseState> emit) async {
    _formValidateCallBack = event.formValidateCallBack;
  }

  Future<void> _onUnsetFormValidateCallBack(OnUnsetFormValidateCallBack event, Emitter<BaseState> emit) async {
    _formValidateCallBack = null;
  }

  ValidateDataState handleValidate(Emitter<BaseState> emit, OnValidateData event) {
    Either<String?, bool> result = validate();
    bool isValid = false;
    String? message;
    result.fold((l) => message = l, (r) => isValid = true);
    return ValidateDataState(
      isValid,
      showErrorMsg: event.showErrorMsg,
      message: message,
      isValidateToSubmit: event.isValidateToSubmit,
    );
  }

  Either<String?, bool> defaultValidateMoreResult(bool isValid) {
    return isValid ? const Right(true) : const Left(null);
  }

  Either<String?, bool> validate() {
    bool isFormValid = _formValidateCallBack?.call() ?? true;
    Either<String?, bool> validateMoreResult = validateMoreData();
    return validateMoreResult.isRight()
        ? isFormValid
            ? const Right(true)
            : const Left(null) // null -> use default message
        : validateMoreResult; // validateMoreResult containe error validation message
  }

  bool isValid() {
    return validate().isRight();
  }

  @override
  Future<void> close() {
    _formValidateCallBack = null;
    return super.close();
  }
}
