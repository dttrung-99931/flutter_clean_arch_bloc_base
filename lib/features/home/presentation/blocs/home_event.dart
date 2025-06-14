// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class OnGetAppMode extends BaseEventWithoutProps {}

class OnClearSavedAppMode extends BaseEventWithoutProps {}

class OnChangeAppMode extends BaseEvent {
  final AppMode mode;
  OnChangeAppMode({
    required this.mode,
  });
  @override
  List<Object?> get props => [mode];
}
