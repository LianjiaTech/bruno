import 'dart:ui' as ui show Codec;
import 'dart:ui';

import 'package:flutter/widgets.dart';

/// 描述: 用于加载gif图，
/// 参考来自github：https://github.com/peng8350/flutter_gifimage
/// 感谢 Jpeng

class GifImage extends StatefulWidget {
  final VoidCallback? onFetchCompleted;
  final AnimationController controller;
  final ImageProvider image;
  final double? width;
  final double? height;
  final Color? color;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final String? semanticLabel;
  final bool excludeFromSemantics;
  final Widget? defaultImage;

  GifImage({
    required this.image,
    required this.controller,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.onFetchCompleted,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.defaultImage,
  });

  @override
  State<StatefulWidget> createState() => GifImageState();
}

class GifImageState extends State<GifImage> {
  ValueNotifier<List<ImageInfo>> _images = ValueNotifier<List<ImageInfo>>([]);
  double _curValue = 0.0;

  @override
  void initState() {
    super.initState();
    fetchGif(widget.image);
    widget.controller.addListener(_listener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (_curValue != widget.controller.value && mounted) {
      setState(() {
        _curValue = widget.controller.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      ///数据发生变化时回调
      builder: (context, value, child) {
        return _buildImage(value as List<ImageInfo>);
      },

      ///监听的数据
      valueListenable: _images,
    );
  }

  Widget _buildImage(List<ImageInfo>? imageInfo) {
    int length = (imageInfo?.length ?? 0);
    int _curIndex = (_curValue * length).toInt();
    int index = -1;
    if (length > 0) {
      index = length == _curIndex ? length - 1 : _curIndex;
    }
    if (index != -1 && imageInfo?[index].image != null) {
      RawImage _image = RawImage(
        image: imageInfo?[index].image,
        width: widget.width,
        height: widget.height,
        scale: imageInfo?[index].scale ?? 1.0,
        color: widget.color,
        colorBlendMode: widget.colorBlendMode,
        fit: widget.fit,
        alignment: widget.alignment,
        repeat: widget.repeat,
        centerSlice: widget.centerSlice,
        matchTextDirection: widget.matchTextDirection,
      );
      if (widget.excludeFromSemantics) {
        return _image;
      } else {
        return Semantics(
          container: widget.semanticLabel != null,
          image: true,
          label: widget.semanticLabel == null ? '' : widget.semanticLabel,
          child: _image,
        );
      }
    }
    return widget.defaultImage ?? Container();
  }

  Future<void> fetchGif(ImageProvider provider) async {
    List<ImageInfo> infos = [];
    if (provider is AssetImage) {
      dynamic data;
      AssetBundleImageKey key = await provider.obtainKey(ImageConfiguration());
      data = await key.bundle.load(key.name);
      ui.Codec codec = await PaintingBinding.instance!
          .instantiateImageCodec(data.buffer.asUint8List());
      for (int i = 0; i < codec.frameCount; i++) {
        FrameInfo frameInfo = await codec.getNextFrame();
        infos.add(ImageInfo(image: frameInfo.image));
      }
    }
    _images.value = infos;
  }
}
