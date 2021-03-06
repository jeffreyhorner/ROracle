\name{Oracle}
\alias{Oracle}
\alias{Extproc}
\title{
Creazione di un'istanza di un client Oracle dalla sessione \R corrente
}
\description{
Questa funzione crea e inizializza un client Oracle dalla 
  sessione \R corrente. Restituisce un oggetto che consente di connettersi
  a uno o più server Oracle.
}
\usage{
  Oracle(interruptible = FALSE)
  Extproc(extproc.ctx = NULL)
}
\arguments{
  \item{interruptible}{
Valore logico indicante se consentire gli interrupt utente sulle query con tempi di esecuzione lunghi.
}
  \item{extproc.ctx}{
Contesto extproc di wrapping di puntatore esterno.
}
}
\value{
Oggetto di classe \code{OraDriver} per \code{Oracle} o
  \code{ExtDriver} per \code{Extproc} la cui classe estende \code{DBIDriver}.
  Questo oggetto viene usato per creare le connessioni mediante
  la funzione \code{dbConnect} su uno o più motori del database Oracle.
}
\section{Side Effects}{
  The \R client part of the database communication is initialized,
  but note that connecting to the database engine needs to be done through
  calls to \code{\link[DBI]{dbConnect}}.
}


\details{
Questo oggetto è un singleton: ciò significa che restituisce lo stesso
  oggetto inizializzato nei richiami successivi.
  Questa implementazione consente di connettersi a più server host
  e di stabilire contemporaneamente più connessioni a ogni server.
  Quando è impostato su TRUE, interruptible consente l'interruzione delle query con
  tempi di esecuzione lunghi sul server mediante l'esecuzione della query in un
  thread. Il thread principale controlla Ctrl-C ed esegue OCIBreak/OCIReset per
  annullare l'operazione sul server. interruptible è FALSE per impostazione predefinita.
}
\section{Oracle user authentication}{
  In order to establish a connection to an Oracle server users need to provide
  a user name, a password, and possibly a connect identifier (for more
  informations refer to chapter 8 (Configuring Naming Methods) of Oracle
  Database Net Services Administrator's Guide). This is the same as part
  of the SQL*Plus connect string that follows the '@' sign.

  Connections to an Oracle TimesTen IMDB instance are established using the OCI
  tnsnames or easy connect naming methods. For additional information on 
  TimesTen connections for OCI see chapter 3 
  (TimesTen Support for Oracle Call Interface) of the Oracle TimesTen In-Memory
  C Developer's Guide.
}

\section{Transactions}{ 
  The current implementation directly supports transaction
  commits and rollbacks on a connection-wide basis through calls
  to \code{\link[DBI]{dbCommit}} and \code{\link[DBI]{dbRollback}}.
  Save points are not yet directly implemented, but you may be able
  to define them and rollback to them through calls to dynamic SQL
  with \code{\link[DBI]{dbGetQuery}}.

  Notice that Oracle (and ANSI/ISO compliant DBMS) transactions are 
  implicitly started when data definition SQL are executed (create
  table, etc.), which helper functions like \code{\link[DBI]{dbWriteTable}}
  may execute behind the scenes. You may want or need to commit
  or roll back your work before issuing any of these helper functions.
}

\section{References}{
  For the Oracle Database documentation see
  \url{http://www.oracle.com/technetwork/indexes/documentation/index.html}.
}
\author{David A. James and Denis Mukhin}
\seealso{
  On database managers:

  \code{\link[DBI]{dbDriver}}
  \code{\link[DBI]{dbUnloadDriver}}
  \code{\link[DBI]{dbListConnections}}

  On connections:

  \code{\link[DBI]{dbConnect}}
  \code{\link[DBI]{dbDisconnect}}
  \code{\link[DBI]{dbSendQuery}}
  \code{\link[DBI]{dbGetQuery}}
  \code{\link[DBI]{dbGetException}}
  \code{\link[DBI]{dbListResults}}

  Convenience methods:
  \code{\link[DBI]{dbListTables}}
  \code{\link[DBI]{dbReadTable}}
  \code{\link[DBI]{dbWriteTable}}
  \code{\link[DBI]{dbExistsTable}}
  \code{\link[DBI]{dbRemoveTable}}
  \code{\link[DBI]{dbListFields}}

  On transaction management:

  \code{\link[DBI]{dbCommit}}
  \code{\link[DBI]{dbRollback}}

  On queries and result objects:

  \code{\link[DBI]{fetch}}
  \code{\link[DBI]{dbClearResult}}
  \code{\link[DBI]{dbColumnInfo}}
  \code{\link[DBI]{dbGetStatement}}
  \code{\link[DBI]{dbHasCompleted}}
  \code{\link[DBI]{dbGetRowsAffected}}
  \code{\link[DBI]{dbGetRowCount}}

  On meta-data:

  \code{\link[methods]{show}}
  \code{\link[base]{summary}}
  \code{\link[DBI]{dbGetInfo}}
}
\examples{
  \dontrun{
    ## create a Oracle instance and create one connection.
    ora <- Oracle()         ## or dbDriver("Oracle")
    con <- dbConnect(ora, username = "scott", password = "tiger", 
                     dbname = "inst1")

    ## if you are connecting to a local database
    con <- dbConnect(ora, username = "scott", password = "tiger")

    ## execute a statement and fetch its output in chunks of no more
    ## than 5000 rows at a time
    rs   <- dbSendQuery(con, "select * from emp where deptno = 10")
    while (!dbHasCompleted(rs)) {
      df <- fetch(rs, n = 5000)
      ## process df
    }
    dbClearResult(rs)       ## done with this query

    ## execute and fetch a statement with bind data
    df <- dbGetQuery(con, "select * from emp where deptno = :1",
                     data = data.frame(depno = 10))

    ## create a copy of emp table
    dbGetQuery(con, "create table foo as select * from emp")

    ## execute and bind an INSERT statement
    my.data = data.frame(empno = c(8001, 8002), ename = c('MUKHIN', 'ABOYOUN'))
    more.data = data.frame(empno = c(8003), ename = c('JAMES'))
    rs <- dbSendQuery(con, "insert into foo (empno, ename) values (:1, :2)",
                      data = my.data)

    ## execute with more data
    execute(rs, data = more.data)
    dbClearResult(rs)       ## done with this query

    ## ok, everything looks fine
    dbCommit(con)           

    ## a concise description of the driver 
    summary(ora)

    ## done with this connection
    dbDisconnect(con)
  }
}
\keyword{interface}
\keyword{database}
