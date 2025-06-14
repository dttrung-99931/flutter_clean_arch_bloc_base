import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_app/core/base_bloc/base_bloc.dart';
import 'package:flutter_base_app/core/base_bloc/base_event.dart';
import 'package:flutter_base_app/core/base_bloc/base_state.dart';
import 'package:flutter_base_app/shared/widgets/loading_widget.dart';

class CustomBlocConsumer<T extends BaseBloc> extends StatefulWidget {
  final List<Type>? buildForStates;
  final bool Function(BaseState state)? buildCondition;
  final List<Type>? listenForStates;
  final BaseEvent? initialEvent;
  final Widget Function(BaseState state) builder;
  final void Function(BaseState state) listener;
  final bool handleLoading;
  final Type loadingStateType;
  final bool isSliver;
  final bool buildForErrorState;
  final T? bloc;

  const CustomBlocConsumer({
    super.key,
    this.buildForStates,
    this.listenForStates,
    required this.builder,
    required this.listener,
    this.loadingStateType = LoadingState,
    this.handleLoading = true,
    this.initialEvent,
    this.isSliver = false,
    this.buildCondition,
    this.buildForErrorState = false,
    this.bloc,
  });

  @override
  State<CustomBlocConsumer<T>> createState() => _CustomBlocConsumerState<T>();
}

class _CustomBlocConsumerState<T extends BaseBloc> extends State<CustomBlocConsumer<T>> {
  late T _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc ?? context.read<T>();
    if (widget.initialEvent != null) {
      _bloc.add(widget.initialEvent!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<T, BaseState>(
      listener: (context, state) {
        widget.listener(state);
      },
      bloc: _bloc,
      // only build when
      buildWhen: (previous, current) {
        bool isOkType = widget.buildForStates != null
            ? [
                if (widget.handleLoading) widget.loadingStateType,
                if (widget.buildForErrorState) ErrorState,
                ...widget.buildForStates!,
              ].contains(current.runtimeType)
            : true;
        bool isOkCondition = widget.buildCondition != null ? widget.buildCondition!(current) : true;
        return isOkType && isOkCondition;
      },
      listenWhen: (previous, current) {
        return widget.listenForStates != null ? widget.listenForStates!.contains(current.runtimeType) : true;
      },
      builder: (context, state) {
        if (widget.handleLoading && state.runtimeType == widget.loadingStateType) {
          return widget.isSliver ? const SliverFillRemaining(child: LoadingWidget()) : const LoadingWidget();
        }
        return widget.builder(state);
        // throw 'State ${state.runtimeType} has been not handled UI';
      },
    );
  }
}
