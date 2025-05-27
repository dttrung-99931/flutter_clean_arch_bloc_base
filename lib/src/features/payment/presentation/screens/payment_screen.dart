// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maingames_flutter_test/core/utils/app_colors.dart';
import 'package:maingames_flutter_test/core/utils/extensions/ui_extensions.dart';
import 'package:maingames_flutter_test/src/config/di/injection.dart';
import 'package:maingames_flutter_test/src/config/theme/app_theme.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/screens/login_screen.dart';
import 'package:maingames_flutter_test/src/features/payment/presentation/blocs/payment_bloc.dart';
import 'package:maingames_flutter_test/src/features/payment/presentation/screens/widgets/payment_gateway_list.dart';
import 'package:maingames_flutter_test/src/features/payment/presentation/screens/widgets/payment_gateways.dart';
import 'package:maingames_flutter_test/src/shared/widgets/custom_bloc_listener.dart';

import '../../../../../global.dart';

class PaymentScreen extends StatefulWidget {
  static const route = '/payment';
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentGateway? _selectedGateway;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Payment Page',
            style: textTheme.titleMedium?.withColor(AppColors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider(
            create: (context) => getIt<PaymentBloc>(),
            child: Column(
              children: [
                PaymentGatewayList(
                  onSelect: (gateway) {},
                ),
                const SizedBox(height: 16),
                CustomBlocListener<PaymentBloc>(
                  listener: (state) {
                    // state.maybeWhen(
                    //   paymentSuccessed: (response) {
                    //     context.showSnackMessage('Payment success: ${response.status}');
                    //   },
                    //   paymentFailed: (message) {
                    //     context.showSnackMessage('Payment failed: $message');
                    //   },
                    //   orElse: () {
                    //     context.showSnackMessage('Sth went wrong');
                    //   },
                    // );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: _onPayPressed,
                      child: Text(
                        'Pay',
                        style: textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: CustomBlocListener<LoginBloc>(
                    listener: (state) {
                      if (state is LogoutSuccess && Global.currentRoute != LoginScreen.route) {
                        Global.popAllAndPushNamed(LoginScreen.route);
                      }
                    },
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        context.read<LoginBloc>().add(OnLogout());
                      },
                      child: Text(
                        'Logout',
                        style: textTheme.titleSmall,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPayPressed() {
    if (_selectedGateway == null) {
      // DialogUtils.show('Please select a payment method');
      return;
    }

    // final paymentReq = PaymentRequest(
    //   amount: 50000,
    //   orderId: _generateOrderId(),
    //   currency: 'VND',
    // );
    // _paymentCubit.processPayment(paymentReq, _selectedGateway!);
  }

  static String _generateOrderId() {
    final now = DateTime.now();
    return 'ORDER-${now.millisecondsSinceEpoch}';
  }
}
