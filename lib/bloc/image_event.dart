import 'package:equatable/equatable.dart';

abstract class ImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchImages extends ImageEvent {
  final int page;

  FetchImages(this.page);

  @override
  List<Object> get props => [page];
}
