import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mangkat_game/game/car_race.dart';
import 'package:mangkat_game/game/widgets/game_over_overlay.dart';
import 'package:mangkat_game/game/widgets/game_overlay.dart';
import 'package:mangkat_game/game/widgets/main_menu_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Car Race',
      // themeMode: ThemeMode.dark,
      // theme: ThemeData(
      //   colorScheme: lightColorScheme,
      //   useMaterial3: true,
      // ),
      // darkTheme: ThemeData(
      //   colorScheme: darkColorScheme,
      //   textTheme: GoogleFonts.audiowideTextTheme(ThemeData.dark().textTheme),
      //   useMaterial3: true,
      // ),
      home: CarRaceHomePage(),
    );
  }
}

// final Game game = CarRace();

class MangkatGame extends StatelessWidget {
  final Game game;

  const MangkatGame({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: game,
      overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
        'gameOverlay': (context, game) => GameOverlay(game),
        'mainMenuOverlay': (context, game) => MainMenuOverlay(game),
        'gameOverOverlay': (context, game) => GameOverOverlay(game),
      },
    );
  }
}

class CarRaceHomePage extends StatelessWidget {
  const CarRaceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            constraints: const BoxConstraints(
              maxWidth: 800,
              minWidth: 550,
            ),
            child: GameWidget(
              game: CarRace(),
              overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
                'gameOverlay': (context, game) => GameOverlay(game),
                'mainMenuOverlay': (context, game) => MainMenuOverlay(game),
                'gameOverOverlay': (context, game) => GameOverOverlay(game),
              },
            ),
          );
        }),
      ),
    );
  }
}
