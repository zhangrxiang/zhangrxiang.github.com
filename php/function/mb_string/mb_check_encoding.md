# mb_check_encoding
> - (PHP 4 >= 4.4.3, PHP 5 >= 5.1.3, PHP 7)
> - mb_check_encoding — Check if the string is valid for the specified encoding
> - mb_check_encoding — 检查字符串在指定的编码里是否有效

## Description
```php
bool mb_check_encoding ([ string $var = NULL [, string $encoding = mb_internal_encoding() ]] )
// Checks if the specified byte stream is valid for the specified encoding. 
// It is useful to prevent so-called "Invalid Encoding Attack".

// 检查指定的字节流在指定的编码里是否有效。它能有效避免所谓的“无效编码攻击（Invalid Encoding Attack）”。

```
## Parameters
### var
- The byte stream to check. If it is omitted, this function checks all the input from the beginning of the request.
- 要检查的字节流。如果省略了这个参数，此函数会检查所有来自最初请求所有的输入。

### encoding
- The expected encoding.
- 期望的编码。

## Return Values
- Returns TRUE on success or FALSE on failure.
- 成功时返回 TRUE， 或者在失败时返回 FALSE。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/1/27
 * Time: 下午2:59
 */

/**纯数字和英文字母组合*/
$utf8Str = "I have 4 books and 2 magazines to check out. ";
echo ( mb_check_encoding( $utf8Str, 'utf-8' ) ) . PHP_EOL; //输出1
echo ( mb_check_encoding( $utf8Str, 'gbk' ) ) . PHP_EOL; //输出1
echo bin2hex( $utf8Str ) . PHP_EOL;
//492068617665203420626f6f6b7320616e642032206d6167617a696e657320746f20636865636b206f75742e20
$gbkStr = mb_convert_encoding( $utf8Str, 'gbk', 'utf-8' );
echo bin2hex( $gbkStr ) . PHP_EOL;
//492068617665203420626f6f6b7320616e642032206d6167617a696e657320746f20636865636b206f75742e20

/**gbk编码的字符串  --> 设置文件编码为gbk*/
$str = '博客园和github。';
echo mb_check_encoding( $str, 'utf-8' ) . PHP_EOL;  //输出空
echo mb_check_encoding( $str, 'gbk' ) . PHP_EOL; //输出1

/**utf-8编码的字符串  --> 设置文件编码为utf-8*/
$str = '博客园和github。';
echo mb_check_encoding( $str, 'utf-8' ) . PHP_EOL;  //1
echo mb_check_encoding( $str, 'gbk' ) . PHP_EOL; //输出空

$utf8Str = '我abc是谁.';
echo mb_check_encoding( $utf8Str, 'utf-8' ) . PHP_EOL;  //输出1
//如果有中文标点符号则为空！！！
echo mb_check_encoding( $utf8Str, 'gbk' ) . PHP_EOL; //输出1

/**自定义检测字符串编码是否为utf-8*/
function is_utf8( $str ) {
	return (bool) preg_match( '//u', serialize($str) );
}

echo 'hello 中国!' .is_utf8( 'hello 中国!' ) . PHP_EOL; //1

function check_utf8( $str ) {
	$len = strlen( $str );
	for ( $i = 0; $i < $len; $i ++ ) {
		$c = ord( $str[ $i ] );
		if ( $c > 128 ) {
			if ( ( $c > 247 ) ) {
				return false;
			} elseif ( $c > 239 ) {
				$bytes = 4;
			} elseif ( $c > 223 ) {
				$bytes = 3;
			} elseif ( $c > 191 ) {
				$bytes = 2;
			} else {
				return false;
			}
			if ( ( $i + $bytes ) > $len ) {
				return false;
			}
			while ( $bytes > 1 ) {
				$i ++;
				$b = ord( $str[ $i ] );
				if ( $b < 128 || $b > 191 ) {
					return false;
				}
				$bytes --;
			}
		}
	}
	
	return true;
} // end of check_utf8

echo check_utf8("hello 中国").PHP_EOL; // 1
echo check_utf8( "\x00\xE3").PHP_EOL;  //空

/** check a strings encoded value */
function checkEncoding( $string, $string_encoding ) {
	$fs = $string_encoding == 'UTF-8' ? 'UTF-32' : $string_encoding;
	$ts = $string_encoding == 'UTF-32' ? 'UTF-8' : $string_encoding;
	
	return $string === mb_convert_encoding( mb_convert_encoding( $string, $fs, $ts ), $ts, $fs );
}

/* test 1 variables */
$string   = "\x00\x81";
$encoding = "Shift_JIS";

/* test 1 mb_check_encoding (test for bad byte stream) */
if ( true === mb_check_encoding( $string, $encoding ) ) {
	echo 'valid (' . $encoding . ') encoded byte stream!' . PHP_EOL;
} else {
	echo 'invalid (' . $encoding . ') encoded byte stream!' . PHP_EOL;
}

/* test 1 checkEncoding (test for bad byte sequence(s)) */
if ( true === checkEncoding( $string, $encoding ) ) {
	echo 'valid (' . $encoding . ') encoded byte sequence!' . PHP_EOL;
} else {
	echo 'invalid (' . $encoding . ') encoded byte sequence!' . PHP_EOL;
}

/* test 2 */
/* test 2 variables */
$string   = "\x00\xE3";
$encoding = "UTF-8";
/* test 2 mb_check_encoding (test for bad byte stream) */
if ( true === mb_check_encoding( $string, $encoding ) ) {
	echo 'valid (' . $encoding . ') encoded byte stream!' . PHP_EOL;
} else {
	echo 'invalid (' . $encoding . ') encoded byte stream!' . PHP_EOL;
}

/* test 2 checkEncoding (test for bad byte sequence(s)) */
if ( true === checkEncoding( $string, $encoding ) ) {
	echo 'valid (' . $encoding . ') encoded byte sequence!' . PHP_EOL;
} else {
	echo 'invalid (' . $encoding . ') encoded byte sequence!' . PHP_EOL;
}


```

## 文章参考
- <http://php.net/manual/zh/function.mb-check-encoding.php>