import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final user = FirebaseAuth.instance.currentUser;

    final isAuthRoute = route == AppRoutes.login || route == AppRoutes.register;
    final isProtectedRoute = route == AppRoutes.chat;

    if (user != null && isAuthRoute) {
      return const RouteSettings(name: AppRoutes.chat);

    }

    if (user == null && isProtectedRoute) {
      return const RouteSettings(name: AppRoutes.login);

    }

    return null;

  }
}