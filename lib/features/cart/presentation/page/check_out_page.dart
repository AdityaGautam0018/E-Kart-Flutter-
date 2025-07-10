import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:ekart/core/widgets/custom_scaffold.dart';
import 'package:ekart/features/cart/presentation/widgets/custom_billing.dart';
import 'package:ekart/features/cart/presentation/widgets/order_tile.dart';
import 'package:ekart/features/home/presentation/Widgets/custom_text_view.dart';
import 'package:ekart/features/home/presentation/pages/full_product_page.dart';
import 'package:ekart/features/main/presentation/pages/main_screen.dart';
import 'package:ekart/features/main/presentation/widget/custom_checkout_button.dart';
import 'package:ekart/features/main/presentation/widget/custom_location_button.dart';
import 'package:ekart/features/order/presentation/cubit/order_cubit.dart';
import 'package:ekart/features/order/presentation/pages/order_page.dart';

import '../bloc/cart_bloc.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final Razorpay _razorpay = Razorpay();

  void _openRazorpayCheckout(int totalAmount) {
    var options = {
      'key': 'rzp_test_IoQ2h8akgWmKnz', // Replace with your Razorpay test key
      'amount': totalAmount * 100, // in paise (INR)
      'name': 'E-Kart',
      'description': 'Order Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Razorpay error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final cartState = context.read<CartBloc>().state;
    if (cartState is CartLoaded) {
      final items = cartState.cartItems;

      context.read<OrderCubit>().addOrder(items);
      context.read<CartBloc>().add(ClearCart());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text("Payment Successful"))),
      );

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MainScreen(initialIndex: 2)));
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL WALLET: ${response.walletName}");
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(title: "Checkout",
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded) {
              final items = state.cartItems;
              final totalPrice = items.entries
                  .map((entry) => entry.key.price * entry.value)
                  .fold<int>(0, (sum, itemTotal) => sum + itemTotal);

              return Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextView(
                    text: "Shipping Address",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  CustomLocationButton(
                    title: "Home",
                    address: "4/14 Block -4, Nehru Nagar(11016)",
                    onTap: () {},
                  ),
                  Divider(height: 1, color: Colors.grey),
                  SizedBox(height: 10),
                  CustomTextView(
                    text: "Orders",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  ...items.entries.map((entry) {
                    final product = entry.key;
                    final quantity = entry.value;
                    return OrderTile(
                      title: product.title,
                      price: product.price * quantity,
                      img: product.images?.first ?? "",
                      countNumber: quantity,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FullProductPage(id: product.id)));
                      },
                    );
                  }),
                  SizedBox(height: 20),
                  CustomBillBoard(
                    price: totalPrice,
                    shippingCost: 12,
                  ),
                  SizedBox(height: 10),
                  CustomCheckOutButton(
                    minWidth: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    title: "Continue to payment",
                    onPress: () {
                      _openRazorpayCheckout(totalPrice + 12);
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text("No items in cart."));
            }
          },
        ),
      ),
    ));
  }
}
