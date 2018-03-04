# rtrim
> - (PHP 4, PHP 5, PHP 7)
> - rtrim — Strip whitespace (or other characters) from the end of a string
> - rtrim — 删除字符串末端的空白字符（或者其他字符）

## Description
```php
string rtrim ( string $str [, string $character_mask ] )
//This function returns a string with whitespace (or other characters) stripped from the end of str.
//该函数删除 str 末端的空白字符（或者其他字符）并返回。

//Without the second parameter, rtrim() will strip these characters:
//不使用第二个参数，rtrim() 仅删除以下字符：

" " (ASCII 32 (0x20)), //an ordinary space.普通空白符。
"\t" (ASCII 9 (0x09)), //a tab.制表符。
"\n" (ASCII 10 (0x0A)), //a new line (line feed).换行符。
"\r" (ASCII 13 (0x0D)), //a carriage return.回车符。
"\0" (ASCII 0 (0x00)), //the NULL-byte.NUL 空字节符。
"\x0B" (ASCII 11 (0x0B)), //a vertical tab.垂直制表符。
```

## Parameters
### str
- The input string.
- 输入字符串。

### character_mask
- You can also specify the characters you want to strip, by means of the character_mask parameter. Simply list all characters that you want to be stripped. With .. you can specify a range of characters.
- 通过指定 character_mask，可以指定想要删除的字符列表。简单地列出你想要删除的全部字符。使用 .. 格式，可以指定一个范围。

## Return Values
- Returns the modified string.
- 返回改变后的字符串。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/3/4
 * Time: 下午4:51
 */
//rtrim — 删除字符串末端的空白字符（或者其他字符）

$hello = "Hello World";
//Hello World
echo $hello . PHP_EOL;
//Hello World
echo rtrim( $hello ) . PHP_EOL;
//Hello Worl
echo rtrim( $hello, "d" ) . PHP_EOL;
//Hello Wor
echo rtrim( $hello, "dl" ) . PHP_EOL;

$text = "\t\tThese are a few words :) ...  ";
//		These are a few words :) ...
echo $text . PHP_EOL;
//		These are a few words :) ...
echo rtrim( $text ) . PHP_EOL;
//		These are a few words
echo rtrim( $text, ":) ." ) . PHP_EOL;

$binary = "\x09Example string\x0A";
//	Example string
echo $binary . PHP_EOL;
//	Example string
echo rtrim( $binary ) . PHP_EOL;
//	Example string
echo rtrim( $binary, "\x00..\x1F" ) . PHP_EOL;

/////////////////////////////////////////////////////////////////////////////////////
function strrtrim( $message, $strip ) {
	// break message apart by strip string
	$lines = explode( $strip, $message );
	var_dump( $lines );
	if ( is_array( $lines ) ) {
		// pop off empty strings at the end
		do {
			$last = array_pop( $lines );
		} while ( empty( $last ) && ( count( $lines ) ) );
		
	} else {
		return "";
	}
	
	// re-assemble what remains
	return implode( $strip, array_merge( $lines, array( $last ) ) );
}

//hello,world,hi
echo strrtrim( "hello,world,hi ", ' ' ) . PHP_EOL;

////////////////////////////////////////////////////////////////////////////////////
$aFileContent = file( "rtrim.php" );
foreach ( $aFileContent as $sKey => $sValue ) {
	$aFileContent[ $sKey ] = rtrim( $sValue );
}

foreach ( $aFileContent as $sKey => $sValue ) {
	if ( $sKey == 10 ) {
		break;
	}
	echo $sKey . " " . $sValue . PHP_EOL;
}
//0 <?php
//1 /**
//2  * Created by PhpStorm.
//3  * User: zhangrongxiang
//4  * Date: 2018/3/4
//5  * Time: 下午4:51
//6  */
//7 //rtrim — 删除字符串末端的空白字符（或者其他字符）
//8
//9 $hello = "Hello World";

//This is a
echo rtrim( 'This is a short short sentence', 'short sentence' ) . PHP_EOL;
//This is a short short
echo rtrim( 'This is a short short sentence', 'cents' );

////////////////////////////////////////////////////////////////////////////////////
function read_more( $in, $len = 16 ) {
	if ( strlen( $in ) > $len ) {
		return preg_replace( '/[\s\.,][^\s\.,]*$/u', '', substr( $in, 0, $len ) ) . '...';
	} else {
		return $in;
	}
}

//This is a short short hello world,...
echo read_more( "hello world, php is the best language around the world" ) . PHP_EOL;
```

## See
- <http://php.net/manual/zh/function.rtrim.php>

### *All rights reserved*