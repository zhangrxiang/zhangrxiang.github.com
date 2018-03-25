# socket
## 产生的原因
进程通信的概念最初来源于单机系统。由于每个进程都在自己的地址范围内运行，为保证两个相互通信的进程之间既互不干扰又协调一致工作，操作系统为进程通信提供了相应设施，如

- UNIX BSD有：管道（pipe）、命名管道（named pipe）软中断信号（signal）
- UNIX system V有：消息（message）、共享存储区（shared memory）和信号量（semaphore)等.

他们都仅限于用在本机进程之间通信。网间进程通信要解决的是不同主机进程间的相互通信问题（可把同机进程通信看作是其中的特例）。为此，首先要解决的是网间进程标识问题。同一主机上，不同进程可用进程号（process ID）唯一标识。但在网络环境下，各主机独立分配的进程号不能唯一标识该进程。例如，主机A赋于某进程号5，在B机中也可以存在5号进程，因此，“5号进程”这句话就没有意义了。 其次，操作系统支持的网络协议众多，不同协议的工作方式不同，地址格式也不同。因此，网间进程通信还要解决多重协议的识别问题。 

其实TCP/IP协议族已经帮我们解决了这个问题，网络层的“ip地址”可以唯一标识网络中的主机，而传输层的“协议+端口”可以唯一标识主机中的应用程序（进程）。这样利用三元组（ip地址，协议，端口）就可以标识网络的进程了，网络中的进程通信就可以利用这个标志与其它进程进行交互。

使用TCP/IP协议的应用程序通常采用应用编程接口：UNIX  BSD的套接字（socket）和UNIX System V的TLI（已经被淘汰），来实现网络进程之间的通信。就目前而言，几乎所有的应用程序都是采用socket，而现在又是网络时代，网络中进程通信是无处不在，这就是我为什么说“一切皆socket”。

## 定义
> - 网络上的两个程序通过一个双向的通信连接实现数据的交换，这个连接的一端称为一个socket。

> - socket起源于Unix，而Unix/Linux基本哲学之一就是“一切皆文件”，都可以用“打开open –> 读写write/read –> 关闭close”模式来操作。我的理解就是Socket就是该模式的一个实现，socket即是一种特殊的文件，一些socket函数就是对其进行的操作（读/写IO、打开、关闭）

> - socket的英文原义是“孔”或“插座”。作为BSD UNIX的进程通信机制，取后一种意思。通常也称作"套接字"，用于描述IP地址和端口，是一个通信链的句柄，可以用来实现不同虚拟机或不同计算机之间的通信。在Internet上的主机一般运行了多个服务软件，同时提供几种服务。每种服务都打开一个Socket，并绑定到一个端口上，不同的端口对应于不同的服务。Socket正如其英文原义那样，像一个多孔插座。一台主机犹如布满各种插座的房间，每个插座有一个编号，有的插座提供220伏交流电， 有的提供110伏交流电，有的则提供有线电视节目。 客户软件将插头插到不同编号的插座，就可以得到不同的服务。

> - Socket是应用层与TCP/IP协议族通信的中间软件抽象层，它是一组接口。在设计模式中，Socket其实就是一个门面模式，它把复杂的TCP/IP协议族隐藏在Socket接口后面，对用户来说，一组简单的接口就是全部，让Socket去组织数据，以符合指定的协议，而不需要让用户自己去定义什么时候需要指定哪个协议哪个函数。

## 分类 
### 流式socket（SOCK_STREAM ） 
流式套接字提供可靠的、面向连接的通信流；它使用TCP 协议，从而保证了数据传输的正确性和顺序性。 
### 数据报socket（SOCK_DGRAM ） 
数据报套接字定义了一种无连接的服 ，数据通过相互独立的报文进行传输，是无序的，并且不保证是可靠、无差错的。它使用数据报协议UDP。 
### 原始socket（SOCK_RAW） 
原始套接字允许对底层协议如IP或ICMP进行直接访问，功能强大但使用较为不便，主要用于一些协议的开发。

## 连接过程
> 根据连接启动的方式以及本地套接字要连接的目标，套接字之间的连接过程可以分为三个步骤：服务器监听，客户端请求，连接确认。

