import 'package:go_router/go_router.dart';

import '../../presentation/screens/basic_prompt/basic_prompt_screen.dart';
import '../../presentation/screens/chat_context/chat_context_screen.dart';
import '../../presentation/screens/home/home_screen.dart';

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
  ],
);
