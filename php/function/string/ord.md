# ord
> - (PHP 4, PHP 5, PHP 7)
> - ord — Return ASCII value of character
> - ord — 返回字符的 ASCII 码值

## Description
```php
int ord ( string $string )
//Returns the ASCII value of the first character of string.
//返回字符串 string 第一个字符的 ASCII 码值。
//This function complements chr().
//该函数是 chr() 的互补函数。
```

## Parameters
### string
- A character.
- 一个字符。

## Return Values
- Returns the ASCII value as an integer.
- 返回整型的 ASCII 码值。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/18
 * Time: 下午9:43
 */
$str = 'abcdef';

for ( $i = 0; $i < strlen( $str ); $i ++ ) {
	echo $str[ $i ] . ' : ' . ord( $str{$i} ) . PHP_EOL;
}
/*
 * a : 97
 * b : 98
 * c : 99
 * d : 100
 * e : 101
 * f : 102
 */

echo ord( 'a' ) . PHP_EOL;//97
echo ord( 'b' ) . PHP_EOL;//98

function ordutf8( $string, &$offset ) {
	$code        = ord( substr( $string, $offset, 1 ) );
	$bytesnumber = 0;
	if ( $code >= 128 ) {        //otherwise 0xxxxxxx
		if ( $code < 224 ) {
			$bytesnumber = 2;
		}                //110xxxxx
		else if ( $code < 240 ) {
			$bytesnumber = 3;
		}        //1110xxxx
		else if ( $code < 248 ) {
			$bytesnumber = 4;
		}    //11110xxx
		$codetemp = $code - 192 - ( $bytesnumber > 2 ? 32 : 0 ) - ( $bytesnumber > 3 ? 16 : 0 );
		for ( $i = 2; $i <= $bytesnumber; $i ++ ) {
			$offset ++;
			$code2    = ord( substr( $string, $offset, 1 ) ) - 128;        //10xxxxxx
			$codetemp = $codetemp * 64 + $code2;
		}
		$code = $codetemp;
	}
	$offset += 1;
	if ( $offset >= strlen( $string ) ) {
		$offset = - 1;
	}
	
	return $code;
}

$text   = "中国😄";
$offset = 0;
while ( $offset >= 0 ) {
	//0: 20013
	//3: 22269
	//6: 128516
	echo $offset . ": " . ordutf8( $text, $offset ) . PHP_EOL;
}

function uniord( $u ) {
	$k  = mb_convert_encoding( $u, 'UCS-2LE', 'UTF-8' );
	$k1 = ord( substr( $k, 0, 1 ) );
	$k2 = ord( substr( $k, 1, 1 ) );
	
	return $k2 * 256 + $k1;
}

echo uniord( "中" ) . PHP_EOL;//20013
echo uniord( "国" ) . PHP_EOL;//22269
//error
echo uniord( '😄' ) . PHP_EOL;//63
```


## See
- <http://php.net/manual/en/function.ord.php>

### *All rights reserved*