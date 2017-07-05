## supported platforms
- basically anything that supports ```sys.FileSystem```, ```sys.io.File``` and ```Sys.getEnv```
- only tested on node (-lib [hxnodejs](https://github.com/HaxeFoundation/hxnodejs))

## .env format
### comments
```make
# comments start with a hashtag
```

### keys + values
- lines are stripped of whitespace
- lines are split on the first occurence of an ```=```
```make
SOME_KEY=SOME_VALUE
```

## resolution order
1) real environment variables (Sys.getEnv())
2) whatever you feed into the Dotenv instance

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
