import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'views/main_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,

      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: ThemeData(useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black,
          // blue for the app bar
          secondary: Color(0xFF2196f3), // found with gimp
          // red button
          onSecondary: Color(0xFFf44336), // found with gimp
          // blue button
          onSecondaryContainer: Color(0xFF2196f3), // found with gimp
          // blue text
          tertiary: Color(0xFF2196f3), // found with gimp
          // black text for players
          onTertiary: Color(0xFF202020), // found with gimp
          // not exact white for the background
          background: Color(0xFFfafafa), // found with gimp

          onPrimary: Colors.black,
          error: Colors.deepOrangeAccent,
          onError: Colors.deepOrangeAccent,
          onBackground: Colors.white,
          surface: Colors.white,
          onSurface: Colors.white,
        ),
        textTheme: TextTheme(
          // for the app bar
          headlineMedium: GoogleFonts.roboto(
            textStyle: TextStyle(color: Theme.of(context).colorScheme.background, letterSpacing: .5),
          ),
          // for buttons
          headlineSmall: GoogleFonts.lato(
            textStyle: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),
      ),
      //darkTheme: ThemeData.dark(),

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              default:
                return const MainView();
            }
          },
        );
      },
    );
  }
}
