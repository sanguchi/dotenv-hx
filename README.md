## supported platforms
- basically anything that supports ```sys.FileSystem```, ```sys.io.File``` and ```Sys.getEnv```
- only tested on node (-lib [hxnodejs](https://github.com/HaxeFoundation/hxnodejs))

## usage
sample .env file
```
HOST=some.domain
PORT=0815
```

example
```haxe
import dotenv.Dotenv;

class Main {
	public static function main() {
		// do as early as possible
		Dotenv.feedFiles([
			'.env',
			'.env.development',
			'.env.development.local',
		]);

		var host = Dotenv.get('HOST', 'localhost');
		var port = Dotenv.getInt('PORT', 3000);
	}
}
```