- 服务器监听：是服务器端套接字并不定位具体的客户端套接字，而是处于等待连接的状态，实时监控网络状态。
- 客户端请求：是指由客户端的套接字提出连接请求，要连接的目标是服务器端的套接字。为此，客户端的套接字必须首先描述它要连接的服务器的套接字，指出服务器端套接字的地址和端口号，然后就向服务器端套接字提出连接请求。
- 连接确认：是指当服务器端套接字监听到或者说接收到客户端套接字的连接请求，它就响应客户端套接字的请求，建立一个新的线程，把服务器端套接字的描述发给客户端，一旦客户端确认了此描述，连接就建立好了。而服务器端套接字继续处于监听状态，继续接收其他客户端套接字的连接请求。

## Linux socket 函数

## 创建socket
```c
int socket(int domain, int type, int protocol);
```
### 参数
- `domain`：协议域，又称协议族（`family`）。常用的协议族有`AF_INET`、`AF_INET6`、`AF_LOCAL`（或称`AF_UNIX`，Unix域Socket）、`AF_ROUTE`等。协议族决定了socket的地址类型，在通信中必须采用对应的地址，如AF_INET决定了要用ipv4地址（32位的）与端口号（16位的）的组合、AF_UNIX决定了要用一个绝对路径名作为地址。
- `type`：指定Socket类型。常用的socket类型有`SOCK_STREAM`、`SOCK_DGRAM`、`SOCK_RAW`、`SOCK_PACKET`、`SOCK_SEQPACKET`等。流式Socket（SOCK_STREAM）是一种面向连接的Socket，针对于面向连接的TCP服务应用。数据报式Socket（SOCK_DGRAM）是一种无连接的Socket，对应于无连接的UDP服务应用。
- `protocol`：指定协议。常用协议有`IPPROTO_TCP`、`IPPROTO_UDP`、`IPPROTO_STCP`、`IPPROTO_TIPC`等，分别对应TCP传输协议、UDP传输协议、STCP传输协议、TIPC传输协议。
> 注意：type和protocol不可以随意组合，如SOCK_STREAM不可以跟IPPROTO_UDP组合。当第三个参数为0时，会自动选择第二个参数类型对应的默认协议。

### 返回值
- 如果调用成功就返回新创建的套接字的描述符，如果失败就返回`INVALID_SOCKET`（Linux下失败返回-1）。套接字描述符是一个整数类型的值。每个进程的进程空间里都有一个套接字描述符表，该表中存放着套接字描述符和套接字数据结构的对应关系。该表中有一个字段存放新创建的套接字的描述符，另一个字段存放套接字数据结构的地址，因此根据套接字描述符就可以找到其对应的套接字数据结构。每个进程在自己的进程空间里都有一个套接字描述符表但是套接字数据结构都是在操作系统的内核缓冲里。

## 绑定
```c
int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
```
### 参数
- `sockfd`：即socket描述字，它是通过socket()函数创建了，唯一标识一个socket。bind()函数就是将给这个描述字绑定一个名字。
- `address`：是一个sockaddr结构指针，该结构中包含了要结合的地址和端口号。
    ```c
    //ipv4对应的是： 
    struct sockaddr_in {
    sa_family_t    sin_family; /* address family: AF_INET */
    in_port_t      sin_port;   /* port in network byte order */
    struct in_addr sin_addr;   /* internet address */
    };

    /* Internet address. */
    struct in_addr {
        uint32_t       s_addr;     /* address in network byte order */
    };
    //ipv6对应的是： 
    struct sockaddr_in6 { 
        sa_family_t     sin6_family;   /* AF_INET6 */ 
        in_port_t       sin6_port;     /* port number */ 
        uint32_t        sin6_flowinfo; /* IPv6 flow information */ 
        struct in6_addr sin6_addr;     /* IPv6 address */ 
        uint32_t        sin6_scope_id; /* Scope ID (new in 2.4) */ 
    };

    struct in6_addr { 
        unsigned char   s6_addr[16];   /* IPv6 address */ 
    };
    //Unix域对应的是： 
    #define UNIX_PATH_MAX    108

    struct sockaddr_un { 
        sa_family_t sun_family;               /* AF_UNIX */ 
        char        sun_path[UNIX_PATH_MAX];  /* pathname */ 
    };
    ```
