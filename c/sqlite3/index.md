# sqlite3 API

## Summary

### sqlite3
- The database connection object. Created by sqlite3_open() and destroyed by sqlite3_close().
> - Each open SQLite database is represented by a pointer to an instance of the opaque structure named "sqlite3". It is useful to think of an sqlite3 pointer as an object.

```c
typedef struct sqlite3 sqlite3;
```

### sqlite3_stmt
- The prepared statement object. Created by sqlite3_prepare() and destroyed by sqlite3_finalize().
> - An instance of this object represents a single SQL statement that has been compiled into binary form and is ready to be evaluated.

```c
typedef struct sqlite3_stmt sqlite3_stmt;
```
#### The life-cycle of a prepared statement object usually goes like this:
1. Create the prepared statement object using sqlite3_prepare_v2().
2. Bind values to parameters using the sqlite3\_bind_\*() interfaces.
3. Run the SQL by calling sqlite3_step() one or more times.
4. Reset the prepared statement using sqlite3_reset() then go back to step 2. Do this zero or more times.
5. Destroy the object using sqlite3_finalize().

### sqlite3_open()
- Open a connection to a new or existing SQLite database. The constructor for sqlite3.
> - These routines open an SQLite database file as specified by the filename argument. 
> - A database connection handle is usually returned in \*ppDb, even if an error occurs. The only exception is that if SQLite is unable to allocate memory to hold the sqlite3 object, a NULL will be written into \*ppDb instead of a pointer to the sqlite3 object. If the database is opened (and/or created) successfully, then SQLITE_OK is returned. Otherwise an error code is returned. 

```c
int sqlite3_open(
  const char *filename,   /* Database filename (UTF-8) */
  sqlite3 **ppDb          /* OUT: SQLite db handle */
);
int sqlite3_open16(
  const void *filename,   /* Database filename (UTF-16) */
  sqlite3 **ppDb          /* OUT: SQLite db handle */
);
int sqlite3_open_v2(
  const char *filename,   /* Database filename (UTF-8) */
  sqlite3 **ppDb,         /* OUT: SQLite db handle */
  int flags,              /* Flags */
  const char *zVfs        /* Name of VFS module to use */
);
```

### sqlite3_prepare()
- Compile SQL text into byte-code that will do the work of querying or updating the database. The constructor for sqlite3_stmt.
> - To execute an SQL statement, it must first be compiled into a byte-code program using one of these routines. Or, in other words, these routines are constructors for the prepared statement object.

```c
int sqlite3_prepare(
  sqlite3 *db,            /* Database handle */
  const char *zSql,       /* SQL statement, UTF-8 encoded */
  int nByte,              /* Maximum length of zSql in bytes. */
  sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
  const char **pzTail     /* OUT: Pointer to unused portion of zSql */
);
int sqlite3_prepare_v2(
  sqlite3 *db,            /* Database handle */
  const char *zSql,       /* SQL statement, UTF-8 encoded */
  int nByte,              /* Maximum length of zSql in bytes. */
  sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
  const char **pzTail     /* OUT: Pointer to unused portion of zSql */
);
int sqlite3_prepare_v3(
  sqlite3 *db,            /* Database handle */
  const char *zSql,       /* SQL statement, UTF-8 encoded */
  int nByte,              /* Maximum length of zSql in bytes. */
  unsigned int prepFlags, /* Zero or more SQLITE_PREPARE_ flags */
  sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
  const char **pzTail     /* OUT: Pointer to unused portion of zSql */
);
int sqlite3_prepare16(
  sqlite3 *db,            /* Database handle */
  const void *zSql,       /* SQL statement, UTF-16 encoded */
  int nByte,              /* Maximum length of zSql in bytes. */
  sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
  const void **pzTail     /* OUT: Pointer to unused portion of zSql */
);
int sqlite3_prepare16_v2(
  sqlite3 *db,            /* Database handle */
  const void *zSql,       /* SQL statement, UTF-16 encoded */
  int nByte,              /* Maximum length of zSql in bytes. */
  sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
  const void **pzTail     /* OUT: Pointer to unused portion of zSql */
);
int sqlite3_prepare16_v3(
  sqlite3 *db,            /* Database handle */
  const void *zSql,       /* SQL statement, UTF-16 encoded */
  int nByte,              /* Maximum length of zSql in bytes. */
  unsigned int prepFlags, /* Zero or more SQLITE_PREPARE_ flags */
  sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
  const void **pzTail     /* OUT: Pointer to unused portion of zSql */
);
```

