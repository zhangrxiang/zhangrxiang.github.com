# mb_convert_case

> - (PHP 4 >= 4.3.0, PHP 5, PHP 7)
> - mb_convert_case — Perform case folding on a string
> - mb_convert_case — 对字符串进行大小写转换

## Description
```php
string mb_convert_case ( string $str , int $mode [, string $encoding = mb_internal_encoding() ] )
//Performs case folding on a string, converted in the way specified by mode.
//对一个 string 进行大小写转换，转换模式由 mode 指定。

```
## Parameters
### str
- The string being converted.
- 要被转换的 string。

### mode
- The mode of the conversion. It can be one of MB_CASE_UPPER, MB_CASE_LOWER, or MB_CASE_TITLE.
- 转换的模式。它可以是 `MB_CASE_UPPER`、 `MB_CASE_LOWER` 和 `MB_CASE_TITLE` 的其中一个。

### encoding
- The encoding parameter is the character encoding. If it is omitted, the internal character encoding value will be used.
- encoding 参数为字符编码。如果省略，则使用内部字符编码。


## Return Values
- A case folded version of string converted in the way specified by mode.
- 按 mode 指定的模式转换 string 大小写后的版本。
 
## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/1/28
 * Time: 下午3:16
 */

/**Example #1 mb_convert_case() 例子*/
$str = "mary had a Little lamb and she loved it so";
$str = mb_convert_case( $str, MB_CASE_UPPER, "UTF-8" ) . PHP_EOL;
echo $str; // 输出 MARY HAD A LITTLE LAMB AND SHE LOVED IT SO
$str = mb_convert_case( $str, MB_CASE_TITLE, "UTF-8" ) . PHP_EOL;
echo $str; // 输出 Mary Had A Little Lamb And She Loved It So

/**Example #2 非拉丁 UTF-8 文本的mb_convert_case() 例子*/
$str = "Τάχιστη αλώπηξ βαφής ψημένη γη, δρασκελίζει υπέρ νωθρού κυνός";
$str = mb_convert_case( $str, MB_CASE_UPPER, "UTF-8" ) . PHP_EOL;
echo $str; // 输出 ΤΆΧΙΣΤΗ ΑΛΏΠΗΞ ΒΑΦΉΣ ΨΗΜΈΝΗ ΓΗ, ΔΡΑΣΚΕΛΊΖΕΙ ΥΠΈΡ ΝΩΘΡΟΎ ΚΥΝΌΣ
$str = mb_convert_case( $str, MB_CASE_TITLE, "UTF-8" ) . PHP_EOL;
echo $str; // 输出 Τάχιστη Αλώπηξ Βαφήσ Ψημένη Γη, Δρασκελίζει Υπέρ Νωθρού Κυνόσ

/**
 * mb_strtolower() - 使字符串小写
 * mb_strtoupper() - 使字符串大写
 * strtolower() - 将字符串转化为小写
 * strtoupper() - 将字符串转化为大写
 * ucfirst() - 将字符串的首字母转换为大写
 * ucwords() - 将字符串中每个单词的首字母转换为大写
 */

echo mb_convert_case( 'AAA "aaa"', MB_CASE_TITLE ) . PHP_EOL; //Aaa "aaa"
// but  I want this ===> AAA "Aaa"

function mb_convert_case_utf8_variation( $s ) {
	$arr    = preg_split( "//u", $s, - 1, PREG_SPLIT_NO_EMPTY );
	var_dump($arr);
	$result = "";
	$mode   = false;
	foreach ( $arr as $char ) {
		$res = preg_match(
			       '/\\p{Mn}|\\p{Me}|\\p{Cf}|\\p{Lm}|\\p{Sk}|\\p{Lu}|\\p{Ll}|' .
			       '\\p{Lt}|\\p{Sk}|\\p{Cs}/u', $char ) == 1;
		if ( $mode ) {
			if ( ! $res ) {
				$mode = false;
			}
		} elseif ( $res ) {
			$mode = true;
			$char = mb_convert_case( $char, MB_CASE_TITLE, "UTF-8" );
		}
		$result .= $char;
	}
	
	return $result;
}

echo mb_convert_case_utf8_variation('AAA "aaa"').PHP_EOL;
//AAA "Aaa"

echo mb_convert_case("Hello 中国",MB_CASE_UPPER).PHP_EOL;//HELLO 中国
echo mb_convert_case("Hello 中国",MB_CASE_UPPER,"GBK").PHP_EOL;//HELLO 中国

```

## Extension

### Unicode
- By contrast to the standard case folding functions such as strtolower() and strtoupper(), case folding is         performed on the basis of the Unicode character properties. Thus the behaviour of this function is not affected   by locale settings and it can convert any characters that have 'alphabetic' property, such as A-umlaut (Ä).
- 和类似 strtolower()、strtoupper() 的标准大小写转换函数相比， 大小写转换的执行根据 Unicode 字符属性的基础。 因此此函数的行为不受    语言环境（locale）设置的影响，能够转换任意具有“字母”属性的字符，例如元音变音A（Ä）
- For more information about the Unicode properties, please see » http://www.unicode.org/unicode/reports/tr21/.
- 更多关于 Unicode 属性的信息，请查看 » http://www.unicode.org/unicode/reports/tr21/。

#### UTF-8 编码规则
- 对于单字节的符号，字节的第一位设为0，后面7位为这个符号的 Unicode 码。
因此对于英语字母，UTF-8 编码和 ASCII 码是相同的。

- 对于n字节的符号（n > 1），第一个字节的前n位都设为1，第n + 1位设为0，
后面字节的前两位一律设为10。剩下的没有提及的二进制位，全部为这个符号的 Unicode 码。

```
Unicode符号范围     |        UTF-8编码方式
(十六进制)          |              （二进制）
----------------------+---------------------------------------------
0000 0000-0000 007F | 0xxxxxxx
0000 0080-0000 07FF | 110xxxxx 10xxxxxx
0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
```
跟据上表，解读 UTF-8 编码非常简单。如果一个字节的第一位是0，则这个字节
单独就是一个字符；如果第一位是1，则连续有多少个1，就表示当前字符占用多少个字节。
因为多字节的utf-8编码值的前一位都是以1开头。  


## 文章参考
- <http://php.net/manual/en/function.mb-convert-case.php>