- `address_len`：确定address缓冲区的长度。

### 返回值
- 如果函数执行成功，返回值为0，否则为`SOCKET_ERROR`。
> 通常服务器在启动的时候都会绑定一个众所周知的地址（如ip地址+端口号），用于提供服务，客户就可以通过它来接连服务器；而客户端就不用指定，有系统自动分配一个端口号和自身的ip地址组合。这就是为什么通常服务器端在listen之前会调用bind()，而客户端就不会调用，而是在connect()时由系统随机生成一个。

## 监听(listen) - listen for connections on a socket
```c
int listen(int sockfd, int backlog);
```
### 参数
- `sockfd`: socket描述字
- `backlog`: The backlog argument defines the maximum length to which the queue of pending connections for sockfd may grow.
> listen函数的第一个参数即为要监听的socket描述字，第二个参数为相应socket可以排队的最大连接个数。socket()函数创建的socket默认是一个主动类型的，listen函数将socket变为被动类型的，等待客户的连接请求。

### 返回值
- On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.

## 连接 (connect) - initiate a connection on a socket
```c
int connect(int sockfd, const struct sockaddr *addr,socklen_t addrlen);
```
### 参数
- `sockfd`: socket描述字
- `addr`: addr is the address to which datagrams are sent by default, and the only address from which datagrams are received.
### 返回值
- If the connection or binding succeeds, zero is returned.  On error, -1 is returned, and errno is set appropriately.
> connect函数的第一个参数即为客户端的socket描述字，第二参数为服务器的socket地址，第三个参数为socket地址的长度。客户端通过调用connect函数来建立与TCP服务器的连接。成功返回0，若连接失败则返回-1。

## 接收（accept） - accept a connection on a socket
> TCP服务器端依次调用socket()、bind()、listen()之后，就会监听指定的socket地址了。TCP客户端依次调用socket()、connect()之后就向TCP服务器发送了一个连接请求。TCP服务器监听到这个请求之后，就会调用accept()函数取接收请求，这样连接就建立好了。之后就可以开始网络I/O操作了，即类同于普通文件的读写I/O操作。

```c       
int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
```
### 参数 
- `sockfd`:用来监听一个端口，当有一个客户与服务器连接时，它使用这个一个端口号，而此时这个端口号正与这个套接字关联。当然客户不知道套接字这些细节，它只知道一个地址和一个端口号。
-  `addr`:这是一个结果参数，它用来接受一个返回值，这返回值指定客户端的地址，当然这个地址是通过某个地址结构来描述的，用户应该知道这一个什么样的地址结构。如果对客户的地址不感兴趣，那么可以把这个值设置为NULL。
- `addrlen`:结果的参数，用来接受上述addr的结构的大小的，它指明addr结构所占有的字节个数。同样的，它也可以被设置为NULL。 
### 返回值
- 如果accept成功返回，则服务器与客户已经正确建立连接了，此时服务器通过accept返回的套接字来完成与客户的通信。

> accept默认会阻塞进程，直到有一个客户连接建立后返回，它返回的是一个新可用的套接字，这个套接字是连接套接字。此时我们需要区分两种套接字，
    - 监听套接字: 监听套接字正如accept的参数sockfd，它是监听套接字，在调用listen函数之后，是服务器开始调用socket()函数生成的，称为监听socket描述字(监听套接字)
    - 连接套接字：一个套接字会从主动连接的套接字变身为一个监听套接字；而accept函数返回的是已连接socket描述字(一个连接套接字)，它代表着一个网络已经存在的点点连接。　　

> 一个服务器通常通常仅仅只创建一个监听socket描述字，它在该服务器的生命周期内一直存在。内核为每个由服务器进程接受的客户连接创建了一个已连接socket描述字，当服务器完成了对某个客户的服务，相应的已连接socket描述字就被关闭。
> 连接套接字socketfd_new 并没有占用新的端口与客户端通信，依然使用的是与监听套接字socketfd一样的端口号


