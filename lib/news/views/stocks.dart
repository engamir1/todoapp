// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bmi/news/cubit/news_cubit.dart';

class Health extends StatelessWidget {
  const Health({super.key});

  @override
  Widget build(BuildContext context) {
    NewsCubit cubit = BlocProvider.of<NewsCubit>(context);

    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return cubit.healthList.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return ArticleWidget(
                    articleImage: cubit.healthList[index]["urlToImage"] ??
                        "https://media.istockphoto.com/id/1064110466/photo/news-television-studio.jpg?s=2048x2048&w=is&k=20&c=Rjxa-X9pTDsMhjmxFd6QgN6qY64KGAc5rNDhumMVmqE=",
                    atricleTitle: cubit.healthList[index]["title"],
                    publishedAt: cubit.healthList[index]["publishedAt"],
                  );
                },
                itemCount: cubit.healthList.length,
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    Key? key,
    required this.atricleTitle,
    required this.articleImage,
    required this.publishedAt,
  }) : super(key: key);

  final String atricleTitle;
  final String articleImage;
  final String publishedAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(articleImage),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    atricleTitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(publishedAt),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
