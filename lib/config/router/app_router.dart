import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/basic-prompt',
      builder: (context, state) => const BasicPromptScreen(),
    ),
    GoRoute(
      path: '/chat-context',
      builder: (context, state) => const ChatContextScreen(),
    ),
    GoRoute(
      path: '/image-playground',
      builder: (context, state) => const ImagePlaygroundScreen(),
    ),
  ],
);
