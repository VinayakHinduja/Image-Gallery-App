import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/image_epository.dart';
import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository repository;

  ImageBloc(this.repository) : super(ImageLoading()) {
    on<FetchImages>((event, emit) async {
      try {
        final newImages = await repository.fetchImages(event.page, 20);

        if (state is ImageLoaded) {
          final allImages = List.of((state as ImageLoaded).images)
            ..addAll(newImages);
          emit(ImageLoaded(allImages));
        } else {
          emit(ImageLoaded(newImages));
        }
      } catch (e) {
        emit(ImageError(e.toString()));
      }
    });
  }
}
