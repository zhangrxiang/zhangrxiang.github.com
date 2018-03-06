# str_pad
> - (PHP 4 >= 4.0.1, PHP 5, PHP 7)
> - str_pad — Pad a string to a certain length with another string
> - str_pad — 使用另一个字符串填充字符串为指定长度

## Description
```php
string str_pad ( 
    string $input , 
    int $pad_length [, 
    string $pad_string = " " [, 
    int $pad_type = STR_PAD_RIGHT ]] 
)
//This function returns the input string padded on the left, the right, or both sides to the specified padding length. If the optional argument pad_string is not supplied, the input is padded with spaces, otherwise it is padded with characters from pad_string up to the limit.
//该函数返回 input 被从左端、右端或者同时两端被填充到制定长度后的结果。如果可选的 pad_string 参数没有被指定，input 将被空格字符填充，否则它将被 pad_string 填充到指定长度。

```

## Parameters
### input
- The input string.
- 输入字符串。

### pad_length
- If the value of pad_length is negative, less than, or equal to the length of the input string, no padding takes place, and input will be returned.
- 如果 pad_length 的值是负数，小于或者等于输入字符串的长度，不会发生任何填充，并会返回 input 。

### pad_string
Note:
> - The pad_string may be truncated if the required number of padding characters can't be evenly divided by the pad_string's length.
> - 如果填充字符的长度不能被 pad_string 整除，那么 pad_string 可能会被缩短。

### pad_type
- Optional argument pad_type can be STR_PAD_RIGHT, STR_PAD_LEFT, or STR_PAD_BOTH. If pad_type is not specified it is assumed to be STR_PAD_RIGHT.
- 可选的 pad_type 参数的可能值为 `STR_PAD_RIGHT`，`STR_PAD_LEFT` 或 `STR_PAD_BOTH`。如果没有指定 pad_type，则假定它是 `STR_PAD_RIGHT`。


## Return Values
- Returns the padded string.
- 返回填充后的字符串。

## Examples
```
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/19
 * Time: 下午10:59
 */

//function str_pad ($input, $pad_length, $pad_string = null, $pad_type = null) {}

$input = "zing";
$str   = str_pad( $input, 10 );
//"zing      "
echo $str . PHP_EOL;
//10
echo strlen( $str ) . PHP_EOL;

//zing******
echo str_pad( $input, 10, "*" ) . PHP_EOL;

//^^^^^^zing
echo str_pad( $input, 10, "^", STR_PAD_LEFT ) . PHP_EOL;  // 输出 "-=-=-Alien"

//___zing___
echo str_pad( $input, 10, "_", STR_PAD_BOTH ) . PHP_EOL;

//zing=
echo str_pad( $input, 5, "==" ) . PHP_EOL;

//zing
echo str_pad( $input, 3, "-" ) . PHP_EOL;

//////////////////////////////////////////////////////////////
/**
 * since the default pad_type is STR_PAD_RIGHT.
 * using STR_PAD_BOTH were always favor in the right pad
 * if the required number of padding characters can't be evenly divided.
 */

//ppinputppp
echo str_pad( "input", 10, "pp", STR_PAD_BOTH ) . PHP_EOL;
//inputp
echo str_pad( "input", 6, "p", STR_PAD_BOTH ) . PHP_EOL;
//pinputpp
echo str_pad( "input", 8, "p", STR_PAD_BOTH ) . PHP_EOL;


/////////////////////////////////////////////////////////////
function str_pad_unicode( $str, $pad_len, $pad_str = ' ', $dir = STR_PAD_RIGHT ) {
	$str_len     = mb_strlen( $str );
	$pad_str_len = mb_strlen( $pad_str );
	if ( ! $str_len && ( $dir == STR_PAD_RIGHT || $dir == STR_PAD_LEFT ) ) {
		$str_len = 1; // @debug
	}
	if ( ! $pad_len || ! $pad_str_len || $pad_len <= $str_len ) {
		return $str;
	}
	
	$result = null;
	$repeat = ceil( $str_len - $pad_str_len + $pad_len );
	if ( $dir == STR_PAD_RIGHT ) {
		$result = $str . str_repeat( $pad_str, $repeat );
		$result = mb_substr( $result, 0, $pad_len );
	} else if ( $dir == STR_PAD_LEFT ) {
		$result = str_repeat( $pad_str, $repeat ) . $str;
		$result = mb_substr( $result, - $pad_len );
	} else if ( $dir == STR_PAD_BOTH ) {
		$length = ( $pad_len - $str_len ) / 2;
		$repeat = ceil( $length / $pad_str_len );
		$result = mb_substr( str_repeat( $pad_str, $repeat ), 0, floor( $length ) )
		          . $str
		          . mb_substr( str_repeat( $pad_str, $repeat ), 0, ceil( $length ) );
	}
	
	return $result;
}

$str = "拍黄片";
//哈拍黄片哈
echo str_pad_unicode( $str, 5, '哈', STR_PAD_BOTH ) . PHP_EOL;
//哈哈哈拍黄片哈哈哈哈
echo str_pad_unicode( $str, 10, '哈', STR_PAD_BOTH ) . PHP_EOL;

function mb_str_pad( $str, $pad_len, $pad_str = ' ', $dir = STR_PAD_RIGHT, $encoding = null ) {
	$encoding       = $encoding === null ? mb_internal_encoding() : $encoding;
	$padBefore      = $dir === STR_PAD_BOTH || $dir === STR_PAD_LEFT;
	$padAfter       = $dir === STR_PAD_BOTH || $dir === STR_PAD_RIGHT;
	$pad_len        -= mb_strlen( $str, $encoding );
	$targetLen      = $padBefore && $padAfter ? $pad_len / 2 : $pad_len;
	$strToRepeatLen = mb_strlen( $pad_str, $encoding );
	$repeatTimes    = ceil( $targetLen / $strToRepeatLen );
	$repeatedString = str_repeat( $pad_str, max( 0, $repeatTimes ) ); // safe if used with valid utf-8 strings
	$before         = $padBefore ? mb_substr( $repeatedString, 0, floor( $targetLen ), $encoding ) : '';
	$after          = $padAfter ? mb_substr( $repeatedString, 0, ceil( $targetLen ), $encoding ) : '';
	
	return $before . $str . $after;
}

//哈拍黄片哈
echo mb_str_pad( $str, 5, '哈', STR_PAD_BOTH ) . PHP_EOL;
//哈哈哈拍黄片哈哈哈哈
echo mb_str_pad( $str, 10, '哈', STR_PAD_BOTH ) . PHP_EOL;

///////////////////////////////////////////////////////////////////////
function pad_between_strings( $string1, $string2, $length, $char = " " ) {
	$fill_length = $length - ( strlen( $string1 ) + strlen( $string2 ) );
	
	return $string1 . str_repeat( $char, $fill_length ) . $string2;
}

//abc**************123
echo pad_between_strings( "abc", "123", 20, "*" ) . PHP_EOL;
```

## See
- <http://php.net/manual/zh/function.str_pad.php>

### *All rights reserved*