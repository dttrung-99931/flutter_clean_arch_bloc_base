// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'home_bloc.dart';

class GetAppModeSuccess extends FullDataLoadedState<AppMode> {
  GetAppModeSuccess(super.data);
}

class ChangeAppModeSuccess extends GetAppModeSuccess {
  ChangeAppModeSuccess(super.data);
}
