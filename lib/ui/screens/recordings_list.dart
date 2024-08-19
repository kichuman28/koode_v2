import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../models/audio_recording.dart';
import 'package:just_audio/just_audio.dart';

class RecordingsListPage extends StatefulWidget {
  const RecordingsListPage({super.key});

  @override
  RecordingsListPageState createState() => RecordingsListPageState();
}

class RecordingsListPageState extends State<RecordingsListPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  AudioRecording? _currentRecording;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isSelectionMode = false;
  final Set<int> _selectedIndices = {};

  @override
  void initState() {
    super.initState();
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _totalDuration = duration ?? Duration.zero;
      });
    });

    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Box<AudioRecording> recordingsBox = Hive.box<AudioRecording>('recordings');

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Recordings"),
        actions: _isSelectionMode
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: _deleteSelectedRecordings,
                ),
              ]
            : null,
      ),
      body: _buildRecordingsList(recordingsBox),
    );
  }

  Widget _buildRecordingsList(Box<AudioRecording> recordingsBox) {
    return ValueListenableBuilder(
      valueListenable: recordingsBox.listenable(),
      builder: (context, Box<AudioRecording> box, _) {
        if (box.values.isEmpty) {
          return const Center(child: Text("No recordings available"));
        } else {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final recording = box.getAt(index);
              return ListTile(
                title: Text(recording!.name),
                subtitle: Text("${recording.date} - ${recording.duration}"),
                onLongPress: () {
                  setState(() {
                    _isSelectionMode = true;
                    _selectedIndices.add(index);
                  });
                },
                onTap: () async {
                  if (_isSelectionMode) {
                    setState(() {
                      if (_selectedIndices.contains(index)) {
                        _selectedIndices.remove(index);
                        if (_selectedIndices.isEmpty) {
                          _isSelectionMode = false;
                        }
                      } else {
                        _selectedIndices.add(index);
                      }
                    });
                  } else {
                    await _playRecording(recording);
                  }
                },
                selected: _selectedIndices.contains(index),
                trailing: _isSelectionMode
                    ? null
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _renameRecording(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteRecording(index),
                          ),
                        ],
                      ),
              );
            },
          );
        }
      },
    );
  }

  Future<void> _renameRecording(int index) async {
    final recordingsBox = Hive.box<AudioRecording>('recordings');
    final recording = recordingsBox.getAt(index);

    final TextEditingController controller = TextEditingController(text: recording?.name);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rename Recording'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'New name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  recordingsBox.putAt(
                    index,
                    AudioRecording(
                      name: controller.text,
                      date: recording!.date,
                      duration: recording.duration,
                      path: recording.path,
                    ),
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteRecording(int index) async {
    final recordingsBox = Hive.box<AudioRecording>('recordings');
    recordingsBox.deleteAt(index);
  }

  Future<void> _deleteSelectedRecordings() async {
    final recordingsBox = Hive.box<AudioRecording>('recordings');
    final sortedIndices = _selectedIndices.toList()..sort((a, b) => b.compareTo(a));

    for (var index in sortedIndices) {
      recordingsBox.deleteAt(index);
    }

    setState(() {
      _isSelectionMode = false;
      _selectedIndices.clear();
    });
  }

  Future<void> _playRecording(AudioRecording recording) async {
    await _audioPlayer.setFilePath(recording.path);
    setState(() {
      _currentRecording = recording;
      _totalDuration = _audioPlayer.duration ?? Duration.zero;
    });

    if (!mounted) return;

    // Show the dialog with the player controls
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            _audioPlayer.positionStream.listen((position) {
              setState(() {
                _currentPosition = position;
              });
            });

            _audioPlayer.playerStateStream.listen((state) {
              setState(() {
                _isPlaying = state.playing;
              });
            });

            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _currentRecording?.name ?? "Unknown",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  _buildPlayerControls(setState),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _audioPlayer.stop();
                      setState(() {
                        _currentPosition = Duration.zero;
                        _isPlaying = false;
                      });
                    },
                    child: const Text("Close"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    _audioPlayer.play();
  }

  Widget _buildPlayerControls(void Function(void Function()) setState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          min: 0.0,
          max: _totalDuration.inMilliseconds.toDouble(),
          value: _currentPosition.inMilliseconds.clamp(0, _totalDuration.inMilliseconds).toDouble(),
          onChanged: (value) async {
            final position = Duration(milliseconds: value.toInt());
            await _audioPlayer.seek(position);
            setState(() {
              _currentPosition = position;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                if (_isPlaying) {
                  _audioPlayer.pause();
                } else {
                  _audioPlayer.play();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () {
                _audioPlayer.stop();
                setState(() {
                  _currentPosition = Duration.zero;
                  _isPlaying = false;
                });
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(_currentPosition)),
              Text(_formatDuration(_totalDuration - _currentPosition)),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
