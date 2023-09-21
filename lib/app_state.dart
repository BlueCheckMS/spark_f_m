import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spark_f_m/flutter_flow/flutter_flow_audio_player.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

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
    AssetsAudioPlayer? assetsAudioPlayer,
    int? index,
    bool? live,
  }) async {
    if (live != null) {
      isLive = live;
    }
    List<Audio> audios = [];
    if (audios.isNotEmpty) {
      audios.clear();
    }
    Audio audioMeta;
    if (playlist != null) {
      for (var song in songs!) {
        DocumentSnapshot? songSnapshot = await song.get();
        Map<String, dynamic>? songData =
            songSnapshot.data() as Map<String, dynamic>;
        String title = songData['song_name'];
        String image = songData['song_image'];
        String audio = songData['song_audioFile'];

        bool metaExist = audios.any((meta) =>
            meta.metas.title == title &&
            meta.path == audio &&
            meta.metas.image?.path == image);
        if (!metaExist) {
          audioMeta = Audio.network(audio,
              metas: Metas(
                  title: title,
                  image: MetasImage.network(image),
                  artist: artist));
          audios.add(audioMeta);
        }
      }
    } else if (album != null) {
      DocumentSnapshot? albumSnapshot = await album?.get();
      Map<String, dynamic>? albumData =
          albumSnapshot?.data() as Map<String, dynamic>;
      String albumCover = albumData['album_cover'];
      String albumTitle = albumData['AlbumTitle'];
      for (var song in songs!) {
        DocumentSnapshot? songSnapshot = await song.get();
        Map<String, dynamic>? songData =
            songSnapshot.data() as Map<String, dynamic>;
        String title = songData['song_name'];
        String image = songData['song_image'];
        String audio = songData['song_audioFile'];

        bool metaExist = audios.any((meta) =>
            meta.metas.title == title &&
            meta.path == audio &&
            meta.metas.image?.path == image);
        if (!metaExist) {
          audioMeta = Audio.network(
            audio,
            metas: Metas(
                title: title,
                image: MetasImage.network(albumCover),
                artist: artist,
                album: albumTitle),
          );
          audios.add(audioMeta);
        }
      }
    } else if (podcast != null) {
      DocumentSnapshot? podcastSnapshot = await podcast?.get();
      Map<String, dynamic>? podcastData =
          podcastSnapshot?.data() as Map<String, dynamic>;
      String podcastCover = podcastData['Podcast_thumbnail'];
      String podcastTitle = podcastData['podcast_name'];
      if (audios.isNotEmpty) {
        audios.clear();
      }
      Audio audioMeta;

      for (var episode in episodes!) {
        DocumentSnapshot? episodeSnapshot = await episode.get();
        Map<String, dynamic>? episodeData =
            episodeSnapshot.data() as Map<String, dynamic>;

        String title = episodeData['episode_name'];
        String audio = episodeData['audio_file'];

        bool metaExist = audios
            .any((meta) => meta.metas.title == title && meta.path == audio);
        if (!metaExist) {
          audioMeta = Audio.network(
            audio,
            metas: Metas(
                title: title,
                image: MetasImage.network(podcastCover),
                artist: artist,
                album: podcastTitle),
          );
          audios.add(audioMeta);
        }
      }
    } else if (song != null) {
      if (audios.isNotEmpty) {
        audios.clear();
      }
      DocumentSnapshot? songSnapshot = await song.get();
      Map<String, dynamic>? songData =
          songSnapshot.data() as Map<String, dynamic>;
      String title = songData['song_name'];
      String image = songData['song_image'];
      String audio = songData['song_audioFile'];

      audioMeta = Audio.network(audio,
          metas: Metas(
              title: title, image: MetasImage.network(image), artist: artist));
      audios.add(audioMeta);
    }

    if (assetsAudioPlayer!.isPlaying.value == true) {
      await assetsAudioPlayer.stop();
      if (live == true) {
        await assetsAudioPlayer.open(
          playInBackground: PlayInBackground.enabled,
          Audio.liveStream("https://s2.radio.co/s642c89cd0/listen",
              metas: Metas(
                  title: 'Spark FM Radio',
                  image: MetasImage.asset("assets/images/SFM APP ICON.png"),
                  artist: 'Spark FM')),
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
          showNotification: true,
          notificationSettings: NotificationSettings(
              playPauseEnabled: true,
              nextEnabled: true,
              prevEnabled: true,
              seekBarEnabled: true),
        );
        audioPlayer = assetsAudioPlayer;
        notifyListeners();
      } else {
        await assetsAudioPlayer.open(
          playInBackground: PlayInBackground.enabled,
          Playlist(audios: audios),
          showNotification: true,
          autoStart: true,
          loopMode: LoopMode.playlist,
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
          notificationSettings: NotificationSettings(
              playPauseEnabled: true,
              nextEnabled: true,
              prevEnabled: true,
              seekBarEnabled: true),
        );
        notifyListeners();
        audioPlayer = assetsAudioPlayer;
      }
    } else {
      if (live == true) {
        await assetsAudioPlayer.open(
          playInBackground: PlayInBackground.enabled,
          Audio.liveStream("https://s2.radio.co/s642c89cd0/listen",
              metas: Metas(
                  title: 'Spark FM Radio',
                  image: MetasImage.asset("assets/images/SFM APP ICON.png"),
                  artist: 'Spark FM')),
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
          showNotification: true,
          notificationSettings: NotificationSettings(
              playPauseEnabled: true,
              nextEnabled: true,
              prevEnabled: true,
              seekBarEnabled: true),
        );
        audioPlayer = assetsAudioPlayer;
        notifyListeners();
      } else {
        await assetsAudioPlayer.open(
          Playlist(audios: audios),
          showNotification: true,
          notificationSettings: NotificationSettings(
              playPauseEnabled: true,
              nextEnabled: true,
              prevEnabled: true,
              seekBarEnabled: true),
          autoStart: true,
          loopMode: LoopMode.playlist,
          playInBackground: PlayInBackground.enabled,
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
        );
        audioPlayer = assetsAudioPlayer;
        notifyListeners();
      }
    }
    // Add your function code here!
  }

  void updateAudioPlayerState(Audio newAudioMeta) {
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

  String _audioPlayerId = '';
  String get audioPlayerId => _audioPlayerId;
  set audioPlayerId(String _value) {
    _audioPlayerId = _value;
  }

  Audio _AudioPlayerMeta = Audio('');
  Audio get AudioPlayerMeta => _AudioPlayerMeta;
  set AudioPlayerMeta(Audio _value) {
    _AudioPlayerMeta = _value;
  }

  List<Audio> _audioMediaMetas = [];
  List<Audio> get audioMediaMetas => _audioMediaMetas;
  set audioMediaMetas(List<Audio> _value) {
    _audioMediaMetas = _value;
  }

  void addToAudioMediaMetas(Audio _value) {
    _audioMediaMetas.add(_value);
    notifyListeners();
  }

  void removeFromAudioMediaMetas(Audio _value) {
    _audioMediaMetas.remove(_value);
  }

  void removeAtIndexFromAudioMediaMetas(int _index) {
    _audioMediaMetas.removeAt(_index);
  }

  void updateAudioMediaMetasAtIndex(
    int _index,
    Audio Function(Audio) updateFn,
  ) {
    _audioMediaMetas[_index] = updateFn(_audioMediaMetas[_index]);
  }

  void updateAudioPlayerMetaStruct(Function(Audio) updateFn) {
    updateFn(_AudioPlayerMeta);
    notifyListeners();
  }

  AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  AssetsAudioPlayer get audioPlayer => _audioPlayer;
  set audioPlayer(AssetsAudioPlayer _value) {
    _audioPlayer = _value;
  }

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
