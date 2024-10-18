import 'package:ecommerce/manager/user_details/user_details_bloc.dart';
import 'package:ecommerce/utilis/colors.dart';
import 'package:ecommerce/utilis/fonts.dart';
import 'package:ecommerce/utilis/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {
          return Container(
            color: CustomColors.darkerWhite,
            margin: const EdgeInsets.all(28),
            child: Column(
              children: [
                CustomAppBar(
                  screenSize: screenSize,
                  appBarHeading: const Text(
                    'Cart',
                    style: Fonts.paragraph,
                  ),
                  leftIcon: const Icon(CupertinoIcons.back),
                  leftIconAction: () => GoRouter.of(context).pop(),
                ),
                const SizedBox(height: 40),
                if (state is UserLoaded) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CustomColors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Contact Information',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          leading: const Icon(Icons.email_outlined),
                          title: Text(
                            state.email,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('Email'),
                        ),
                        const ListTile(
                          leading: Icon(CupertinoIcons.phone),
                          title: Text(
                            '+20 1015118963',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Phone'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text('Address'),
                        Text(state.location ?? ''),


                      ],
                    ),
                  )
                ] else
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
