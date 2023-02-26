import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 4, // number of method calls to be displayed
        errorMethodCount:
            12, // number of method calls if stacktrace is provided
        lineLength: 200, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
    level: kDebugMode ? Level.debug : Level.nothing);
