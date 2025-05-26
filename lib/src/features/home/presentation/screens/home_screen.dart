import 'package:evievm_app/core/ui/auto_reset_bloc_state.dart';
import 'package:evievm_app/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:evievm_app/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends AutoResetBlocState<HomeScreen, HomeBloc> {
  final _pageStorageBucket = PageStorageBucket();

  @override
  void initState() {
    loginBloc.add(OnDoCheckLogin(
      onDidLogin: () {},
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: PageStorage(
        bucket: _pageStorageBucket,
        child: RefreshIndicator(
          displacement: 20,
          onRefresh: () async {
            homeBloc.add(OnGetHomeBanners());
            homeBloc.add(OnGetHomeProductCates());
            homeBloc.add(OnGetHomeProducts());
            loginBloc.add(OnDoCheckLogin(
              onDidLogin: () {},
            ));
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: widget.scrollController,
            slivers: const [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                sliver: SliverToBoxAdapter(child: Center(child: Text('Product'))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
