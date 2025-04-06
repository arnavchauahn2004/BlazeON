import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class UnderstandingFireBehaviorPage extends StatefulWidget {
  const UnderstandingFireBehaviorPage({super.key});

  @override
  _UnderstandingFireBehaviorPageState createState() =>
      _UnderstandingFireBehaviorPageState();
}

class _UnderstandingFireBehaviorPageState
    extends State<UnderstandingFireBehaviorPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        ), // Replace with your video URL
      )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Understanding Fire Behavior'),
        backgroundColor: const Color(0xFFF5ECCE),
        foregroundColor: const Color(0xFF8B0000),
      ),
      backgroundColor: const Color(0xFFF5ECCE),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _controller.value.isInitialized
                        ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                        : Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Remaining: ${_formatDuration(_controller.value.duration - _controller.value.position)}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B0000),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                            });
                          },
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Transcript',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B0000),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('''
                  [Video starts]
                  Narrator: This is a video about understanding fire behavior.
                  [Video shows a fire burning]
                  Narrator: Fire is a chemical reaction that releases heat and light.
                  [Video shows different types of fires]
                  Narrator: Fire can be dangerous, but it can also be useful.
                  [Video ends]
                  ''', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
