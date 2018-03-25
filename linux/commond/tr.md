# tr
## NAME
> - tr - translate or delete characters
> - 可以对来自标准输入的字符进行替换、压缩和删除。它可以将一组字符变成另一组字符，经常用来编写优美的单行命令，作用很强大。

## SYNOPSIS
> tr [OPTION]... SET1 [SET2]

### SET1
- 指定要转换或删除的原字符集。当执行转换操作时，必须使用参数“字符集2”指定转换的目标字符集。但执行删除操作时，不需要参数“字符集2”；

### SET2
- 指定要转换成的目标字符集。

## DESCRIPTION
> Translate, squeeze, and/or delete characters from standard input,writing to standard output.

### `-c, -C, --complement`
- use the complement of SET1
- 取代所有不属于第一字符集的字符

```shell
str="hello world"
# hello world
echo ${str}
# AAllAAAAAlA
echo ${str} | tr -c 'll\n' 'A'
# hello-world
echo ${str} | tr -c 'a-z\n' '-'
# hello-world
echo ${str} | tr -C 'a-z\n' '-'

```
### `-d, --delete`
- delete characters in SET1, do not translate
- 删除所有属于第一字符集的字符；

```bash
str="hello world"
# hello world
echo ${str}
# helloworld
echo ${str} | tr -d ' '
# he wrd
echo ${str} | tr -d 'llo'
```
### `-s, --squeeze-repeats`
- replace each sequence of a repeated character that is listed in the last specified SET, with a single occurrence of that character
- 把连续重复的字符以单独一个字符表示

```bash
str="thissss is      a text linnnnnnne."
# thissss is a text linnnnnnne.
echo ${str}
# this is a text line.
echo ${str} | tr -s ' sn'
```
### `-t, --truncate-set1`
- first truncate SET1 to length of SET2
- 先删除第一字符集较第二字符集多出的字符

```bash
str="hello world"
# hello world
echo ${str}
# heaao worad
echo ${str} | tr -t 'l' 'a'
# hello-world
echo ${str} | tr -t ' ' '-'
```
### `--help`
- display this help and exit

### `--version`
- output version information and exit

SETs are specified as strings of characters.  Most represent
themselves.  Interpreted sequences are:
```
\NNN   character with octal value NNN (1 to 3 octal digits)
\\     backslash
\a     audible BEL
\b     backspace
\f     form feed
\n     new line
\r     return
\t     horizontal tab
\v     vertical tab
CHAR1-CHAR2
        all characters from CHAR1 to CHAR2 in ascending order
[CHAR*]
        in SET2, copies of CHAR until length of SET1
[CHAR*REPEAT]
        REPEAT copies of CHAR, REPEAT octal if starting with 0
[:alnum:]
        all letters and digits
[:alpha:]
        all letters
[:blank:]
        all horizontal whitespace
[:cntrl:]
        all control characters
[:digit:]
        all digits
[:graph:]
        all printable characters, not including space
[:lower:]
        all lower case letters
[:print:]
        all printable characters, including space
[:punct:]
        all punctuation characters
[:space:]
        all horizontal or vertical whitespace
[:upper:]
        all upper case letters
[:xdigit:]
        all hexadecimal digits
[=CHAR=]
        all characters which are equivalent to CHAR
```
> Translation occurs if -d is not given and both SET1 and SET2 appear.`-t` may be used only when translating.  SET2 is extended to length of SET1 by repeating its last character as necessary.  Excess characters of SET2 are ignored.  Only `[:lower:]` and `[:upper:]` are guaranteed to expand in ascending order; used in SET2 while translating, they may only be used in pairs to specify case conversion.  -s uses the last specified SET, and occurs after translation or deletion.

## Example
```bash
#####################################################
# 字符集补集，从输入文本中将不在补集中的所有字符删除：
#  1  2  3  4
echo aa.,a 1 b#$bb 2 c*/cc 3 ddd 4 | tr -d -c '0-9 \n'

# 使用tr做数字相加操作：
# 45
echo 1 2 3 4 5 6 7 8 9 | xargs -n1 | echo $[ $(tr '\n' '+') 0 ]

# 除Windows文件“造成”的'^M'字符：
# cat file | tr -s "\r" "\n" > new_file
# cat file | tr -d "\r" > new_file
```
## See
- <http://man.linuxde.net/tr> 
- <http://man7.org/linux/man-pages/man1/tr.1.html> 

### *All rights reserved*
