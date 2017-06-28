package dotenv;

import sys.FileSystem;
import sys.io.File;
using StringTools;
using tink.CoreApi;

class Dotenv {
	public static var defaultPatterns(default, null) = [
		'.env',
		'.env.local',
#if debug
		'.env.development',
		'.env.development.local',
#else
		'.env.production',
		'.env.production.local',
#end
	];

	public static function feedFiles( patterns: Array<String> ) {
		patterns.map(function( path ) {
			if (!FileSystem.exists(path)) {
				return;
			}

			var lines = File.getContent(path)
				.replace('\r\n', '\n')  // (DK) epic crossplatform code \o/
				.split('\n');

			for (line in lines) {
				var clean = line.trim();

				if (	clean.length == 0
					||	clean.charAt(0) == '#') {
					continue;
				}

				var eqi = clean.indexOf('=');

				if (eqi == -1) {
					throw new Error('invalid line');
				}

				var key = clean.substr(0, eqi);
				var value = clean.substr(eqi + 1);
				feedValue(key, value);
			}
		});
	}

	public static function feedValue( key: String, value: String ) {
		store.set(key, value);
	}

	public static function get( key: String, defaultValue: String ) : String {
		var value = fetch(key);
		return value != null ? value : defaultValue;
	}

	public static function getInt( key: String, defaultValue: Int ) : Int {
		var value = fetch(key);
		var asInt: Null<Int> = value != null ? Std.parseInt(value) : null;
		return asInt != null ? asInt : defaultValue;
	}

	static function fetch( key: String ) : String {
		var value = store.get(key);
		var host = Sys.getEnv(key);

		return host != null
			? host
			: value;
	}

	static var store = new Map<String, String>();
}
