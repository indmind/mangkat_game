import 'dart:io' show Platform;

import 'package:flame/game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mangkat_game/game/car_race.dart';

import 'widgets.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverlay> createState() => GameOverlayState();
}

class GameOverlayState extends State<GameOverlay> {
  bool isPaused = false;
  final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  final Game game = CarRace();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: GameScoreDisplay(game: widget.game),
          ),
          Positioned(
            top: 30,
            right: 30,
            child: FilledButton(
              child: isPaused
                  ? const Icon(
                      Icons.play_arrow,
                      size: 28,
                    )
                  : const Icon(
                      Icons.pause,
                      size: 28,
                    ),
              onPressed: () {
                (widget.game as CarRace).togglePauseState();
                setState(
                  () {
                    isPaused = !isPaused;
                  },
                );
              },
            ),
          ),
          // if (isMobile)
          Positioned(
            bottom: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: GestureDetector(
                          onTapDown: (details) {
                            (widget.game as CarRace).player.moveLeft();
                          },
                          onTapUp: (details) {
                            (widget.game as CarRace).player.resetDirection();
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 3.0,
                            shadowColor: Theme.of(context).colorScheme.primary,
                            child: const Icon(
                              Icons.arrow_left_rounded,
                              size: 64,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: GestureDetector(
                          onTapDown: (details) {
                            (widget.game as CarRace).player.moveRight();
                          },
                          onTapUp: (details) {
                            (widget.game as CarRace).player.resetDirection();
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 3.0,
                            shadowColor: Theme.of(context).colorScheme.primary,
                            child: const Icon(
                              Icons.arrow_right_rounded,
                              size: 64,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const WhiteSpace(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          if (isPaused)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 72.0,
              right: MediaQuery.of(context).size.width / 2 - 72.0,
              child: const Icon(
                Icons.pause_circle,
                size: 144.0,
                color: Colors.black12,
              ),
            ),
        ],
      ),
    );
  }
}
