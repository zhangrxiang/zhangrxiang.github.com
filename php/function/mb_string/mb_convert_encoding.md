# mb_convert_encoding
> - (PHP 4 >= 4.0.6, PHP 5, PHP 7)
> - mb_convert_encoding — Convert character encoding
> - mb_convert_encoding — 转换字符的编码

## Description
```php
string mb_convert_encoding ( string $str , string $to_encoding [, mixed $from_encoding = mb_internal_encoding() ] )
//Converts the character encoding of string str to to_encoding from optionally from_encoding.
```

## Parameters
### str
- The string being encoded.
- 要编码的 string。

### to_encoding
- The type of encoding that str is being converted to.
- str 要转换成的编码类型。

## from_encoding
- Is specified by character code names before conversion. It is either an array, or a comma separated enumerated list. If from_encoding is not specified, the internal encoding will be used.
- 在转换前通过字符代码名称来指定。它可以是一个 array 也可以是逗号分隔的枚举列表。 如果没有提供 from_encoding，则会使用内部（internal）编码。

## Return Values
- The encoded string.
- 编码后的 string。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/1/28
 * Time: 下午10:34
 */

$str = "Hello World\n";
/* Convert internal character encoding to SJIS */
$str = mb_convert_encoding( $str, "SJIS" );
echo "1---" . $str; //1---Hello World

$str = "Hello World\n";
/* Convert EUC-JP to UTF-7 */
$str = mb_convert_encoding( $str, "UTF-7", "EUC-JP" );
echo "2---" . $str; //2---Hello World

$str = "Hello World\n";
/* Auto detect encoding from JIS, eucjp-win, sjis-win, then convert str to UCS-2LE */
$str = mb_convert_encoding( $str, "UCS-2LE", "JIS, eucjp-win, sjis-win" );
echo "3---" . $str; //3---H e l l o   W o r l d 

$str = "Hello World\n";
/* "auto" is expanded to "ASCII,JIS,UTF-8,EUC-JP,SJIS" */
$str = mb_convert_encoding( $str, "EUC-JP", "auto" );
echo "4---" . $str; /// 4---Hello World


/**遍历字符集 */
$text = "A strange string to pass, maybe with some ø, æ, å characters. Hello 中国";
foreach ( mb_list_encodings() as $chr ) {
	/**其他字符集转换成UTF-8输出*/
	echo $chr . " ：" . mb_convert_encoding( $text, 'UTF-8', $chr ) . PHP_EOL;
	/**UTF-8转换成其他字符集输出*/
	echo $chr . " ：" . mb_convert_encoding( $text, $chr, 'UTF-8' ) . PHP_EOL;
}

/**强制浏览器输出UTF-8编码字符串*/
header( "content-Type: text/html; charset=Utf-8" );//在所有输出之前输出有效
echo mb_convert_encoding( "你是我的好朋友", "UTF-8", "GBK" );

/**支持的字符编码*/
//UCS-4*
//UCS-4BE
//UCS-4LE*
//UCS-2
//UCS-2BE
//UCS-2LE
//UTF-32*
//UTF-32BE*
//UTF-32LE*
//UTF-16*
//UTF-16BE*
//UTF-16LE*
//UTF-7
//UTF7-IMAP
//UTF-8*
//ASCII*
//EUC-JP*
//SJIS*
//eucJP-win*
//SJIS-win*
//ISO-2022-JP
//ISO-2022-JP-MS
//CP932
//CP51932
//SJIS-mac** (别名： MacJapanese)
//SJIS-Mobile#DOCOMO** (别名： SJIS-DOCOMO)
//SJIS-Mobile#KDDI** (别名： SJIS-KDDI)
//SJIS-Mobile#SOFTBANK** (别名： SJIS-SOFTBANK)
//UTF-8-Mobile#DOCOMO** (别名： UTF-8-DOCOMO)
//UTF-8-Mobile#KDDI-A**
//UTF-8-Mobile#KDDI-B** (别名： UTF-8-KDDI)
//UTF-8-Mobile#SOFTBANK** (别名： UTF-8-SOFTBANK)
//ISO-2022-JP-MOBILE#KDDI** (别名： ISO-2022-JP-KDDI)
//JIS
//JIS-ms
//CP50220
//CP50220raw
//CP50221
//CP50222
//ISO-8859-1*
//ISO-8859-2*
//ISO-8859-3*
//ISO-8859-4*
//ISO-8859-5*
//ISO-8859-6*
//ISO-8859-7*
//ISO-8859-8*
//ISO-8859-9*
//ISO-8859-10*
//ISO-8859-13*
//ISO-8859-14*
//ISO-8859-15*
//ISO-8859-16*
//byte2be
//byte2le
//byte4be
//byte4le
//BASE64
//HTML-ENTITIES
//7bit
//8bit
//EUC-CN*
//CP936
//GB18030**
//HZ
//EUC-TW*
//CP950
//BIG-5*
//EUC-KR*
//UHC (CP949)
//ISO-2022-KR
//Windows-1251 (CP1251)
//Windows-1252 (CP1252)
//CP866 (IBM866)
//KOI8-R*
//KOI8-U*
//ArmSCII-8 (ArmSCII8)
// * 表示该编码也可以在正则表达式中使用。
// ** 表示该编码自 PHP 5.4.0 始可用。
//任何接受编码名称的 php.ini 条目同样也可以使用 "auto" 和 "pass" 的值。 接受编码名的 mbstring 函数同样也可以使用值 "auto"。
//如果设置了 "pass"，将不会对字符的编码进行转化。
//如果设置了 "auto"，它将扩展成 NLS 中定义的每个字符编码列表。 比如，假设 NLS 设置为 Japanese，值将会认为是 "ASCII,JIS,UTF-8,EUC-JP,SJIS"。

```

## 文章参考
- <http://php.net/manual/en/function.mb-convert-encoding.php>