# mb_convert_variables
> - (PHP 4 >= 4.0.6, PHP 5, PHP 7)
> - mb_convert_variables — Convert character code in variable(s)
> - mb_convert_variables — 转换一个或多个变量的字符编码

## Description
```php
string mb_convert_variables ( string $to_encoding , mixed $from_encoding , mixed &$vars [, mixed &$... ] )
//Converts character encoding of variables vars in encoding from_encoding to encoding to_encoding.
//将变量 vars 的编码从 from_encoding 转换成编码 to_encoding。
//mb_convert_variables() join strings in Array or Object to detect encoding, since encoding detection tends to fail for short strings. Therefore, it is impossible to mix encoding in single array or object.
//mb_convert_variables() 会拼接变量数组或对象中的字符串来检测编码，因为短字符串的检测往往会失败。因此，不能在一个数组或对象中混合使用编码。
```

## Parameters
### to_encoding
- The encoding that the string is being converted to.
- 将 string 转换成这个编码。

### from_encoding
- from_encoding is specified as an array or comma separated string, it tries to detect encoding from from-coding. When from_encoding is omitted, detect_order is used.
- from_encoding 可以指定为一个 array 或者逗号分隔的 string，它将尝试根据 from-coding 来检测编码。 当省略了 from_encoding，将使用 detect_order。

### vars
- vars is the reference to the variable being converted. String, Array and Object are accepted. mb_convert_variables() assumes all parameters have the same encoding.
- vars 是要转换的变量的引用。 参数可以接受 String、Array 和 Object 的类型。 mb_convert_variables() 假设所有的参数都具有同样的编码。

### ...
- Additional vars.
- 额外的 vars。

## Return Values
- The character encoding before conversion for success, or FALSE for failure.
- 成功时返回转换前的字符编码，失败时返回 FALSE。

## Examples

```php
<?php
/**
 * Created by PhpStorm.
 * User: zhang
 * Date: 2018/1/29
 * Time: 16:29
 */

/* 转换变量 $post1、$post2 编码为内部（internal）编码 */
$post1 = "hello";
$post2 = "中国";
echo $post2 . PHP_EOL;
$interenc = mb_internal_encoding();
echo $interenc.PHP_EOL;
$inputenc = mb_convert_variables( $interenc,
	"ASCII,UTF-8,SJIS-win",
	$post1,
	$post2 );
if ( $inputenc ) {
	echo $post1 . PHP_EOL;
	echo $post2 . PHP_EOL;
}

```