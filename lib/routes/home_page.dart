import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_authentication/blocs/authentication_bloc.dart';
import 'package:mobile_authentication/blocs/login_bloc.dart';
import 'package:mobile_authentication/repository/user_repository/firebase_repository.dart';
import 'package:mobile_authentication/widgets/login_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  /// Sliding animation to show the welcome page
  void loginTransition() {
    if (tabController.index != 1) {
      tabController.animateTo(1);
    }
  }

  /// Sliding animation to show the login page
  void logoutTransition() {
    if (tabController.index != 0) {
      tabController.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        // This state is emitted on successful authentication
        if (state is AuthenticationSuccess) {
          loginTransition();
        }

        // This state is emitted on logout
        if (state is AuthenticationRevoked) {
          logoutTransition();
        }

        return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            _LoginPage(),
            _WelcomePage(),
          ],
        );
      },
    );
  }
}

class _LoginPage extends StatelessWidget {
  const _LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository =
        context.select((FireBaseUserRepository element) => element);
    final authBloc = context.read<AuthenticationBloc>();
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => CredentialsBloc(
            userRepository: repository, authenticationBloc: authBloc),
        child: Center(child: LoginForm()),
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () =>
                context.read<AuthenticationBloc>().add(LoggedOut()),
          )
        ],
      ),
      body: Center(
        child: Text("welcome"),
      ),
    );
  }
}

