import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/domain/providers/localeProvider/locale_provider.dart';
import 'package:news_app/domain/providers/news_provider.dart';
import 'package:news_app/generated/l10n.dart';
import 'package:news_app/ui/loaders/loaders.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'components/home_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NewsProvider>();
    return Scaffold(
      drawer: HomePageMenu(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 72,
        backgroundColor: Colors.blue[200],
        title: model.data?.items != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyBtn(),
                  model.data?.title == null
                      ? AppLoaders.appTitle
                      : Text(
                          model.data!.title!,
                          style: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  SizedBox(
                    width: 32,
                  ),
                ],
              )
            : AppLoaders.appTitle,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const HomePageSlider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Text(
              S.current.bodyTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323232),
              ),
            ),
          ),
          HomePageAllNews(
            model: model,
          ),
        ],
      ),
    );
  }
}

class HomePageMenu extends StatelessWidget {
  const HomePageMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LocaleProvider>();
    final newsmodel = context.watch<NewsProvider>();
    return Drawer(
      width: 120,
      backgroundColor: Colors.blue[200],
      child: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyFloatingBtn(
              langCode: 'ru',
              func: () async {
                final pref = await SharedPreferences.getInstance();
                pref.setString('lang', 'ru');
                model.setLocale(locale: 'ru');
                newsmodel.setUp();
                Scaffold.of(context).closeDrawer();
                // Navigator.of(context).pop();
              },
            ),
            MyFloatingBtn(
              langCode: 'en',
              func: () async {
                final pref = await SharedPreferences.getInstance();
                pref.setString('lang', 'en');
                model.setLocale(locale: 'en');
                newsmodel.setUp();
                Navigator.of(context).pop();
              },
            ),
            MyFloatingBtn(
              langCode: 'uz',
              func: () async {
                final pref = await SharedPreferences.getInstance();
                pref.setString('lang', 'uz');
                model.setLocale(locale: 'uz');
                newsmodel.setUp();
                Navigator.of(context).pop();
              },
            ),
            FloatingActionButton.small(
              onPressed: () {
                exit(0);
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
                size: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyFloatingBtn extends StatelessWidget {
  final String langCode;
  final Function func;
  const MyFloatingBtn({Key? key, required this.func, this.langCode = 'ru'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: Colors.white,
      child: Text(
        langCode.toUpperCase(),
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: () {
        func();
      },
    );
  }
}

class MyBtn extends StatelessWidget {
  const MyBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 1,
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}

class HomePageAllNews extends StatelessWidget {
  final NewsProvider model;
  const HomePageAllNews({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final itemsList = model.data?.items;
    return itemsList != null
        ? ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => AllNewsItem(
              bg: itemsList[index].media!.contents.first.url!,
              text: itemsList[index].title!,
              func: () async {
                launchUrlString('${itemsList[index].link}');
              },
            ),
            // itemBuilder: (context, index) => MyListTile(
            //   bg: itemsList[index].media!.contents.first.url!,
            //   text: itemsList[index].title!,
            // ),
            itemCount: itemsList.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 6,
            ),
          )
        : AppLoaders.nullContainer;
  }
}

class AllNewsItem extends StatelessWidget {
  final String text, bg;
  final Function func;
  const AllNewsItem({
    super.key,
    required this.bg,
    required this.text,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        func();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        // height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const CupertinoActivityIndicator(),
                  imageUrl: bg,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF323232),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  final String text, bg;
  const MyListTile({
    super.key,
    required this.bg,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.maxFinite,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              // color: Colors.black.withOpacity(0.5),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  bg,
                ),
              ),
            ),
            alignment: Alignment.bottomLeft,
          ),
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          // const Text(
          //   'Читать новость',
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: 18,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
        ],
      ),
    );
  }
}
