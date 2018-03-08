# tail
## NAME      
> tail - output the last part of files

## SYNOPSIS         
> tail [OPTION]... [FILE]...

## DESCRIPTION         
- Print the last `10` lines of each `FILE` to standard output.  With morethan one `FILE`, precede each with a header giving the file name. With no `FILE`, or when `FILE` is `-`, read standard input.Mandatory arguments to long options are mandatory for short options too.
- 输入文件中的尾部内容。tail命令默认在屏幕上显示指定文件的末尾10行。如果给定的文件不止一个，则在显示的每个文件前面加一个文件名标题。如果没有指定文件或者文件名为“-”，则读取标准输入。

### `-c, --bytes=[+]NUM`
- output the last `NUM` bytes; or use `-c +NUM` to output starting with byte `NUM` of each file
- 输出文件尾部的N（N为整数）个字节内容

### `-f, --follow[={name|descriptor}]`
- output appended data as the file grows;an absent option argument means 'descriptor'
- 显示文件最新追加的内容。“name”表示以文件名的方式监视文件的变化。“-f”与“-fdescriptor”等效

### `-F`
- same as `--follow=name` `--retry`

### `-n, --lines=[+]NUM`
- output the last NUM lines, instead of the last 10; or use `-n +NUM` to output starting with line NUM
- 输出文件的尾部N（N位数字）行内容

### `--max-unchanged-stats=N`
- with `--follow=name`, reopen a `FILE` which has not changed size after `N` (default `5`) iterations to see if it has
been unlinked or renamed (this is the usual case of rotated log files); with inotify, this option is rarely useful

### `--pid=PID`
- with `-f`, terminate after process `ID`, `PID` dies

### `-q, --quiet, --silent`
- never output headers giving file names

### `--retry`
- keep trying to open a file if it is inaccessible
- 即是在tail命令启动时，文件不可访问或者文件稍后变得不可访问，都始终尝试打开文件。使用此选项时需要与选项“——follow=name”连用

### `-s, --sleep-interval=N`
- with `-f`, sleep for approximately `N` seconds (default 1.0) between iterations; with inotify and `--pid=P`, check process P at least once every `N` seconds
- 与“-f”选项连用，指定监视文件变化时间隔的秒数

### `-v, --verbose`
- always output headers giving file names
- 当有多个文件参数时，总是输出各个文件名

### `-z, --zero-terminated`
- line delimiter is `NUL`, not `newline`

### `--help` 
- display this help and exit

### `--version`
- output version information and exit

> - `NUM` may have a multiplier suffix: b 512, kB 1000, K 1024, MB 1000*1000, M 1024*1024, 
GB 1000*1000*1000, G 1024*1024*1024, and so on for T, P, E, Z, Y.

> - With `--follow` (`-f`), tail defaults to following the file descriptor,which means that even if a tail'ed file is renamed, tail will continue to track its end.  This default behavior is not desirable when you really want to track the actual name of the file, not thefile descriptor (e.g., log rotation).  Use `--follow=name` in thatcase.That causes tail to track the named file in a way that accommodates renaming, removal and creation.

## See
- <https://linux.die.net/man/1/tail>

### *All rights reserved*
