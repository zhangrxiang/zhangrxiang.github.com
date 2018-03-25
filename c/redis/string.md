# String

```c
//
// Created by zhangrongxiang on 2018/3/7 13:48
// File string2
//

#include <hiredis/hiredis.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
```
## 连接redis服务
```c
int main() {
    redisContext *context = redisConnect("127.0.0.1", 6379);
    if (context == NULL || context->err) {
        if (context) {
            printf("%s\n", context->errstr);
        } else {
            printf("redisConnect error\n");
        }
        exit(EXIT_FAILURE);
    }
    printf("-----------------connect success--------------------\n");
```

## SET key value
```c
    char *key = "str";
    char *val = "Hello World";
    /*SET key value */
    redisReply *reply = redisCommand(context, "SET %s %s", key, val);
    if (reply->type == REDIS_REPLY_STATUS) {
        /*SET str Hello World*/
        printf("SET %s %s\n", key, val);
    }
    freeReplyObject(reply);
```

## GET key
```c
    /*GET key*/
    reply = redisCommand(context, "GET %s", key);
    if (reply->type == REDIS_REPLY_STRING) {
        /*GET str Hello World*/
        printf("GET str %s\n", reply->str);
        /*GET len 11*/
        printf("GET len %d\n", reply->len);
    }
    freeReplyObject(reply);
```
## APPEND key value
```c
    /*APPEND key value*/
    char *append = " I am your GOD";
    reply = redisCommand(context, "APPEND %s %s", key, append);
    if (reply->type == REDIS_REPLY_INTEGER) {
        printf("APPEND %s %s \n", key, append);
    }
    freeReplyObject(reply);
    /*GET key*/
    reply = redisCommand(context, "GET %s", key);
    if (reply->type == REDIS_REPLY_STRING) {
        //GET Hello World I am your GOD
        printf("GET %s\n", reply->str);
    }
    freeReplyObject(reply);
```

## INCR key
```c
    /*INCR key*/
    reply = redisCommand(context, "INCR counter");
    if (reply->type == REDIS_REPLY_INTEGER) {
        printf("INCR counter %lld\n", reply->integer);
    }
    freeReplyObject(reply);
    reply = redisCommand(context, "INCR counter");
    if (reply->type == REDIS_REPLY_INTEGER) {
        printf("INCR counter %lld\n", reply->integer);
    }
    freeReplyObject(reply);
```
## DECR key
```c
    /*DECR key*/
    reply = redisCommand(context, "DECR counter");
    if (reply->type == REDIS_REPLY_INTEGER) {
        printf("DECR counter %lld\n", reply->integer);
    }
    freeReplyObject(reply);
    reply = redisCommand(context, "DECR counter");
    if (reply->type == REDIS_REPLY_INTEGER) {
        printf("DECR counter %lld\n", reply->integer);
    }
    freeReplyObject(reply);
```
## DECRBY key decrement
```c
    /*DECRBY key decrement*/
    reply = redisCommand(context, "DECRBY counter 5");
    if (reply->type == REDIS_REPLY_INTEGER) {
        printf("DECRBY counter %lld\n", reply->integer);
    }
    freeReplyObject(reply);
    reply = redisCommand(context, "DECRBY counter 5");
    if (reply->type == REDIS_REPLY_INTEGER) {
        printf("DECRBY counter %lld\n", reply->integer);
    }
    freeReplyObject(reply);
```
## INCRBY key increment
```
    /*INCRBY key increment*/
    reply = redisCommand(context, "INCRBY counter 5");
    if (reply->type == REDIS_REPLY_INTEGER) {
        printf("INCRBY counter %lld\n", reply->integer);
    }
    freeReplyObject(reply);
    reply = redisCommand(context, "INCRBY counter 5");
    if (reply->type == REDIS_REPLY_INTEGER) {
        printf("INCRBY counter %lld\n", reply->integer);
    }
    freeReplyObject(reply);
```
## ETRANGE key start end
```c
    /*GETRANGE key start end*/
    reply = redisCommand(context, "GETRANGE str 0 5");
    if (reply->type == REDIS_REPLY_STRING) {
        /*GETRANGE str Hello*/
        printf("GETRANGE %s %s\n", key, reply->str);
    }
    freeReplyObject(reply);
```
## GETSET key value
```c
    /*GETSET key value*/
    reply = redisCommand(context, "GETSET %s %s", key, val);
    if (reply->type == REDIS_REPLY_STRING) {
        /*GETSET str Hello World I am your GOD*/
        printf("GETSET %s %s\n", key, reply->str);
    }
    /*INCRBYFLOAT key increment*/
    reply = redisCommand(context, "INCRBYFLOAT f 2.1");
    if (reply->type == REDIS_REPLY_STRING) {
        printf("INCRBYFLOAT counter %s\n", reply->str);
    }
```
## MSET key value [key value ...]
```c
    /*MSET key value [key value ...]*/
    reply = redisCommand(context, "MSET k1 hello k2 world k3 good");
    if (reply->type == REDIS_REPLY_STATUS) {
        printf("MSET k1 hello k2 world k3 good\n");
    }
    freeReplyObject(reply);
```
## MGET key [key ...]
```c
    /*MGET key [key ...]*/
    reply = redisCommand(context, "MGET k1 k2 k3");
    if (reply->type == REDIS_REPLY_ARRAY) {
        printf("MGET k1  k2  k3 \n");
        redisReply **pReply = reply->element;
        int i = 0;
        size_t len = reply->elements;
        //hello world good
        for (; i < len; ++i) {
            printf("%s ", pReply[i]->str);
        }
        printf("\n");
    }
    freeReplyObject(reply);
```

## STRLEN key
```c
    /*STRLEN key*/
    reply = redisCommand(context, "STRLEN str");
    if (reply->type == REDIS_REPLY_INTEGER) {
        //1
        printf("STRLEN str %lld \n", reply->integer);
    }
    /*SETEX key seconds value*/
    reply = redisCommand(context, "SETEX s 30 30seconds");
    if (reply->type == REDIS_REPLY_STATUS) {
        printf("SETEX s 30 30seconds\n");
        freeReplyObject(reply);
        int i = 0;
        while (i++ < 32) {
            reply = redisCommand(context, "GET s");
            if (reply->type == REDIS_REPLY_STRING) {
                printf("%d s %s\n", i, reply->str);
            } else if (reply->type == REDIS_REPLY_NIL) {
                printf("%d s nil\n", i);
            }
            freeReplyObject(reply);
            sleep(1);
            /*
             * 29 s 30seconds
             * 30 s 30seconds
             * 31 s nil
             * 32 s nil
             */
        }
    }
```

## redisFree
```c
    redisFree(context);
    return EXIT_SUCCESS;
}
```

## struct
```c
#define REDIS_REPLY_STRING 1
#define REDIS_REPLY_ARRAY 2
#define REDIS_REPLY_INTEGER 3
#define REDIS_REPLY_NIL 4
#define REDIS_REPLY_STATUS 5
#define REDIS_REPLY_ERROR 6

/* This is the reply object returned by redisCommand() */
typedef struct redisReply {
    int type; /* REDIS_REPLY_* */
    long long integer; /* The integer when type is REDIS_REPLY_INTEGER */
    int len; /* Length of string */
    char *str; /* Used for both REDIS_REPLY_ERROR and REDIS_REPLY_STRING */
    size_t elements; /* number of elements, for REDIS_REPLY_ARRAY */
    struct redisReply **element; /* elements vector for REDIS_REPLY_ARRAY */
} redisReply;

```
### *All rights reserved*