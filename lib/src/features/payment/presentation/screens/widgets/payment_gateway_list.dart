// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:maingames_flutter_test/src/features/payment/presentation/screens/widgets/payment_gateways.dart';

class PaymentGatewayList extends StatefulWidget {
  const PaymentGatewayList({
    super.key,
    required this.onSelect,
    this.initialSelected,
  });

  final Function(PaymentGateway) onSelect;
  final PaymentGateway? initialSelected;

  @override
  State<PaymentGatewayList> createState() => _PaymentGatewayListState();
}

class _PaymentGatewayListState extends State<PaymentGatewayList> {
  PaymentGateway? _selectedGateway;

  @override
  void initState() {
    _selectedGateway = widget.initialSelected;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PaymentGatewayList oldWidget) {
    if (oldWidget.initialSelected != widget.initialSelected) {
      _selectedGateway = widget.initialSelected;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        for (final gateway in PaymentGateway.values)
          GestureDetector(
            onTap: () {
              widget.onSelect(gateway);
              _selectedGateway = gateway;
              setState(() {});
            },
            child: PaymentItem(
              gateway: gateway,
              isSelected: _selectedGateway == gateway,
            ),
          ),
      ],
    );
  }
}

class PaymentItem extends StatelessWidget {
  const PaymentItem({
    super.key,
    required this.gateway,
    required this.isSelected,
  });

  final PaymentGateway gateway;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.grey : Colors.grey[300]!,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Image.asset(
            gateway.logoAsset,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 10),
          Text(
            gateway.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
