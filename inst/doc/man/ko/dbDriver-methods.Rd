\name{dbDriver-methods}
\docType{methods}
\alias{dbUnloadDriver}
\alias{dbUnloadDriver,OraDriver-method}
\alias{dbUnloadDriver,ExtDriver-method}
\title{
Oracle에서 DBI(데이터베이스 인터페이스) 클래스 및 드라이버를
  구현한 것입니다.
}
\description{
Oracle 드라이버 초기화 및 마감
}
\usage{
\S4method{dbUnloadDriver}{OraDriver}(drv, ...)
\S4method{dbUnloadDriver}{ExtDriver}(drv, ...)
}
\arguments{
  \item{drv}{
\code{OraDriver}에 의해 생성된 \code{ExtDriver} 또는 \code{dbDriver}에서
    상속되는 객체입니다.
}
  \item{...}{
다른 모든 인수는 \code{drvName} 드라이버에 전달됩니다.
}
}
\value{
\item{dbDriver}{
    해당 클래스가 \code{OraDriver}을(를) 확장하는 \code{ExtDriver} 또는 \code{DBIDriver}
    객체입니다. 이 객체는 \code{dbConnect} 함수를 사용하여 한 개 또는
    여러 개의 Oracle Database 엔진에 대한 접속을 생성하는 데 사용됩니다.
  }
  \item{dbUnloadDriver}{
    드라이버 객체에서 점유된 모든 리소스를 해제합니다.
  }
}
\section{Side Effects}{
  \describe{
    \item{dbDriver}{
      The \R client part of the database communication is initialized,
      but note that connecting to the database engine needs to be done through
      calls to \code{\link[DBI]{dbConnect}}.
    }
    \item{dbUnloadDriver}{
      Remove communication link between \R client and database.
    }
  }
}


\details{
\\describe{
    \item{dbDriver}{
      객체가 단일체입니다. 즉, 후속 호출 시 동일한
      초기화된 객체가 반환됩니다.
      이 구현에서는 여러 호스트 서버에 접속하고 각 서버에서
      여러 접속을 동시에 실행할 수 있습니다.
      중단 여부가 TRUE로 설정된 경우 서버에서 스레드에 질의를
      실행하여 장기 실행 질의를 중단할 수 있습니다. 기본 스레드는
      Ctrl-C를 검사하고 OCIBreak/OCIReset을 실행해서 서버에서 작업을
      취소합니다. 기본적으로 중단 가능 여부는 FALSE입니다.
    }
    \item{dbUnloadDriver}{
      \R 클라이언트와 데이터베이스 사이의 구현 제거 통신
      링크입니다. 모든 접속 및 이러한 접속 객체와 연관된 모든
      결과 집합을 해제합니다.
    }
  }
}
\section{References}{
  For the Oracle Database documentaion see
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
  \code{\link[DBI]{dbListTables}},
  \code{\link[DBI]{dbReadTable}}.
}
\examples{
  \dontrun{
    # create an Oracle instance
    drv <- dbDriver("Oracle")

    con <- dbConnect(drv, "scott", "tiger")
    res <- dbSendQuery(con, "select * from emp")
    fetch(res, n = 5)
    fetch(res)
    dbClearResult(res)
    dbUnloadDriver(drv)
  }
}
\keyword{methods}
\keyword{interface}
\keyword{database}
