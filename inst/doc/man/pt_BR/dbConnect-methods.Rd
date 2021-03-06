\name{dbConnect-methods}
\docType{methods}
\alias{dbConnect}
\alias{dbDisconnect}
\alias{dbConnect,OraDriver-method}
\alias{dbConnect,ExtDriver-method}
\alias{dbDisconnect,OraConnection-method}
\title{
Criar um Objeto de Conexão para um Oracle DBMS
}
\description{
Estes métodos são implementações simples das funções genéricas
   correspondentes.
}
\usage{
\S4method{dbConnect}{OraDriver}(drv, username = "", password = "", dbname = "", prefetch = FALSE,
          bulk_read = 1000L, stmt_cache = 0L, external_credentials = FALSE,
          sysdba = FALSE, ...)
\S4method{dbConnect}{ExtDriver}(drv, prefetch = FALSE, bulk_read = 1000L, stmt_cache = 0L,
          external_credentials = FALSE, sysdba = FALSE, ...)
\S4method{dbDisconnect}{OraConnection}(conn, ...)
}
\arguments{
  \item{drv}{
Um objeto da classe \code{OraDriver} ou \code{ExtDriver}.
}
  \item{conn}{
Um objeto \code{OraConnection} como produzido por \code{dbConnect}.
}
  \item{username}{
Uma string de caracteres que especifica um nome de usuário.
}
  \item{password}{
Uma string de caracteres que especifica uma senha.
}
  \item{dbname}{
Uma string de caracteres que especifica um identificador de conexão (para obter mais
    informações, consulte o Capítulo 8, Configuring Naming Methods, do Oracle
    Database Net Services Administrator's Guide). Esta é a mesma que parte da
    string de conexão do SQL*Plus que segue o símbolo '@'. 
    Se você estiver usando o Oracle Wallet para armazenar o nome de usuário e a senha, 
    essa string deverá ser a string de conexão usada para ria o
    mapeamento de wallet (para obter mais informações, consulte Configuring Clients to Use
    the External Password Store no Capítulo 3 do Oracle Database Security Guide).
    Os identificadores de conexão de uma instância do Oracle TimesTen IMDB são suportados por meio de
    tnsnames OCI ou métodos de nomeação de conexão fáceis. Para obter informações adicionais
    sobre conexões TimesTen para o OCI, consulte o capítulo 3, TimesTen Support for OCI, of
    TimesTen In-Memory C Developer's Guide.
}
  \item{prefetch}{
Um valor lógico que indica TRUE ou FALSE. Quando definido como TRUE, o ROracle usará
    buffers de pré-extração do OCI para recuperar dados adicionais do servidor, salvando, assim,
    a memória necessária no RODBI/ROOCI alocando um único buffer de linha para extrair
    os dados do OCI. Usando os resultados de pré-extração em uma chamada de extração para cada linha. Por
    padrão, a pré-extração é FALSE e a extração da array é usada para recuperar os dados do
    servidor.
}
  \item{bulk_read}{
Um valor inteiro que indica o número de linhas a serem extraídas por vez. O
    valor padrão é 1000L. Quando a opção de pré-extração é selecionada, a memória é
    alocada para buffers de pré-extração e o OCI extrairá essa quantidade de linhas por vez.
    Quando a pré-extração não for usada (o padrão), a memória será alocada em RODBI/ROOCI
    define buffers. A definição dessa opção para um valor grande resultará em mais memória
    alocada com base no número de colunas na lista de seleção e nos tipos
    de colunas. Para uma coluna de caracteres de tipo, os buffers de definição serão alocados
    usando a largura máxima vezes a largura máxima de NLS. As aplicações devem
    ajustar esse valor com base no resultado da consulta e um valor maior beneficiará
    as consultas que retornam um resultado maior. Uma aplicação pode ajustar esse valor conforme
    necessário.
}
  \item{stmt_cache}{
Um valor inteiro que indica o número de instruções armazenadas no cache. Significa 
    que os cursores estão prontos para serem usados sem a necessidade de fazer parsing das instruções
    novamente. O valor padrão é 0L. Se o valor stmt_cache for maior que 0L,
    o valor \code{prefetch} deverá ser definido como TRUE.
}
  \item{external_credentials}{
Um valor lógico que indica TRUE ou FALSE. Quando definido como TRUE, o ROracle
    começará a sessão OCI autenticada com credenciais externas da conexão.
    O valor padrão é FALSE.
}
  \item{sysdba}{
Um valor lógico que indica TRUE ou FALSE. Quando definido como TRUE, o ROracle
    começará a sessão OCI com privilégios SYSDBA na conexão. O valor padrão
    é FALSE.
}
  \item{\dots}{
Não utilizado no momento.
}
}
\value{
\item{dbConnect}{
    Um objeto cuja classe estende \code{OraConnection} \code{DBIConnection}. 
    Esse objeto é usado para executas as consultas SQL no banco de dados.
  }
  \item{dbDisconnect}{
    Um valor lógico que indica se a operação foi bem-sucedida ou não.
  }
}
\section{Side Effects}{
  \describe{
    \item{dbConnect}{
      Establishes a connection between R and an Oracle Database server.
    }
    \item{dbDisconnect}{
      Frees resources used by the connection object.
    }
  }
}
      




           
\details{
\\describe{
    \item{dbConnect}{
      Este objeto de conexão é usado para executar operações no banco de dados.
      Quando \code{prefetch} é definido como TRUE, ele permite o uso do buffer de pré-extração do OCI
      para recuperar dados adicionais do servidor.
      O argumento \code{bulk_read} é usado para definir um valor inteiro que indica
      o número de linhas que serão extraídas por vez.
      O argumento \code{stmt_cache} é usado para ativar ou desativar o recurso de
      armazenamento no cache da instrução. Seu valor especifica o tamanho do cache de instrução.
      O \code{external_credentials} argumento é usado para iniciar a sessão OCI
      autenticada com credenciais externas na conexão.
      O argumento \code{sysdba} é usado para iniciar a sessão OCI com privilégios SYSDBA
      na conexão.
      Ao estabelecer uma conexão com um driver \code{ExtDriver}, nenhum dos
      argumentos que especificam credenciais serão usados. Uma conexão neste modo
      é um objeto singleton, ou seja, todas as chamadas para \code{dbConnect}
      retornarão o mesmo objeto de conexão.
    }
    \item{dbDisconnect}{
      Esta implementação desconecta a conexão entre R e o servidor do
      banco de dados.  Ela libera todos os os recursos usados pelo objeto da conexão. Ela libera
      todos os conjuntos de resultados associados a este objeto de conexão.
    }
  }
}
\section{References}{
  For the Oracle Database documentation see
  \url{http://www.oracle.com/technetwork/indexes/documentation/index.html}.
}
\seealso{
  \code{\link{Oracle}},
  \code{\link[DBI]{dbConnect}},
  \code{\link[DBI]{dbSendQuery}},
  \code{\link[DBI]{dbGetQuery}},
  \code{\link[DBI]{fetch}},
  \code{\link[DBI]{dbCommit}},
  \code{\link[DBI]{dbGetInfo}},
  \code{\link[DBI]{dbReadTable}}.
}
\examples{
  \dontrun{
    ## create an Oracle Database instance and create one connection on the
    ## same machine.
    drv <- dbDriver("Oracle")

    ## use username/password authentication
    con <- dbConnect(drv, username = "scott", password = "tiger")

    ## run a SQL statement by creating first a resultSet object
    rs <- dbSendQuery(con, "select * from emp where deptno = 10")

    ## we now fetch records from the resultSet into a data.frame
    data <- fetch(rs)       ## extract all rows
    dim(data)
  }
  \dontrun{
    ## create an Oracle Database instance and create one connection to a
    ## remote database using the SID in the connect string. 
    drv <- dbDriver("Oracle")

    ## refer to Oracle Database Net Services Administator's Guide for
    ## details on connect string specification.
    host <- "myhost"
    port <- 1521
    sid <- "mysid"
    connect.string <- paste(
      "(DESCRIPTION=",
      "(ADDRESS=(PROTOCOL=tcp)(HOST=", host, ")(PORT=", port, "))",
        "(CONNECT_DATA=(SID=", sid, ")))", sep = "")

    ## use username/password authentication
    con <- dbConnect(drv, username = "scott", password = "tiger",
                     dbname = connect.string)

    ## run a SQL statement by creating first a resultSet object
    rs <- dbSendQuery(con, "select * from emp where deptno = 10")

    ## we now fetch records from the resultSet into a data.frame
    data <- fetch(rs)       ## extract all rows
    dim(data)
  }
  \dontrun{
    ## create an Oracle Database instance and create one connection to a
    ## remote database using the service name.
    drv <- dbDriver("Oracle")

    ## refer to Oracle Database Net Services Administator's Guide for
    ## details on connect string specification.

    host <- "myhost"
    port <- 1521
    svc <- "mydb.example.com"
    connect.string <- paste(
      "(DESCRIPTION=",
      "(ADDRESS=(PROTOCOL=tcp)(HOST=", host, ")(PORT=", port, "))",
      "(CONNECT_DATA=(SERVICE_NAME=", svc, ")))", sep = "")
    ## use username/password authentication
    con <- dbConnect(drv, username = "scott", password = "tiger",
                     dbname = connect.string)

    ## run a SQL statement by creating first a resultSet object
    rs <- dbSendQuery(con, "select * from emp where deptno = 10")

    ## we now fetch records from the resultSet into a data.frame
    data <- fetch(rs)       ## extract all rows
    dim(data)
  }
  \dontrun{
    ## create an Oracle Database instance and create one connection.
    drv <- dbDriver("Oracle")

    ## use Oracle Wallet authentication
    con <- dbConnect(drv, username ="", password="", 
    dbname = "<wallet_connect_string>")

    ## run a SQL statement by creating first a resultSet object
    rs <- dbSendQuery(con, "select * from emp where deptno = 10")

    ## we now fetch records from the resultSet into a data.frame
    data <- fetch(rs)       ## extract all rows
    dim(data)
  }
  \dontrun{
    ## create an Oracle Database instance and create one connection.
    drv <- dbDriver("Oracle")

    ## connect to a TimesTen IMDB instance using the easy connect 
    ## naming method where SampleDb is a direct driver TimesTen DSN
    con <- dbConnect(drv, username ="scott", password="tiger", 
                     dbname = "localhost/SampleDb:timesten_direct")

    ## run a SQL statement by creating first a resultSet object
    rs <- dbSendQuery(con, "select * from dual")

    ## we now fetch records from the resultSet into a data.frame
    data <- fetch(rs)       ## extract all rows
    dim(data)
  }
  \dontrun{
    ## connect to an extproc (this assumes that the driver has already
    ## been initialized in the embedded R code by passing an external
    ## pointer representing the extproc context)
    con <- dbConnect(Extproc())

    ## run a SQL statement by creating first a resultSet object
    rs <- dbSendQuery(con, "select * from dual")

    ## we now fetch records from the resultSet into a data.frame
    data <- fetch(rs)       ## extract all rows
    dim(data)
  }
  \dontrun{
    ## create an Oracle Database instance and create one connection.
    drv <- dbDriver("Oracle")

    ## create connection with SYSDBA privileges
    con <- dbConnect(drv, username ="scott", password="tiger",
                     sysdba = TRUE)

    ## run a SQL statement by creating first a resultSet object
    rs <- dbSendQuery(con, "select * from emp where deptno = 10")

    ## we now fetch records from the resultSet into a data.frame
    data <- fetch(rs)       ## extract all rows
    dim(data)
  }
  \dontrun{
    ## create an Oracle Database instance and create one connection.
    drv <- dbDriver("Oracle")
    
    ## Use OS authentication as an example of external authentication
    ## Make sure that databse user exist to allow an OS authentication

    ## create connection authenticated with external credentials 
    con <- dbConnect(drv, username ="", password="",
                     external_credentials = TRUE)
    
    ## Above dbConnect() used OS credentials to connect with database.

    ## run a SQL statement by creating first a resultSet object
    rs <- dbSendQuery(con, "select * from emp where deptno = 10")

    ## we now fetch records from the resultSet into a data.frame
    data <- fetch(rs)       ## extract all rows
    dim(data)
  }
}
\keyword{methods}
\keyword{interface}
\keyword{database}
