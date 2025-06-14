import 'package:flutter_base_app/core/base_bloc/base_bloc.dart';
import 'package:flutter_base_app/core/base_bloc/base_state.dart';
import 'package:flutter_base_app/core/utils/evm_colors.dart';
import 'package:flutter_base_app/config/di/injection.dart';
import 'package:flutter_base_app/config/theme/app_theme.dart';
import 'package:flutter_base_app/shared/widgets/info_input.dart';
import 'package:flutter_base_app/shared/widgets/custom_bloc_builder.dart';
import 'package:flutter_base_app/shared/widgets/custom_drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownInput<TDto, TId, TState extends ListLoadedState<TDto, TId>, TBloc extends BaseBloc>
    extends StatefulWidget {
  CustomDropdownInput({
    super.key,
    required this.title,
    required this.onSelected,
    this.isEditMode = true,
    this.showTopDivider = false,
    this.isRequired = false,
    this.hintColor = EVMColors.blackLight,
    this.hasRightSpace = false,
    this.inputWidth,
    this.paddingRight = 16,
    this.enabled = true,
    required this.nameGetter,
    this.titleFlex = 10,
    this.buildCondition,
    this.direction = Axis.horizontal,
    this.titleFontWeight = FontWeight.normal,
    TBloc? bloc,
    double? height,
  })  : bloc = bloc ?? getIt(),
        height = height ?? 56.h;

  final bool isEditMode;
  final bool isRequired;
  final bool showTopDivider;
  final Color hintColor;
  final String title;
  final bool hasRightSpace;
  final double? inputWidth;
  final double paddingRight;
  final bool enabled;
  final Function(TDto selected) onSelected;
  final String Function(TDto selected) nameGetter;
  final TBloc bloc;
  final int titleFlex;
  final bool Function(BaseState staet)? buildCondition;
  final double height;
  final Axis direction;
  final FontWeight titleFontWeight;

  @override
  State<CustomDropdownInput> createState() => _CustomDropdownInputState<TDto, TId, TState, TBloc>();
}

class _CustomDropdownInputState<TDto, TId, TState extends ListLoadedState<TDto, TId>, TBloc extends BaseBloc>
    extends State<CustomDropdownInput<TDto, TId, TState, TBloc>> {
  @override
  Widget build(BuildContext context) {
    return InfoInput(
      direction: widget.direction,
      titleStyle: textTheme.bodyMedium!.copyWith(fontWeight: widget.titleFontWeight),
      paddingLeft: 0,
      titleFlex: widget.titleFlex,
      inputWidth: widget.inputWidth,
      hasRightSpace: widget.hasRightSpace,
      showTopDivider: widget.showTopDivider,
      isEditable: widget.isEditMode,
      title: widget.title,
      showRequiredLabel: widget.isRequired,
      // bottomText: (_isValidated & widget.isRequired)
      //     ? Validate.validateRequiredCondition(
      //         addressMixin.selectedProvOrCity.code != Constatnts.codeEmpty,
      //         fieldName: widget.title,
      //       )
      //     : null,
      bottomTextType: TextType.error,
      customInput: CustomBlocBuilder<TBloc>(
        bloc: widget.bloc,
        buildForStates: [TState],
        buildCondition: widget.buildCondition,
        loadingStateType: LoadingState<TState>,
        handleLoading: false,
        builder: (state) {
          if (state is! TState) {
            return const SizedBox.shrink();
          }
          // ** Note: Validate will cause build recursely
          // if (state.isValid) {
          //   doOnBuildUICompleted(() {
          //     _validate(true);
          //   });
          // }
          return CustomDropdownButton<TDto>(
            height: widget.height,
            enabled: widget.enabled,
            selectedItem: state.selected,
            onSelected: (TDto? field) {
              if (field == null) {
                return;
              }
              widget.onSelected(field);
              // ** Note: Validate will cause build recursely
              // doOnBuildUICompleted(() {
              //   _validate(true);
              // });
            },
            dataItems: state.data,
            itemBuilder: (item) {
              return Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget.nameGetter(item),
                  style: textTheme.bodyMedium?.copyWith(color: state.isValid ? widget.hintColor : EVMColors.blackLight),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
