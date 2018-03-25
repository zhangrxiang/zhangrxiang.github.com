# Redis String
## String（字符串）
string是redis最基本的类型，你可以理解成与Memcached一模一样的类型，一个key对应一个value。

string类型是二进制安全的。意思是redis的string可以包含任何数据。比如jpg图片或者序列化的对象 。

string类型是Redis最基本的数据类型，一个键最大能存储512MB。

### 应用场景：
String是最常用的一种数据类型，普通的key/ value 存储都可以归为此类.即可以完全实现目前 Memcached 的功能，并且效率更高。还可以享受Redis的定时持久化，操作日志及 Replication等功能。除了提供与 Memcached 一样的get、set、incr、decr 等操作外，Redis还提供了下面一些操作：

- 获取字符串长度
- 往字符串append内容
- 设置和获取字符串的某一段内容
- 设置及获取字符串的某一位（bit）
- 批量设置一系列字符串的内容

### command
- `APPEND key value`
> - summary: Append a value to a key
> - since: 2.0.0

- `BITCOUNT key [start] [end]`
> - summary: Count set bits in a string
> - since: 2.6.0

- `BITOP operation destkey key [key ...]`
> - summary: Perform bitwise operations between strings
> - since: 2.6.0

- `BITPOS key bit [start] [end]`
> - summary: Find first bit set or clear in a string
> - since: 2.8.7

- `DECR key`
> - summary: Decrement the integer value of a key by one
> - since: 1.0.0

- `DECRBY key decrement`
> - summary: Decrement the integer value of a key by the given number
> - since: 1.0.0

- `GET key`
> - summary: Get the value of a key
> - since: 1.0.0

- `GETBIT key offset`
> - summary: Returns the bit value at offset in the string value stored at key
> - since: 2.2.0

- `GETRANGE key start end`
> - summary: Get a substring of the string stored at a key
> - since: 2.4.0

- `GETSET key value`
> - summary: Set the string value of a key and return its old value
> - since: 1.0.0

- `INCR key`
> - summary: Increment the integer value of a key by one
> - since: 1.0.0

- `INCRBY key increment`
> - summary: Increment the integer value of a key by the given amount
> - since: 1.0.0

- `INCRBYFLOAT key increment`
> - summary: Increment the float value of a key by the given amount
> - since: 2.6.0

- `MGET key [key ...]`
> - summary: Get the values of all the given keys
> - since: 1.0.0

- `MSET key value [key value ...]`
> - summary: Set multiple keys to multiple values
> - since: 1.0.1

- `MSETNX key value [key value ...]`
> - summary: Set multiple keys to multiple values, only if none of the keys exist
> - since: 1.0.1

- `PSETEX key milliseconds value`
> - summary: Set the value and expiration in milliseconds of a key
> - since: 2.6.0

- `SET key value [EX seconds] [PX milliseconds] [NX|XX]`
> - summary: Set the string value of a key
> - since: 1.0.0

- `SETBIT key offset value`
> - summary: Sets or clears the bit at offset in the string value stored at key
> - since: 2.2.0

- `SETEX key seconds value`
> - summary: Set the value and expiration of a key
> - since: 2.0.0

- `SETNX key value`
> - summary: Set the value of a key, only if the key does not exist
> - since: 1.0.0

- `SETRANGE key offset value`
> - summary: Overwrite part of a string at key starting at the specified offset
> - since: 2.2.0

- `STRLEN key`
> - summary: Get the length of the value stored in a key
> - since: 2.2.0