## 发送数据（send） - send a message on a socket
```c
ssize_t send(int sockfd, const void *buf, size_t len, int flags);
```
### 参数
- `sockfd`: 传输数据的socket描述符
- `buf` : 一个指向要发送数据的指针
- `len`: 以字节为单位的数据的长度
- `flags`: 0
### 返回值
- On success, these calls return the number of bytes sent.  On error, -1 is returned, and errno is set appropriately.

## 接受数据  - receive a message from a socket
```c       
ssize_t recv(int sockfd, void *buf, size_t len, int flags);
```
### 参数
- `sockfd`: 传输数据的socket描述符
- `buf` : 一个指向要发送数据的指针
- `len`: 以字节为单位的数据的长度
- `flags`: 0
### 返回值
- On success, these calls return the number of bytes sent.  On error, -1 is returned, and errno is set appropriately.

## 关闭（close） 
> 当所有的数据操作结束以后，你可以调用close()函数来释放该socket，从而停止在该socket上的任何数据操作：

### 参数
- `sockfd`: 传输数据的socket描述符
### 返回值
- returns zero on success.  On error, -1 is returned, and errno is set appropriately.

## shutdown
```c
int shutdown(int sockfd, int how);
```
### 参数
- `sockfd`: 
- `how`:  
    - 0 不允许继续接收数据
    - 1 不允许继续发送数据
    - 2 不允许继续发送和接收数据

### 返回值
- On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.

## Example
### tcp
#### server
```c
//
// Created by 张荣响 on 2018/2/1.
//

/*server.c*/

#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <netinet/in.h>

#define PORT            4321
#define BUFFER_SIZE        1024
#define MAX_QUE_CONN_NM    5

int main() {
  struct sockaddr_in server_sockaddr, client_sockaddr;
  int sin_size, recvbytes;
  int sockfd, client_fd;
  char buf[BUFFER_SIZE];

  /*建立socket连接*/
  if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
    perror("socket");
    exit(1);
  }
  printf("Socket id = %d\n", sockfd);

  /*设置sockaddr_in 结构体中相关参数*/
  server_sockaddr.sin_family = AF_INET;
  server_sockaddr.sin_port = htons(PORT);
  server_sockaddr.sin_addr.s_addr = INADDR_ANY;
  bzero(&(server_sockaddr.sin_zero), 8);

  int i = 1;/* 使得重复使用本地地址与套接字进行绑定 */
  setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &i, sizeof(i));

  /*绑定函数bind*/
  if (bind(sockfd, (struct sockaddr *) &server_sockaddr, sizeof(struct sockaddr)) == -1) {
    perror("bind");
    exit(1);
  }
  printf("Bind success!\n");

  /*调用listen函数*/
  if (listen(sockfd, MAX_QUE_CONN_NM) == -1) {
    perror("listen");
    exit(1);
  }
  printf("Listening....\n");

  /*调用accept函数，等待客户端的连接*/
  if ((client_fd = accept(sockfd, (struct sockaddr *) &client_sockaddr, &sin_size)) == -1) {
    perror("accept");
    exit(1);
  }

  /*调用recv函数接收客户端的请求*/
  memset(buf, 0, sizeof(buf));
  if ((recvbytes = recv(client_fd, buf, BUFFER_SIZE, 0)) == -1) {
    perror("recv");
    exit(1);
  }
  printf("Received a message: %s,length is %d\n", buf,recvbytes);
  close(sockfd);
  exit(0);
}
```
#### client
```c
//
// Created by 张荣响 on 2018/2/1.
//

/*client.c*/

#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <netdb.h>
#include <netinet/in.h>

#define PORT    4321
#define BUFFER_SIZE 1024

int main(int argc, char *argv[]) {
  int sockfd, sendbytes;
  char buf[BUFFER_SIZE];
  struct hostent *host;
  struct sockaddr_in serv_addr;

  if (argc < 3) {
    fprintf(stderr, "USAGE: ./client Hostname(or ip address) Text\n");
    exit(1);
  }

  /*地址解析函数*/
  if ((host = gethostbyname(argv[1])) == NULL) {
    perror("gethostbyname");
    exit(1);
  }

  memset(buf, 0, sizeof(buf));
  sprintf(buf, "%s", argv[2]);

  /*创建socket*/
  if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
    perror("socket");
    exit(1);
  }

  /*设置sockaddr_in 结构体中相关参数*/
  serv_addr.sin_family = AF_INET;
  serv_addr.sin_port = htons(PORT);
  serv_addr.sin_addr = *((struct in_addr *) host->h_addr);
  bzero(&(serv_addr.sin_zero), 8);

  /*调用connect函数主动发起对服务器端的连接*/
  if (connect(sockfd, (struct sockaddr *) &serv_addr, sizeof(struct sockaddr)) == -1) {
    perror("connect");
    exit(1);
  }

  /*发送消息给服务器端*/
  if ((sendbytes = send(sockfd, buf, strlen(buf), 0)) == -1) {
    perror("send");
    exit(1);
  }
  close(sockfd);
  exit(0);
}
```

