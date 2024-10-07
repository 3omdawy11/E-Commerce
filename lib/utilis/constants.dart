import 'package:flutter/material.dart';

OutlineInputBorder textOutlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30.0), // Circular edges
  borderSide: BorderSide.none, // Remove border outline
);

const EdgeInsets textFieldPadding = EdgeInsets.symmetric(
  vertical: 16.0,
  horizontal: 20.0,
);


final List<Map<String, String>> drawerItems = [
  {'label': 'Profile', 'icon': 'assets/svgs/profile.svg'},
  {'label': 'My Cart', 'icon': 'assets/svgs/shopping_bag.svg'},
  {'label': 'Favorite', 'icon': 'assets/svgs/heart.svg'},
  {'label': 'Orders', 'icon': 'assets/svgs/orders.svg'},
  {'label': 'Notifications', 'icon': 'assets/svgs/notification.svg'},
  {'label': 'Settings', 'icon': 'assets/svgs/settings.svg'},
  {'label': 'Sign out', 'icon': 'assets/svgs/sign_out.svg'},
];
