import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

import '../../core/theme/app_typography.dart';

class PlayerPage extends StatefulWidget {
  final String videoUrl;
  final String title;

  const PlayerPage({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  BetterPlayerController? _controller;
  String? _errorMessage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.videoUrl,
      );

      final controller = BetterPlayerController(
        const BetterPlayerConfiguration(
          autoPlay: true,
          fit: BoxFit.contain,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableSubtitles: false,
            enableQualities: true,
            enablePip: true,
          ),
        ),
        betterPlayerDataSource: dataSource,
      );

      if (mounted) {
        setState(() {
          _controller = controller;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Lỗi tải video: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.white54,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Lỗi không xác định',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _initPlayer,
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _errorMessage != null
                ? _buildErrorWidget()
                : _controller != null
                    ? AspectRatio(
                        aspectRatio: _controller!.videoPlayerController?.value.aspectRatio ?? 16 / 9,
                        child: BetterPlayer(controller: _controller!),
                      )
                    : _buildErrorWidget(),
      ),
    );
  }
}

