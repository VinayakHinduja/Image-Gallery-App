import 'package:equatable/equatable.dart';
import '../models/image_data.dart';

abstract class ImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final List<ImageData> images;

  ImageLoaded(this.images);

  @override
  List<Object> get props => [images];
}

class ImageError extends ImageState {
  final String error;

  ImageError(this.error);

  @override
  List<Object> get props => [error];
}
