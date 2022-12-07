import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/domain/providers/news_provider.dart';
import 'package:news_app/ui/loaders/loaders.dart';
import 'package:provider/provider.dart';

class HomePageSlider extends StatelessWidget {
  const HomePageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NewsProvider>();
    final itemsList = model.data?.items;
    return itemsList != null
        ? CarouselSlider.builder(
            itemBuilder: (context, index, realIndex) => SliderItem(
              bgPath: itemsList[index].media!.contents.first.url!,
              itemTitle: itemsList[index].title!,
              // index: index,
            ),
            itemCount: itemsList.length,
            options: CarouselOptions(
              viewportFraction: 0.70,
              height: 220,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(
                seconds: 10,
              ),
            ),
          )
        : AppLoaders.carouselSlider;
  }
}

class SliderItem extends StatelessWidget {
  final String bgPath, itemTitle;
  // final int index;
  const SliderItem({
    super.key,
    required this.bgPath,
    required this.itemTitle,
    // required this.text1,
    // required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // final model = context.watch<NewsProvider>();
    return Stack(
      children: [
        Container(
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.grey.shade300,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: CachedNetworkImage(
              // height: 220,
              fit: BoxFit.cover,
              imageUrl: bgPath,
              progressIndicatorBuilder: (context, url, progress) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.maxFinite,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.black.withOpacity(0.5),
          ),
          alignment: Alignment.bottomLeft,
          child: Text(
            itemTitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

//          'https://media.istockphoto.com/id/1322277517/photo/wild-grass-in-the-mountains-at-sunset.jpg?s=612x612&w=0&k=20&c=6mItwwFFGqKNKEAzv0mv6TaxhLN3zSE43bWmFN--J5w=',


//  decoration: const BoxDecoration(
//         color: Colors.red,
//         image: DecorationImage(
//           fit: BoxFit.cover,
//           image: NetworkImage(
//             'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
//           ),
//         ),
//       ),
//       width: double.infinity,
//       height: 240,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(text),
//             Text(text1),
//           ],
//         ),
//       ),