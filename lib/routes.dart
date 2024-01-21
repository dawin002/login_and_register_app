import 'package:flutter/material.dart';
import 'package:login_register_app/screens/home_screen.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'utils/common_widgets/invalid_route.dart';
import 'values/app_routes.dart';

class Routes {
  const Routes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Route<dynamic> getRoute({
      required Widget widget,
      bool fullscreenDialog = false,
    }) {
      return MaterialPageRoute<void>(
        builder: (context) => widget,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      );
    }
    // 이 위는 딱히 설명 안하셨던 것 같구요
    // 이 아래는 settings.name으로 어떤 게 들어오면 그 화면을 띄워주는?
    // 그래서 화면 추가해주는 거로 이해했어요!
    switch (settings.name) {
      case AppRoutes.login: // 여기 login 컨트롤+클릭 해서 app_routes.dart 파일 들어가기
        return getRoute(widget: const LoginPage());

      case AppRoutes.register:
        return getRoute(widget: const RegisterPage());

      case AppRoutes.home:  // 여기다가 케이스로 홈페이지 화면 추가하기
        return getRoute(widget: const HomePage());
        // + 에러나면 맨위에 import 문 확인하기(home_screen.dart 임포트 한거)

      /// An invalid route. User shouldn't see this,
      /// it's for debugging purpose only.
      default:
        return getRoute(widget: const InvalidRoute());
    }
  }
}
