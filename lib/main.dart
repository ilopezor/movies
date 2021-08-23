import 'package:flutter/material.dart';
import 'package:movies/providers/movies_provaider.dart';
import 'package:movies/screens/screens.dart';
import 'package:provider/provider.dart';
void main() => runApp(AppState());
 
class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ ) => MoviesProvider(), lazy: false ),
      ],
      child: MyApp()
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: 'home',
      routes: {
        'home':( _ ) => HomeScreens(),
        'details':( _ ) => DetailScreens(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.purple
        )
      ),
    );
  }
}