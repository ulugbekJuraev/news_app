import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/domain/providers/localeProvider/locale_provider.dart';
import 'package:news_app/domain/providers/news_provider.dart';
import 'package:news_app/generated/l10n.dart';
import 'package:news_app/l10n/l10n.dart';
import 'package:news_app/ui/home_page.dart';
import 'package:provider/provider.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
 
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsProvider>(
            create: (context) => NewsProvider()),
        ChangeNotifierProvider<LocaleProvider>(
            create: (context) => LocaleProvider()),
      ],
      child: NewsAppContent(),
    );
  }
}

class NewsAppContent extends StatelessWidget {
  
  const NewsAppContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final localProvider = context.watch<LocaleProvider>();
    return MaterialApp(
      
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10N.all,
      locale: localProvider.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