### sqlite3_bind()
- Store application data into parameters of the original SQL.
```c
int sqlite3_bind_blob(sqlite3_stmt*, int, const void*, int n, void(*)(void*));
int sqlite3_bind_blob64(sqlite3_stmt*, int, const void*, sqlite3_uint64,void(*)(void*));
int sqlite3_bind_double(sqlite3_stmt*, int, double);
int sqlite3_bind_int(sqlite3_stmt*, int, int);
int sqlite3_bind_int64(sqlite3_stmt*, int, sqlite3_int64);
int sqlite3_bind_null(sqlite3_stmt*, int);
int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
int sqlite3_bind_text16(sqlite3_stmt*, int, const void*, int, void(*)(void*));
int sqlite3_bind_text64(sqlite3_stmt*, int, const char*, sqlite3_uint64,void(*)(void*), unsigned char encoding);
int sqlite3_bind_value(sqlite3_stmt*, int, const sqlite3_value*);
int sqlite3_bind_pointer(sqlite3_stmt*, int, void*, const char*,void(*)(void*));
int sqlite3_bind_zeroblob(sqlite3_stmt*, int, int n);
int sqlite3_bind_zeroblob64(sqlite3_stmt*, int, sqlite3_uint64);
```

### sqlite3_step()
- Advance an sqlite3_stmt to the next result row or to completion.
```
int sqlite3_step(sqlite3_stmt*);
```

### sqlite3_column()
- Column values in the current result row for an sqlite3_stmt.
```c
const void *sqlite3_column_blob(sqlite3_stmt*, int iCol);
double sqlite3_column_double(sqlite3_stmt*, int iCol);
int sqlite3_column_int(sqlite3_stmt*, int iCol);
sqlite3_int64 sqlite3_column_int64(sqlite3_stmt*, int iCol);
const unsigned char *sqlite3_column_text(sqlite3_stmt*, int iCol);
const void *sqlite3_column_text16(sqlite3_stmt*, int iCol);
sqlite3_value *sqlite3_column_value(sqlite3_stmt*, int iCol);
int sqlite3_column_bytes(sqlite3_stmt*, int iCol);
int sqlite3_column_bytes16(sqlite3_stmt*, int iCol);
int sqlite3_column_type(sqlite3_stmt*, int iCol);
```
> - sqlite3_column_blob	        →	BLOB result
> - sqlite3_column_double	    →	REAL result
> - sqlite3_column_int	        →	32-bit INTEGER result
> - sqlite3_column_int64	    →	64-bit INTEGER result
> - sqlite3_column_text	        →	UTF-8 TEXT result
> - sqlite3_column_text16	    →	UTF-16 TEXT result
> - sqlite3_column_value	    →	The result as an unprotected sqlite3_value object. 	 
> - sqlite3_column_bytes	    →	Size of a BLOB or a UTF-8 TEXT result in bytes
> - sqlite3_column_bytes16  	→  	Size of UTF-16 TEXT in bytes
> - sqlite3_column_type	        →	Default datatype of the result

### sqlite3_finalize()
- Destructor for sqlite3_stmt.
```c
int sqlite3_finalize(sqlite3_stmt *pStmt);
```
> The sqlite3\_finalize() function is called to delete a prepared statement. If the most recent evaluation of the statement encountered no errors or if the statement is never been evaluated, then sqlite3\_finalize() returns SQLITE_OK. 

### sqlite3_close()
- Destructor for sqlite3.
```c
int sqlite3_close(sqlite3*);
int sqlite3_close_v2(sqlite3*);
```
> The sqlite3\_close() and sqlite3\_close\_v2() routines are destructors for the sqlite3 object. Calls to sqlite3\_close() and sqlite3\_close\_v2() return SQLITE_OK if the sqlite3 object is successfully destroyed and all associated resources are deallocated.

### sqlite3_exec()
- A wrapper function that does sqlite3\_prepare(), sqlite3\_step(), sqlite3\_column(), and sqlite3\_finalize() for a string of one or more SQL statements.
```c
int sqlite3_exec(
  sqlite3*,                                  /* An open database */
  const char *sql,                           /* SQL to be evaluated */
  int (*callback)(void*,int,char**,char**),  /* Callback function */
  void *,                                    /* 1st argument to callback */
  char **errmsg                              /* Error msg written here */
);
```

### sqlite3_get_table()
- Convenience Routines For Running Queries
```c
int sqlite3_get_table(
  sqlite3 *db,          /* An open database */
  const char *zSql,     /* SQL to be evaluated */
  char ***pazResult,    /* Results of the query */
  int *pnRow,           /* Number of result rows written here */
  int *pnColumn,        /* Number of result columns written here */
  char **pzErrmsg       /* Error msg written here */
);
void sqlite3_free_table(char **result);
```
> A result table is memory data structure created by the sqlite3_get_table() interface. A result table records the complete query results from one or more queries.

## See
- <http://www.sqlite.org/cintro.html>

### *All rights reserved*