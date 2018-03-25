# MySQL API

## C API Data Structures

- MYSQL
> This structure represents handler for one database connection. It is used for almost all MySQL functions. Do not try to make a copy of a MYSQL structure. There is no guarantee that such a copy will be usable.

- MYSQL_RES
> This structure represents the result of a query that returns rows (SELECT, SHOW, DESCRIBE, EXPLAIN). The information returned from a query is called the result set in the remainder of this section.

- MYSQL_ROW
> This is a type-safe representation of one row of data. It is currently implemented as an array of counted byte strings. (You cannot treat these as null-terminated strings if field values may contain binary data, because such values may contain null bytes internally.) Rows are obtained by calling mysql_fetch_row().

- MYSQL_FIELD
> This structure contains metadata: information about a field, such as the field's name, type, and size. Its members are described in more detail later in this section. You may obtain the MYSQL_FIELD structures for each field by calling mysql_fetch_field() repeatedly. Field values are not part of this structure; they are contained in a MYSQL_ROW structure.

- MYSQL_FIELD_OFFSET
> This is a type-safe representation of an offset into a MySQL field list. (Used by mysql_field_seek().) Offsets are field numbers within a row, beginning at zero.

- my_ulonglong
> - The type used for the number of rows and for mysql_affected_rows(), mysql_num_rows(), and mysql_insert_id(). This type provides a range of 0 to 1.84e19.
> - Some functions that return a row count using this type return -1 as an unsigned value to indicate an error or exceptional condition. You can check for -1 by comparing the return value to (my_ulonglong)-1 (or to (my_ulonglong)~0, which is equivalent).
> - On some systems, attempting to print a value of type my_ulonglong does not work. To print such a value, convert it to unsigned long and use a %lu print format. Example:
```c
printf ("Number of rows: %lu\n",
        (unsigned long) mysql_num_rows(result));
```

- my_bool
> - A boolean type, for values that are true (nonzero) or false (zero).
> - The MYSQL_FIELD structure contains the members described in the following list. The definitions apply primarily for columns of result sets such as those produced by SELECT statements. MYSQL_FIELD structures are also used to provide metadata for OUT and INOUT parameters returned from stored procedures executed using prepared CALL statements. For such parameters, some of the structure members have a meaning different from the meaning for column values.

- char * name
> The name of the field, as a null-terminated string. If the field was given an alias with an AS clause, the value of name is the alias. For a procedure parameter, the parameter name.

- char * org_name
> The name of the field, as a null-terminated string. Aliases are ignored. For expressions, the value is an empty string. For a procedure parameter, the parameter name.

- char * table
> The name of the table containing this field, if it is not a calculated field. For calculated fields, the table value is an empty string. If the column is selected from a view, table names the view. If the table or view was given an alias with an AS clause, the value of table is the alias. For a UNION, the value is the empty string. For a procedure parameter, the procedure name.

- char * org_table
> The name of the table, as a null-terminated string. Aliases are ignored. If the column is selected from a view, org_table names the view. For a UNION, the value is the empty string. For a procedure parameter, the procedure name.

- char * db
> The name of the database that the field comes from, as a null-terminated string. If the field is a calculated field, db is an empty string. For a UNION, the value is the empty string. For a procedure parameter, the name of the database containing the procedure.

- char * catalog
> The catalog name. This value is always "def".

- char * def
> The default value of this field, as a null-terminated string. This is set only if you use mysql_list_fields().

- unsigned long length
> - The width of the field. This corresponds to the display length, in bytes.
> - The server determines the length value before it generates the result set, so this is the minimum length required for a data type capable of holding the largest possible value from the result column, without knowing in advance the actual values that will be produced by the query for the result set.

- unsigned long max_length
> - The maximum width of the field for the result set (the length in bytes of the longest field value for the rows actually in the result set). If you use mysql_store_result() or mysql_list_fields(), this contains the maximum length for the field. If you use mysql_use_result(), the value of this variable is zero.
> - The value of max_length is the length of the string representation of the values in the result set. For example, if you retrieve a FLOAT column and the “widest” value is -12.345, max_length is 7 (the length of '-12.345').
> - If you are using prepared statements, max_length is not set by default because for the binary protocol the lengths of the values depend on the types of the values in the result set. (See Section 23.8.9, “C API Prepared Statement Data Structures”.) If you want the max_length values anyway, enable the STMT_ATTR_UPDATE_MAX_LENGTH option with mysql_stmt_attr_set() and the lengths will be set when you call mysql_stmt_store_result(). (See Section 23.8.11.3, “mysql_stmt_attr_set()”, and Section 23.8.11.28, “mysql_stmt_store_result()”.)

