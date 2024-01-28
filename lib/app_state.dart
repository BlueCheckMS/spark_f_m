import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'song_list_page/song_list_page_widget.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {}

  Future<void> audioMetaList({
    DocumentReference? song,
    DocumentReference? podcast,
    DocumentReference? album,
    DocumentReference? playlist,
    String? artist,
    List<DocumentReference>? episodes,
    List<DocumentReference>? songs,
    int? index,
    bool? live,
  }) async {
    if (live != null) {
      isLive = live;
      notifyListeners();
    }

    if (live == false) {
      if (audioPlayer.playing) {
        await audioPlayer.stop();
        AudioPlayerMeta.clear();
      }
      if (playlist != null) {
        for (var song in songs!) {
          DocumentSnapshot? songSnapshot = await song.get();
          Map<String, dynamic>? songData =
              songSnapshot.data() as Map<String, dynamic>;
          String title = songData['song_name'];
          String image = songData['song_image'];
          String audio = songData['song_audioFile'];
          String artist = songData['song_Artist'];

          AudioPlayerMeta.add(AudioSource.uri(Uri.parse(audio),
              tag: MediaItem(
                id: '$index',
                title: title,
                artUri: Uri.parse(image),
                artist: artist,
              )));
        }

        audioPlayer.setAudioSource(AudioPlayerMeta,
            initialIndex: 0, initialPosition: Duration.zero);
        notifyListeners();
      } else if (album != null) {
        DocumentSnapshot? albumSnapshot = await album.get();
        Map<String, dynamic>? albumData =
            albumSnapshot.data() as Map<String, dynamic>;
        String albumCover = albumData['album_cover'];
        String albumTitle = albumData['AlbumTitle'];
        for (var song in songs!) {
          DocumentSnapshot? songSnapshot = await song.get();
          Map<String, dynamic>? songData =
              songSnapshot.data() as Map<String, dynamic>;
          String title = songData['song_name'];
          String audio = songData['song_audioFile'];
          String artist = songData['song_Artist'];

          AudioPlayerMeta.add(
            AudioSource.uri(Uri.parse(audio),
                tag: MediaItem(
                    id: '$index',
                    title: title,
                    artUri: Uri.parse(albumCover),
                    artist: artist,
                    album: albumTitle)),
          );
        }

        audioPlayer.setAudioSource(AudioPlayerMeta,
            initialIndex: 0, initialPosition: Duration.zero);
        notifyListeners();
      } else if (podcast != null) {
        AudioPlayerMeta.clear();
        if (audioPlayer.playing) {
          await audioPlayer.stop();
        }

        DocumentSnapshot? podcastSnapshot = await podcast.get();
        Map<String, dynamic>? podcastData =
            podcastSnapshot.data() as Map<String, dynamic>;
        String podcastCover = podcastData['Podcast_thumbnail'];
        String podcastTitle = podcastData['podcast_name'];

        for (var episode in episodes!) {
          DocumentSnapshot? episodeSnapshot = await episode.get();
          Map<String, dynamic>? episodeData =
              episodeSnapshot.data() as Map<String, dynamic>;

          String title = episodeData['episode_name'];
          String audio = episodeData['audio_file'];

          AudioPlayerMeta.add(AudioSource.uri(Uri.parse(audio),
              tag: MediaItem(
                  id: '$index',
                  title: title,
                  artUri: Uri.parse(podcastCover),
                  artist: 'Spark FM',
                  album: podcastTitle)));
        }

        audioPlayer.setAudioSource(AudioPlayerMeta,
            initialIndex: 0, initialPosition: Duration.zero);
        notifyListeners();
      } else if (song != null) {
        DocumentSnapshot? songSnapshot = await song.get();
        Map<String, dynamic>? songData =
            songSnapshot.data() as Map<String, dynamic>;
        String title = songData['song_name'];
        String image = songData['song_image'];
        String audio = songData['song_audioFile'];

        AudioPlayerMeta.add(AudioSource.uri(Uri.parse(audio),
            tag: MediaItem(
                id: '$index',
                title: title,
                artUri: Uri.parse(image),
                artist: artist)));
      }

      audioPlayer.setAudioSource(AudioPlayerMeta,
          initialIndex: 0, initialPosition: Duration.zero);
      notifyListeners();
    } else if (live == true) {
      if (audioPlayer.playing) {
        await audioPlayer.stop();
      }
      audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse("https://s2.radio.co/s642c89cd0/listen"),
              tag: MediaItem(
                id: 'Live',
                title: 'Spark FM Radio',
                artUri: Uri.file("assets/images/SFM_APP_ICON.png"),
                artist: 'Spark FM',
              )));
    }
    notifyListeners();
    await audioPlayer.play();
  }

  void updateAudioPlayerState(ConcatenatingAudioSource newAudioMeta) {
    _AudioPlayerMeta = newAudioMeta;
    notifyListeners();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _isLive = false;
  bool get isLive => _isLive;
  set isLive(bool _value) {
    _isLive = _value;
  }

  bool _streamPlaying = false;
  bool get streamPlaying => _streamPlaying;
  set streamPlaying(bool _value) {
    _streamPlaying = _value;
  }

  ConcatenatingAudioSource _AudioPlayerMeta = ConcatenatingAudioSource(
    children: [],
    useLazyPreparation: true,
    shuffleOrder: DefaultShuffleOrder(),
  );
  ConcatenatingAudioSource get AudioPlayerMeta => _AudioPlayerMeta;
  set AudioPlayerMeta(ConcatenatingAudioSource _value) {
    _AudioPlayerMeta = _value;
  }

  List<AudioPlayer> _audioMediaMetas = [];
  List<AudioPlayer> get audioMediaMetas => _audioMediaMetas;
  set audioMediaMetas(List<AudioPlayer> _value) {
    _audioMediaMetas = _value;
  }

  void addToAudioMediaMetas(AudioPlayer _value) {
    _audioMediaMetas.add(_value);
    notifyListeners();
  }

  void removeFromAudioMediaMetas(AudioPlayer _value) {
    _audioMediaMetas.remove(_value);
  }

  void removeAtIndexFromAudioMediaMetas(int _index) {
    _audioMediaMetas.removeAt(_index);
  }

  void updateAudioMediaMetasAtIndex(
    int _index,
    AudioPlayer Function(AudioPlayer) updateFn,
  ) {
    _audioMediaMetas[_index] = updateFn(_audioMediaMetas[_index]);
  }

  void updateAudioPlayerMetaStruct(
      Function(ConcatenatingAudioSource) updateFn) {
    updateFn(_AudioPlayerMeta);
    notifyListeners();
  }

  AudioPlayer audioPlayer = AudioPlayer();

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool _value) {
    _isPlaying = _value;
  }

  bool _isPaused = false;
  bool get isPaused => _isPaused;
  set isPaused(bool _value) {
    _isPaused = _value;
  }

  bool _isShuffle = false;
  bool get isShuffle => _isShuffle;
  set isShuffle(bool _value) {
    _isShuffle = _value;
  }

  bool _isStopped = false;
  bool get isStopped => _isStopped;
  set isStopped(bool _value) {
    _isStopped = _value;
  }

  String _isRandom = '';
  String get isRandom => _isRandom;
  set isRandom(String _value) {
    _isRandom = _value;
  }

  int _selectedSongIndex = 0;
  int get selectedSongIndex => _selectedSongIndex;
  set selectedSongIndex(int _value) {
    _selectedSongIndex = _value;
  }

  String _currentMetaImage = '';
  String get currentMetaImage => _currentMetaImage;
  set currentMetaImage(String _value) {
    _currentMetaImage = _value;
  }

  String _currrenMetaTitle = '';
  String get currrenMetaTitle => _currrenMetaTitle;
  set currrenMetaTitle(String _value) {
    _currrenMetaTitle = _value;
  }

  String _currentMetaAlbumPlaylistPodcastSong = '';
  String get currentMetaAlbumPlaylistPodcastSong =>
      _currentMetaAlbumPlaylistPodcastSong;
  set currentMetaAlbumPlaylistPodcastSong(String _value) {
    _currentMetaAlbumPlaylistPodcastSong = _value;
  }

  String _CurrentMetaArist = '';
  String get CurrentMetaArist => _CurrentMetaArist;
  set CurrentMetaArist(String _value) {
    _CurrentMetaArist = _value;
  }

  final _sparkTvManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> sparkTv({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _sparkTvManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearSparkTvCache() => _sparkTvManager.clear();
  void clearSparkTvCacheKey(String? uniqueKey) =>
      _sparkTvManager.clearRequest(uniqueKey);
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
