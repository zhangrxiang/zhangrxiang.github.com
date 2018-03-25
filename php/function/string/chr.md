# chr
> - (PHP 4, PHP 5, PHP 7)
> - chr — Return a specific character
> - chr — 返回指定的字符

## Description
```php
string chr ( int $ascii )
//Returns a one-character string containing the character specified by ascii.
//返回相对应于 ascii 所指定的单个字符。
//This function complements ord().
//此函数与 ord() 是互补的。
```

## Parameters
### ascii
- The extended ASCII code.
- Ascii 码。

- Values outside the valid range (0..255) will be bitwise and'ed with 255, which is equivalent to the following algorithm:
```php
while ($ascii < 0) {
    $ascii += 256;
}
$ascii %= 256;
```

## Return Values
- Returns the specified character.
- 返回规定的字符。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/15
 * Time: 下午6:56
 */


for ( $i = 65; $i < 127; $i ++ ) {
	echo chr( $i ) . ' ';
	if ( $i % 10 == 0 ) {
		echo PHP_EOL;
	}
}
/*
 * A B C D E F
 * G H I J K L M N O P
 * Q R S T U V W X Y Z
 * [ \ ] ^ _ ` a b c d
 * e f g h i j k l m n
 * o p q r s t u v w x
 * y z { | } ~
 */
echo PHP_EOL;


function unichr( $dec ) {
	if ( $dec < 128 ) {
		$utf = chr( $dec );
	} else if ( $dec < 2048 ) {
		$utf = chr( 192 + ( ( $dec - ( $dec % 64 ) ) / 64 ) );
		$utf .= chr( 128 + ( $dec % 64 ) );
	} else {
		$utf = chr( 224 + ( ( $dec - ( $dec % 4096 ) ) / 4096 ) );
		$utf .= chr( 128 + ( ( ( $dec % 4096 ) - ( $dec % 64 ) ) / 64 ) );
		$utf .= chr( 128 + ( $dec % 64 ) );
	}
	
	return $utf;
}

//中
echo unichr( 20013 ) . PHP_EOL;
//A
echo chr( 321 ) . PHP_EOL;//A 256 + 65 = 321

function genPass( $len = 8 ) {
	$passwd = '';
	for ( $i = 0; $i <= $len; $i ++ ) {
		$passwd = sprintf( '%s%c', isset( $passwd ) ? $passwd : null, rand( 48, 122 ) );
	}
	
	return $passwd;
}

//vuTR<oUn;
echo genPass( 8 ) . PHP_EOL;

function unichr2( $dec ) {
	if ( $dec < 0x80 ) {
		$utf = chr( $dec );
	} else if ( $dec < 0x0800 ) {
		$utf = chr( 0xC0 + ( $dec >> 6 ) );
		$utf .= chr( 0x80 + ( $dec & 0x3f ) );
	} else if ( $dec < 0x010000 ) {
		$utf = chr( 0xE0 + ( $dec >> 12 ) );
		$utf .= chr( 0x80 + ( ( $dec >> 6 ) & 0x3f ) );
		$utf .= chr( 0x80 + ( $dec & 0x3f ) );
	} else if ( $dec < 0x200000 ) {
		$utf = chr( 0xF0 + ( $dec >> 18 ) );
		$utf .= chr( 0x80 + ( ( $dec >> 12 ) & 0x3f ) );
		$utf .= chr( 0x80 + ( ( $dec >> 6 ) & 0x3f ) );
		$utf .= chr( 0x80 + ( $dec & 0x3f ) );
	} else {
		die( "UTF-8 character size is more than 4 bytes" );
	}
	
	return $utf;
}

function unichr3( $u ) {
	return mb_convert_encoding( '&#' . intval( $u ) . ';', 'UTF-8', 'HTML-ENTITIES' );
}

echo unichr( 0x263A ) . PHP_EOL;//☺
echo unichr2( 0x263A ) . PHP_EOL;//☺
echo unichr3( 0x263A ) . PHP_EOL;//☺
echo unichr( 0x263B ) . PHP_EOL;//☻
echo unichr2( 0x263B ) . PHP_EOL;//☻
echo unichr( 20013 ) . PHP_EOL;//中
echo unichr2( 20013 ) . PHP_EOL;//中
echo unichr3( 20013 ) . PHP_EOL;//中

```


## See
- <http://php.net/manual/en/function.chr.php>

### *All rights reserved*