- unsigned int name_length
> The length of name.

- unsigned int org_name_length
> The length of org_name.

- unsigned int table_length
> The length of table.

- unsigned int org_table_length
> The length of org_table.

- unsigned int db_length
> The length of db.

- unsigned int catalog_length
> The length of catalog.

- unsigned int def_length
> The length of def.

- unsigned int flags
> Bit-flags that describe the field. The flags value may have zero or more of the bits set that are shown in the following table.

## C API Function Overview
```c
my_init()
//Initialize global variables, and thread handler in thread-safe programs

mysql_affected_rows()
//Returns the number of rows changed/deleted/inserted by the last UPDATE, DELETE, or INSERT query
//返回被最新的UPDATE, DELETE或INSERT查询影响的行数。

mysql_autocommit()
//Toggles autocommit mode on/off

mysql_change_user()
//Changes user and database on an open connection
//改变在一个打开的连接上的用户和数据库。

mysql_character_set_name()
// Return default character set name for current connection

mysql_client_find_plugin()
// Return pointer to plugin

mysql_client_register_plugin()
// Register a plugin

mysql_close()
// Closes a server connection
//关闭一个服务器连接。

mysql_commit()
// Commits the transaction

mysql_connect()
// Connects to a MySQL server (this function is deprecated; use mysql_real_connect() instead)
//连接一个MySQL服务器。该函数不推荐；使用mysql_real_connect()代替。

mysql_create_db()
// Creates a database (this function is deprecated; use the SQL statement CREATE DATABASE instead)
// 创建一个数据库。该函数不推荐；而使用SQL命令CREATE DATABASE。
mysql_data_seek()
// Seeks to an arbitrary row number in a query result set
//在一个查询结果集合中搜寻一任意行。

mysql_debug()
// Does a DBUG_PUSH with the given string
//用给定字符串做一个DBUG_PUSH。

mysql_drop_db()
// Drops a database (this function is deprecated; use the SQL statement DROP DATABASE instead)
//抛弃一个数据库。该函数不推荐；而使用SQL命令DROP DATABASE。

mysql_dump_debug_info()
// Makes the server write debug information to the log
//让服务器将调试信息写入日志文件。
mysql_eof()
// Determines whether the last row of a result set has been read (this function is deprecated; mysql_errno() or mysql_error() may be used instead)
//确定是否已经读到一个结果集合的最后一行。这功能被反对; mysql_errno()或mysql_error()可以相反被使用。

mysql_errno()
// Returns the error number for the most recently invoked MySQL function
//返回最近被调用的MySQL函数的出错编号。

mysql_error()
// Returns the error message for the most recently invoked MySQL function
//返回最近被调用的MySQL函数的出错消息。

mysql_escape_string()
// Escapes special characters in a string for use in an SQL statement
//用在SQL语句中的字符串的转义特殊字符。

mysql_fetch_field()
// Returns the type of the next table field
//返回下一个表字段的类型。

mysql_fetch_field_direct() 
//Returns the type of a table field, given a field number
//返回一个表字段的类型，给出一个字段编号。

mysql_fetch_fields()
// Returns an array of all field structures
//返回一个所有字段结构的数组。

mysql_fetch_lengths()
// Returns the lengths of all columns in the current row
// /返回当前行中所有列的长度。

mysql_fetch_row()
// Fetches the next row from the result set
//从结果集合中取得下一行。

mysql_field_count()
// Returns the number of result columns for the most recent statement
//返回最近查询的结果列的数量。

mysql_field_seek()
// Puts the column cursor on a specified column
//把列光标放在一个指定的列上。

mysql_field_tell()
// Returns the position of the field cursor used for the last mysql_fetch_field()
//返回用于最后一个mysql_fetch_field()的字段光标的位置。

mysql_free_result()
// Frees memory used by a result set
// /释放一个结果集合使用的内存。
mysql_get_character_set_info()
// Return information about default character set

mysql_get_client_info()
// Returns client version information as a string
//返回客户版本信息。

mysql_get_client_version()
// Returns client version information as an integer

mysql_get_host_info()
// Returns a string describing the connection
//返回一个描述连接的字符串。

mysql_get_proto_info()
// Returns the protocol version used by the connection
//返回连接使用的协议版本。

mysql_get_server_info()
// Returns the server version number
//返回服务器版本号。

mysql_get_server_version()
// Returns version number of server as an integer

mysql_get_ssl_cipher()
// Return current SSL cipher

mysql_hex_string()
// Encode string in hexadecimal format

mysql_info()
// Returns information about the most recently executed query
//返回关于最近执行得查询的信息。

mysql_init()
// Gets or initializes a MYSQL structure
//获得或初始化一个MYSQL结构。

mysql_insert_id()
// Returns the ID generated for an AUTO_INCREMENT column by the previous query
//返回有前一个查询为一个AUTO_INCREMENT列生成的ID。

mysql_kill()
// Kills a given thread
//杀死一个给定的线程。

mysql_library_end()
// Finalize the MySQL C API library

mysql_library_init()
// Initialize the MySQL C API library

mysql_list_dbs()
// Returns database names matching a simple regular expression
//返回匹配一个简单的正则表达式的数据库名。

mysql_list_fields()
// Returns field names matching a simple regular expression
//返回匹配一个简单的正则表达式的列名。

mysql_list_processes()
// Returns a list of the current server threads
//返回当前服务器线程的一张表。

mysql_list_tables()
// Returns table names matching a simple regular expression
//返回匹配一个简单的正则表达式的表名。

mysql_load_plugin()
// Load a plugin

mysql_load_plugin_v()
// Load a plugin

mysql_more_results()
// Checks whether any more results exist

mysql_next_result() 
//Returns/initiates the next result in multiple-result executions

mysql_num_fields()
// Returns the number of columns in a result set
//返回一个结果集合重的列的数量。

mysql_num_rows()
// Returns the number of rows in a result set
//返回一个结果集合中的行的数量。

mysql_options()
// Sets connect options for mysql_real_connect()
//设置对mysql_connect()的连接选项。

mysql_ping() Checks
// whether the connection to the server is working, reconnecting as necessary
//检查对服务器的连接是否正在工作，必要时重新连接。

mysql_plugin_options()
// Set a plugin option

mysql_query()
// Executes an SQL query specified as a null-terminated string
//执行指定为一个空结尾的字符串的SQL查询。

mysql_real_connect()
// Connects to a MySQL server
// 连接一个MySQL服务器。

mysql_real_escape_string()
// Escapes special characters in a string for use in an SQL statement, taking into account the current character set of the connection

mysql_real_query()
// Executes an SQL query specified as a counted string
//执行指定为带计数的字符串的SQL查询。

mysql_refresh()
// Flush or reset tables and caches

mysql_reload()
// Tells the server to reload the grant tables
//告诉服务器重装授权表。

mysql_rollback() 
//Rolls back the transaction

mysql_row_seek()
// Seeks to a row offset in a result set, using value returned from mysql_row_tell()
//搜索在结果集合中的行，使用从mysql_row_tell()返回的值。

mysql_row_tell()
// Returns the row cursor position
//返回行光标位置。

mysql_select_db()
// Selects a database
//连接一个数据库。

mysql_server_end()
// Finalize the MySQL C API library

mysql_server_init()
// Initialize the MySQL C API library

mysql_set_character_set()
// Set default character set for current connection

mysql_set_local_infile_default()
// Set the LOAD DATA LOCAL INFILE handler callbacks to their default values

mysql_set_local_infile_handler()
// Install application-specific LOAD DATA LOCAL INFILE handler callbacks

mysql_set_server_option()
// Sets an option for the connection (like multi-statements)

mysql_sqlstate()
// Returns the SQLSTATE error code for the last error

mysql_shutdown()
// Shuts down the database server
//关掉数据库服务器。

mysql_ssl_set()
// Prepare to establish SSL connection to server

mysql_stat()
// Returns the server status as a string
//返回作为字符串的服务器状态。

mysql_store_result()
// Retrieves a complete result set to the client
//检索一个完整的结果集合给客户。

mysql_thread_end()
// Finalize thread handler

mysql_thread_id()
// Returns the current thread ID
//返回当前线程的ID。

mysql_thread_init()
// Initialize thread handler

mysql_thread_safe()
// Returns 1 if the clients are compiled as thread-safe

mysql_use_result()
// Initiates a row-by-row result set retrieval
//初始化一个一行一行地结果集合的检索。

mysql_warning_count()
// Returns the warning count for the previous SQL statement

```

## See
- <https://dev.mysql.com/doc/refman/5.6/en/c-api-data-structures.html>
- <https://dev.mysql.com/doc/refman/5.6/en/c-api-function-overview.html>

### *All rights reserved*