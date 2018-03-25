# implode

> - (PHP 4, PHP 5, PHP 7)
> - implode — Join array elements with a string
> - implode — 将一个一维数组的值转化为字符串

## Description
```php
string implode ( string $glue , array $pieces )
string implode ( array $pieces )
//Join array elements with a glue string.
//用 glue 将一维数组的值连接为一个字符串。

```
Note:

> - implode() can, for historical reasons, accept its parameters in either order. For consistency with explode(), however, it may be less confusing to use the documented order of arguments.
> - 因为历史原因，implode() 可以接收两种参数顺序，但是 explode() 不行。不过按文档中的顺序可以避免混淆。

## Parameters
### glue
- Defaults to an empty string.
- 默认为空的字符串。

### pieces
- The array of strings to implode.
- 你想要转换的数组。

## Return Values
- Returns a string containing a string representation of all the array elements in the same order, with the glue string between each element.
- 返回一个字符串，其内容为由 glue 分割开的数组的值。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/17
 * Time: 下午10:52
 */

$array           = array( '`lastname`', '`email`', '`phone`' );
$comma_separated = implode( ",", $array );
//`lastname`,`email`,`phone`
echo $comma_separated . PHP_EOL;

// Empty string when using an empty array:
echo '-------------------------' . PHP_EOL;
print_r( implode( 'hello', array() ) ); // string(0) ""
echo '-------------------------' . PHP_EOL;

$id_nums  = array( 1, 6, 12, 18, 24 );
$id_nums  = implode( ", ", $id_nums );
$sqlquery = "Select `name`,email,phone from `usertable` where user_id IN ($id_nums)";
//Select `name`,email,phone from `usertable` where user_id IN (1, 6, 12, 18, 24)
echo $sqlquery . PHP_EOL;
$sqlquery = "Select $comma_separated from `usertable` where user_id IN ($id_nums)";
//Select `lastname`,`email`,`phone` from `usertable` where user_id IN (1, 6, 12, 18, 24)
echo $sqlquery . PHP_EOL;

$ar = array( "hello", null, "world" );
echo implode( ',', $ar ) . PHP_EOL; // hello,,world

$picnames = array( "pic1.jpg", "pic2.jpg", "pic3.jpg", "pic4.jpg", "pic5.jpg", "pic6.jpg", "pic7.jpg" );
$allpics  = implode( "|", array_slice( $picnames, 0, 5 ) );
//pic1.jpg|pic2.jpg|pic3.jpg|pic4.jpg|pic5.jpg
echo $allpics . PHP_EOL;

$test = implode( [ "one", 2, 3, "four", 5.67 ] );
echo $test . PHP_EOL;//one23four5.67

/////////////////////////////////////////////////////////////////////////////////////
class Foo {
	protected $title;
	
	public function __construct( $title ) {
		$this->title = $title;
	}
	
	public function __toString() {
		return $this->title;
	}
}

$array = [
	new Foo( 'foo' ),
	new Foo( 'bar' ),
	new Foo( 'qux' )
];

//foo; bar; qux
echo implode( '; ', $array );
```


## See
- <http://php.net/manual/en/function.implode.php>

### *All rights reserved*