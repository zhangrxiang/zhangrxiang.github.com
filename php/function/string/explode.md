# explode
> - (PHP 4, PHP 5, PHP 7)
> - explode — Split a string by string
> - explode — 使用一个字符串分割另一个字符串

## Description
```php
array explode ( 
    string $delimiter , 
    string $string [, 
    int $limit = PHP_INT_MAX ] 
    )
//Returns an array of strings, each of which is a substring of string formed by splitting it on boundaries formed by the string delimiter.
//此函数返回由字符串组成的数组，每个元素都是 string 的一个子串，它们被字符串 delimiter 作为边界点分割出来。
```

## Parameters
### delimiter
- The boundary string.
- 边界上的分隔字符。

### string
- The input string.
- 输入的字符串。

### limit
- If limit is set and positive, the returned array will contain a maximum of limit elements with the last element containing the rest of string.
- 如果设置了 limit 参数并且是正数，则返回的数组包含最多 limit 个元素，而最后那个元素将包含 string 的剩余部分。

- If the limit parameter is negative, all components except the last -limit are returned.
- 如果 limit 参数是负数，则返回除了最后的 -limit 个元素外的所有元素。

- If the limit parameter is zero, then this is treated as 1.
- 如果 limit 是 0，则会被当做 1。

Note:
> - Although implode() can, for historical reasons, accept its parameters in either order, explode() cannot. You must ensure that the delimiter argument comes before the string argument.
> - 由于历史原因，虽然 implode() 可以接收两种参数顺序，但是 explode() 不行。你必须保证 separator 参数在 string 参数之前才行。


## Return Values
- Returns an array of strings created by splitting the string parameter on boundaries formed by the delimiter.
- 此函数返回由字符串组成的 array，每个元素都是 string 的一个子串，它们被字符串 delimiter 作为边界点分割出来。

- If delimiter is an empty string (""), explode() will return FALSE. If delimiter contains a value that is not contained in string and a negative limit is used, then an empty array will be returned, otherwise an array containing string will be returned.
- 如果 delimiter 为空字符串（""），explode() 将返回 FALSE。 如果 delimiter 所包含的值在 string 中找不到，并且使用了负数的 limit ， 那么会返回空的 array， 否则返回包含 string 单个元素的数组。

## Example
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/16
 * Time: 下午3:49
 */
// 示例 1
$pizza  = "piece1 piece2 piece3 piece4 piece5 piece6";
$pieces = explode( " ", $pizza );
echo $pieces[0] . PHP_EOL; // piece1
echo $pieces[1] . PHP_EOL; // piece2

// 示例 2
$data = "foo:*:1023:1000::/home/foo:/bin/sh";
list( $user, $pass, $uid, $gid, $gecos, $home, $shell ) = explode( ":", $data );
echo $user . PHP_EOL; // foo
echo $pass . PHP_EOL; // *
print_r( explode( ';', $data ) );//    [0] => foo:*:1023:1000::/home/foo:/bin/sh

$str = 'one|two|three|four';
// 正数的 limit
//[0] => one
//[1] => two|three|four
print_r( explode( '|', $str, 2 ) );
// 负数的 limit（自 PHP 5.1 起）
//[0] => one
//[1] => two
//[2] => three
//如果 limit 参数是负数，则返回除了最后的 -limit 个元素外的所有元素。
print_r( explode( '|', $str, - 1 ) );

$path = '/Users/zhangrongxiang/WorkSpace/phpProjects/PHPTEST';
//[0] =>
//[1] => Users
//[2] => zhangrongxiang
//[3] => WorkSpace
//[4] => phpProjects
//[5] => PHPTEST
$rs = explode( '/', $path );
print_r( $rs );

//[0] =>
//[1] => Users
//[2] => zhangrongxiang/WorkSpace/phpProjects/PHPTEST
$rs = explode( '/', $path, 3 );
print_r( $rs );

//[0] =>
//[1] => Users
//[2] => zhangrongxiang
$rs = explode( '/', $path, - 3 );
print_r( $rs );

/////////////////////////////////////////////////////////////////////////////////////
function multiexplode( $delimiters, $string ) {
	$ready = str_replace( $delimiters, $delimiters[0], $string );
	//here is a sample, this text, and this will be exploded, this also , this one too ,)
	echo $ready . PHP_EOL;
	$launch = explode( $delimiters[0], $ready );
	
	return $launch;
}

//[0] => here is a sample
//[1] =>  this text
//[2] =>  and this will be exploded
//[3] =>  this also
//[4] =>  this one too
//[5] => )
$text     = "here is a sample: this text, and this will be exploded. this also | this one too :)";
$exploded = multiexplode( array( ",", ".", "|", ":" ), $text );
print_r( $exploded );


/////////////////////////////////////////////////////////////////////////////////////
$str = "";
$res = explode( ",", $str );
//Array
//(
//	[0] =>
//)
print_r( $res );
$res = array_filter( explode( ",", $str ) );
//Array
//(
//)
print_r( $res );

/////////////////////////////////////////////////////////////////////////////////////
//a simple one line method to explode & trim whitespaces from the exploded elements
array_map( 'trim', explode( ",", $str ) );
$str = "one  ,two  ,       three  ,  four    ";
//[0] => one
//[1] => two
//[2] => three
//[3] => four
print_r( array_map( 'trim', explode( ",", $str ) ) );

/////////////////////////////////////////////////////////////////////////////////////
//the function
//Param 1 has to be an Array
//Param 2 has to be a String
function multiexplode2( $delimiters, $string ) {
	$ary = explode( $delimiters[0], $string );
	array_shift( $delimiters );
	if ( $delimiters != null ) {
		foreach ( $ary as $key => $val ) {
			$ary[ $key ] = multiexplode2( $delimiters, $val );
		}
	}
	
	return $ary;
}

// Example of use
$string     = "1-2-3|4-5|6:7-8-9-0|1,2:3-4|5";
$delimiters = Array( ",", ":", "|", "-" );

$res = multiexplode2( $delimiters, $string );
print_r( $res );

```

## See
- <http://php.net/manual/en/function.explode.php>

### *All rights reserved*