
extends Node

enum LogLevel { INFO, WARN, ERROR }

var current_level := LogLevel.INFO

func log(message: String, level: LogLevel = LogLevel.INFO):
	if not OS.is_debug_build():
		return

	if level < current_level:
		return

	var prefix := ""

	match level:
		LogLevel.INFO:
			prefix = "[INFO] "
		LogLevel.WARN:
			prefix = "[WARN] "
		LogLevel.ERROR:
			prefix = "[ERROR] "

	print(prefix + message)