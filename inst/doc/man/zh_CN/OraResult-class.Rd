\name{OraResult-class}
\docType{class}
\alias{OraResult-class}
\title{
类 OraResult
}
\description{
Oracle 查询结果类。此类封装 SQL 语句
  的结果。
}
\section{Generators}{
   The main generator is \code{\link[DBI]{dbSendQuery}}.
}
\section{Extends}{
Class \code{"DBIResult"}, directly.
Class \code{"DBIObject"}, by class \code{"DBIResult"}, distance 2.
}
\section{Methods}{
  \describe{
    \item{dbClearResult}{\code{signature(res = "OraResult")}: ... }
    \item{dbColumnInfo}{\code{signature(res = "OraResult")}: ... }
    \item{dbGetInfo}{\code{signature(dbObj = "OraResult")}: ... }
    \item{dbGetStatement}{\code{signature(res = "OraResult")}: ... }
    \item{dbGetRowCount}{\code{signature(res = "OraResult")}: ... }
    \item{dbGetRowsAffected}{\code{signature(res = "OraResult")}: ... }
    \item{dbHasCompleted}{\code{signature(res = "OraResult")}: ... }
    \item{fetch}{\code{signature(res = "OraResult", n = "numeric")}: ... }
    \item{fetch}{\code{signature(res = "OraResult", n = "missing")}: ... }
    \item{execute}{\code{signature(res = "OraResult")}: ...}
    \item{summary}{\code{signature(object = "OraResult")}: ... }
    \item{show}{\code{signature(object = "OraResult")} }
  }
}
\seealso{
 DBI classes:
 \code{\link{OraDriver-class}}
 \code{\link{OraConnection-class}}
 \code{\link{OraResult-class}}
}
\examples{\dontrun{
ora <- dbDriver("Oracle")
con <- dbConnect(ora, "scott", "tiger")
res <- dbSendQuery(con, "select * from emp")
fetch(res, n = 2)
fetch(res)
dbColumnInfo(res)
dbClearResult(res)
}
}
\keyword{database}
\keyword{interface}
\keyword{classes}
