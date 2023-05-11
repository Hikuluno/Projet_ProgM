// ignore_for_file: avoid_print

// https://pub.dev/packages/flutter_p2p_connection
import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';

final _flutterP2pConnectionPlugin = FlutterP2pConnection();

class MultiplayerScreen extends StatefulWidget {
  const MultiplayerScreen({super.key});

  @override
  State<MultiplayerScreen> createState() => _MultiplayerScreen();
}

class _MultiplayerScreen extends State<MultiplayerScreen> with WidgetsBindingObserver {
  StreamSubscription<WifiP2PInfo>? _streamWifiInfo;
  StreamSubscription<List<DiscoveredPeers>>? _streamPeers;
  List<DiscoveredPeers> peers = [];
  WifiP2PInfo? wifiP2PInfo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _flutterP2pConnectionPlugin.unregister();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _flutterP2pConnectionPlugin.unregister();
    } else if (state == AppLifecycleState.resumed) {
      _flutterP2pConnectionPlugin.register();
    }
  }

  void _init() async {
    await _flutterP2pConnectionPlugin.initialize();
    await _flutterP2pConnectionPlugin.register();
    _streamWifiInfo = _flutterP2pConnectionPlugin.streamWifiP2PInfo().listen((event) {
      setState(() {
        wifiP2PInfo = event;
      });
    });
    _streamPeers = _flutterP2pConnectionPlugin.streamPeers().listen((event) {
      setState(() {
        peers = event;
      });
    });
  }

  void discover() {
    _flutterP2pConnectionPlugin.enableLocationServices();
    _flutterP2pConnectionPlugin.enableWifiServices();
    _flutterP2pConnectionPlugin.discover();
  }

  void stopDiscovery() {
    _flutterP2pConnectionPlugin.stopDiscovery();
  }

  void connect() async {
    print("peers empty ? ${peers.isEmpty}");
    if (peers.isNotEmpty) {
      await _flutterP2pConnectionPlugin.connect(peers[0].deviceAddress);
    }
  }

  void disconnect() async {
    _flutterP2pConnectionPlugin.removeGroup();
  }

  Future<void> startSocket() async {
    if (wifiP2PInfo != null) {
      await _flutterP2pConnectionPlugin.startSocket(
        groupOwnerAddress: wifiP2PInfo!.groupOwnerAddress,
        downloadPath: "/storage/emulated/0/Download/",
        maxConcurrentDownloads: 2,
        deleteOnError: true,
        onConnect: (name, address) {
          print("$name connected to socket with address: $address");
        },
        transferUpdate: (transfer) {
          print("Transfer Update: $transfer");
        },
        receiveString: (req) async {
          print(req);
        },
      );
    }
  }

  Future<void> connectToSocket() async {
    if (wifiP2PInfo != null) {
      await _flutterP2pConnectionPlugin.connectToSocket(
        groupOwnerAddress: wifiP2PInfo!.groupOwnerAddress,
        downloadPath: "/storage/emulated/0/Download/",
        maxConcurrentDownloads: 2,
        deleteOnError: true,
        onConnect: (address) {
          print("Connected to socket: $address");
        },
        transferUpdate: (transfer) {
          print("Transfer Update: $transfer");
        },
        receiveString: (req) async {
          print(req);
        },
      );
    }
  }

  void sendStringToSocket(String message) {
    _flutterP2pConnectionPlugin.sendStringToSocket(message);
  }

  Future<List<TransferUpdate>?> sendFileToSocket(List<String> filePaths) {
    return _flutterP2pConnectionPlugin.sendFiletoSocket(filePaths);
  }

  void closeSocket() {
    _flutterP2pConnectionPlugin.closeSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wi-Fi Direct"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: discover,
              child: const Text("Discover"),
            ),
            ElevatedButton(
              onPressed: stopDiscovery,
              child: const Text("Stop Discovery"),
            ),
            ElevatedButton(
              onPressed: connect,
              child: const Text("Connect"),
            ),
            ElevatedButton(
              onPressed: disconnect,
              child: const Text("Disconnect"),
            ),
            ElevatedButton(
              onPressed: startSocket,
              child: const Text("Start Socket"),
            ),
            ElevatedButton(
              onPressed: connectToSocket,
              child: const Text("Connect to Socket"),
            ),
            ElevatedButton(
              onPressed: () {
                sendStringToSocket("Hello, World!");
              },
              child: const Text("Send String to Socket"),
            ),
            ElevatedButton(
              onPressed: () {
                sendFileToSocket(["/path/to/file1", "/path/to/file2"]);
              },
              child: const Text("Send File to Socket"),
            ),
            ElevatedButton(
              onPressed: closeSocket,
              child: const Text("Close Socket"),
            ),
          ],
        ),
      ),
    );
  }
}
