// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsButtonNav extends NewsState {}

class LoadingArticle extends NewsState {}

class SuccessArticle extends NewsState {}

class ErrorArticle extends NewsState {
  final String err;
  ErrorArticle({
    required this.err,
  });
}

class AppChangeModeState extends NewsState {}

class AppChangeDirectionState extends NewsState {}

