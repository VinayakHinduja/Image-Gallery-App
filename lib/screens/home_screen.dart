import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery/const.dart';
import '../bloc/image_bloc.dart';
import '../bloc/image_event.dart';
import '../bloc/image_state.dart';
import 'image_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool isLoadingMore = false;
  int _page = 1;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<ImageBloc>().add(FetchImages(_page));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400) {
      if (!isLoadingMore) {
        _page++;
        context.read<ImageBloc>().add(FetchImages(_page));
      }
    }
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!isLoadingMore) setState(() => isLoadingMore = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageBloc, ImageState>(
      listener: (context, state) {
        if (state is ImageLoaded) {
          setState(() => isLoadingMore = false);
        } else if (state is ImageLoading && _page > 1) {
          setState(() => isLoadingMore = true);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Image Gallery')),
        body: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is ImageLoading && _page == 1) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ImageLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      padding: const EdgeInsets.all(8),
                      cacheExtent: 3000,
                      itemCount: state.images.length,
                      itemBuilder: (context, index) {
                        Color rndColor =
                            randomColors[Random().nextInt(randomColors.length)];
                        if (index == state.images.length) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final image = state.images[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageDetailScreen(
                                    imageUrl: image.imageUrl)),
                          ),
                          child: ClipRRect(
                            key: UniqueKey(),
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: image.imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Container(color: rndColor),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (isLoadingMore)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              );
            } else if (state is ImageError) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
