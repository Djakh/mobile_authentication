import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_authentication/localization/localization_delegate.dart';
import 'package:mobile_authentication/repository/user_repository/firebase_repository.dart';
import 'package:mobile_authentication/routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

import 'blocs/authentication_bloc/bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(Provider<FireBaseUserRepository>(
      create: (_) => const FireBaseUserRepository(),
      child: const LoginApp(),
    ));
}

class LoginApp extends StatelessWidget {
  const LoginApp();

  @override
  Widget build(BuildContext context) {
    final repository = context.select((FireBaseUserRepository r) => r);

    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(repository),
      child: MaterialApp(
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        localizationsDelegates: [
          const AppLocalizationDelegate(),
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale.fromSubtags(languageCode: "en"),
          Locale.fromSubtags(languageCode: "it"),
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