### udp
#### server
```c
//
// Created by 张荣响 on 2018/2/1.
//

#include <stdio.h>
#include <stdlib.h>

#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <zconf.h>

int port = 6789;

int main(int argc, char **argv) {

  int sin_len;
  char message[256];

  int socket_descriptor;
  struct sockaddr_in sin;
  printf("Waiting for data form sender \n");

  bzero(&sin, sizeof(sin));
  sin.sin_family = AF_INET;
  sin.sin_addr.s_addr = htonl(INADDR_ANY);
  sin.sin_port = htons(port);
  sin_len = sizeof(sin);

  socket_descriptor = socket(AF_INET, SOCK_DGRAM, 0);
  bind(socket_descriptor, (struct sockaddr *) &sin, sizeof(sin));

  while (1) {
    recvfrom(socket_descriptor, message, sizeof(message), 0, (struct sockaddr *) &sin, &sin_len);
    printf("Response from server:%s\n", message);
    if (strncmp(message, "stop", 4) == 0)//接受到的消息为 “stop”
    {

      printf("Sender has told me to end the connection\n");
      break;
    }
  }

  close(socket_descriptor);
  return (EXIT_SUCCESS);
}

```

#### client
```c
//
// Created by 张荣响 on 2018/2/1.
//


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <zconf.h>

int port = 6789;
int main(int argc, char **argv) {
  int socket_descriptor; //套接口描述字
  int iter = 0;
  char buf[80];
  struct sockaddr_in address;//处理网络通信的地址

  bzero(&address, sizeof(address));
  address.sin_family = AF_INET;
  address.sin_addr.s_addr = inet_addr("127.0.0.1");//这里不一样
  address.sin_port = htons(port);

  //创建一个 UDP socket

  socket_descriptor = socket(AF_INET, SOCK_DGRAM, 0);//IPV4  SOCK_DGRAM 数据报套接字（UDP协议）

  for (iter = 0; iter <= 20; iter++) {
    /*
    * sprintf(s, "%8d%8d", 123, 4567); //产生：" 123 4567"
    * 将格式化后到 字符串存放到s当中
    */
    sprintf(buf, "data packet with ID %d\n", iter);

    /*int PASCAL FAR sendto( SOCKET s, const char FAR* buf, int len, int flags,const struct sockaddr FAR* to, int tolen);　　
     * s：一个标识套接口的描述字。　
     * buf：包含待发送数据的缓冲区。　　
     * len：buf缓冲区中数据的长度。　
     * flags：调用方式标志位。　　
     * to：（可选）指针，指向目的套接口的地址。　
     * tolen：to所指地址的长度。
　　      */
    sendto(socket_descriptor, buf, sizeof(buf), 0, (struct sockaddr *) &address, sizeof(address));
  }

  sprintf(buf, "stop\n");
  sendto(socket_descriptor, buf, sizeof(buf), 0, (struct sockaddr *) &address, sizeof(address));//发送stop 命令
  close(socket_descriptor);
  printf("Messages Sent,terminating\n");

  return (EXIT_SUCCESS);
}
```


## 文章参考
- <https://www.cnblogs.com/bzyx/p/5113914.html>
- <https://www.cnblogs.com/wmx-learn/p/5312259.html>
- <http://blog.csdn.net/phiall/article/details/51776091>
- <https://baike.baidu.com/item/socket/281150?fr=aladdin>