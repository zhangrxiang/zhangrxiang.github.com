# split
> - (PHP 5, PHP 7)
> - str_split — Convert a string to an array
> - str_split — 将字符串转换为数组

## Description
```php
array str_split ( string $string [, int $split_length = 1 ] )
//Converts a string to an array.
//将一个字符串转换为数组。
```
## Parameters
### string
- The input string.
- 输入字符串。

### split_length
- Maximum length of the chunk.
- 每一段的长度。

## Return Values
- If the optional split_length parameter is specified, the returned array will be broken down into chunks with each being split_length in length, otherwise each chunk will be one character in length.
- 如果指定了可选的 split_length 参数，返回数组中的每个元素均为一个长度为 split_length 的字符块，否则每个字符块为单个字符。
- FALSE is returned if split_length is less than 1. If the split_length length exceeds the length of string, the entire string is returned as the first (and only) array element.
- 如果 split_length 小于 1，返回 FALSE。如果 split_length 参数超过了 string 超过了字符串 string 的长度，整个字符串将作为数组仅有的一个元素返回。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/3/7
 * Time: 下午10:24
 */

$str = "hello world";
//[0] => h;[1] => e;[2] => l;[3] => l;[4] => o;[5] => ;[6] => w;[7] => o;[8] => r;[9] => l;[10] => d
print_r( str_split( $str ) );

/*
 * [0] => he
 * [1] => ll
 * [2] => o
 * [3] => wo
 * [4] => rl
 * [5] => d
 */
print_r( str_split( $str, 2 ) );
/*
 * [0] => hello
 * [1] =>  worl
 * [2] => d
 */
print_r( str_split( $str, 5 ) );

//PHP Warning:  str_split(): The length of each segment must be greater than zero in file on line 28
//print_r(str_split($str,-5));

////////////////////////////////////////////////////////////////////////
function str_split_unicode( $str, $l = 0 ) {
	if ( $l > 0 ) {
		$ret = array();
		$len = mb_strlen( $str, "UTF-8" );
		for ( $i = 0; $i < $len; $i += $l ) {
			$ret[] = mb_substr( $str, $i, $l, "UTF-8" );
		}
		
		return $ret;
	}
	
	return preg_split( "//u", $str, - 1, PREG_SPLIT_NO_EMPTY );
}

//[0] => 一
//[1] => 切
//[2] => 皆
//[3] => 文
//[4] => 件
print_r( str_split_unicode( "一切皆文件" ) );
//[0] => 一切皆
//[1] => 文件
print_r( str_split_unicode( "一切皆文件", 3 ) );
//[0] => 一�
//[1] => ���
//[2] => �文
//[3] => 件
print_r( str_split( "一切皆文件", 4 ) );

////////////////////////////////////////////////////////////////
$spl1 = str_split( "Long" );
echo count( $spl1 ) . PHP_EOL; // 4
//[0] => L
//[1] => o
//[2] => n
//[3] => g
print_r( $spl1 );

$spl2 = str_split( "X" );//1
echo count( $spl2 ) . PHP_EOL;
//[0] => X
print_r( $spl2 );

$spl3 = str_split( "" );
echo count( $spl3 ) . PHP_EOL;//1
//[0] =>
print_r( $spl3 );

$spl4 = str_split( 23 );
echo count( $spl4 ) . PHP_EOL;//2
//[0] => 2
//[1] => 3
print_r( $spl4 );

$spl5 = str_split( 2.3 );
echo count( $spl5 ) . PHP_EOL;//3
//[0] => 2
//[1] => .
//[2] => 3
print_r( $spl5 );

$spl6 = str_split( true );
echo count( $spl6 ) . PHP_EOL;//1
//[0] => 1
print_r( $spl6 );

$spl7 = str_split( null );
echo count( $spl7 ) . PHP_EOL;//1
//[0] =>
print_r( $spl7 );

```

## See
- <http://php.net/manual/zh/function.str_split.php>

### *All rights reserved*
