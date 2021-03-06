\name{dbSendQuery-methods}
\docType{methods}
\alias{dbSendQuery}
\alias{dbGetQuery}
\alias{dbClearResult}
\alias{dbGetException}
\alias{execute}
\alias{dbSendQuery,OraConnection,character-method}
\alias{dbGetQuery,OraConnection,character-method}
\alias{dbClearResult,OraResult-method}
\alias{dbGetException,OraConnection-method}
\alias{execute,OraResult-method}
\title{
Exécuter une instruction sur une connexion de base de données donnée
}
\description{
Ces méthodes sont des implémentations directes des
   fonctions génériques correspondantes, excepté pour la méthode \code{execute} qui est une
   extension DBI ROracle spécifique.
}
\usage{
\S4method{dbSendQuery}{OraConnection,character}(conn, statement, data = NULL, prefetch = FALSE, bulk_read = 1000L, ...)
\S4method{dbGetQuery}{OraConnection,character}(conn, statement, data = NULL, prefetch = FALSE, bulk_read = 1000L, ...)
\S4method{dbClearResult}{OraResult}(res, ...)
\S4method{dbGetException}{OraConnection}(conn, ...)

execute(res, ...)
\S4method{execute}{OraResult}(res, data = NULL, ...)
}
\arguments{
  \item{conn}{
objet \code{OraConnection}.
}
  \item{statement}{
vecteur de caractère de longueur 1 avec l'instruction SQL.
}
  \item{res}{
objet \code{OraResult}.
}
  \item{data}{
élément data.frame indiquant les données de liaison
}
  \item{prefetch}{
Valeur logique indiquant TRUE ou FALSE. Lorsque cette valeur est définie sur TRUE, ROracle utilise
    les tampons de préextraction OCI pour extraire des données supplémentaires du serveur, économisant ainsi
    la mémoire requise dans RODBI/ROOCI en attribuant un seul tampon de ligne pour extraire 
    les données à partir d'OCI. L'utilisation de la préextraction génère un appel d'extraction pour chaque ligne. Par
    défaut, la préextraction est définie sur FALSE et l'extraction par tableau est utilisée pour extraire les données à partir
    du serveur.
}
  \item{bulk_read}{
Valeur entière indiquant le nombre de lignes à extraire à la fois. La
    valeur par défaut est 1000L. Lorsque l'option de préextraction est sélectionnée, la mémoire est
    allouée aux tampons de préextraction et OCI extrait ce nombre de lignes à la fois.
    Lorsque la préextraction n'est pas utilisée (par défaut), la mémoire est allouée aux tampons définis
    RODBI/ROOCI. La définition de cette valeur sur un nombre plus important se traduira par l'allocation de plus de mémoire
    en fonction du nombre de colonnes dans la liste et les types
    de colonnes sélectionnés. Pour une colonne de type caractère, les tampons définis sont attribués
    à l'aide de la formule suivante : largeur maximale fois largeur maximale NLS. L'application doit
    ajuster cette valeur en fonction du résultat de requête et une valeur plus importante sera bénéfique pour
    les requêtes qui renvoient un résultat important. Une application peut régler cette valeur selon ses besoins.
}
  \item{\dots}{
inutilisé actuellement.
}
}
\value{
\item{dbSendQuery}{
    objet \code{OraResult} dont la classe étend \code{DBIResult}. Cet 
    objet est utilisé pour extraire des données de la base de données à l'aide de la fonction 
    \code{fetch}.
  }
}
\section{Side Effects}{
  \describe{
    \item{dbGetQuery}{
      query statement is executed and data has fetched from database.
    }
    \item{dbSendQuery}{
      query statement is executed, but note that data needs to fetch through
      calls to \code{\link[DBI]{fetch}}.
    }
    \item{dbClearResult}{
      resources acquired by result set has free.
    }
    \item{dbGetException}{
      error information retrieved and then cleaned from driver.
    }
    \item{execute}{
      query statement is executed.
    }
  }
}
\details{
\\describe{
    \item{dbGetQuery}{
      L'implémentation exécute l'instruction de requête et extrait 
      les données de résultat de la base de données. 
    }
    \item{dbSendQuery}{
      L'implémentation exécute l'instruction de requête et renvoie 
      l'ensemble de résultats à l'application. Désormais, l'application peut exécuter des opérations 
      sur l'ensemble de résultats. 
    }
    \item{dbClearResult}{
      L'implémentation libère les ressources occupées par l'ensemble de résultats.
    }
    \item{dbGetException}{
      L'implémentation extrait les informations d'erreur.
    }
    \item{execute}{
      L'implémentation exécute l'instruction de requête.
    }
  }
}
\section{References}{
  For the Oracle Database documentaion see 
  \url{http://www.oracle.com/technetwork/indexes/documentation/index.html}.
}
\seealso{
  \code{\link{Oracle}},
  \code{\link[DBI]{dbDriver}},
  \code{\link[DBI]{dbConnect}},
  \code{\link[DBI]{fetch}},
  \code{\link[DBI]{dbCommit}},
  \code{\link[DBI]{dbGetInfo}},
  \code{\link[DBI]{dbReadTable}}.
}
\examples{
  \dontrun{
    drv <- dbDriver("Oracle")
    con <- dbConnect(drv, "scott", "tiger")
    res <- dbSendQuery(con, "select * from emp where deptno = :1",
                       data = data.frame(deptno = 10))
    data <- fetch(res, n = -1)
    res2 <- dbSendQuery(con, "select * from emp where deptno = :1",
                        data1 = data.frame(deptno = 10), prefetch=TRUE,
                        bulk_read=2L)
    data1 <- fetch(res2, n = -1)
    res3 <- dbSendQuery(con, "select * from emp where deptno = :1",
                        data2 = data.frame(deptno = 10), bulk_read=10L)
    data2 <- fetch(res3, n = -1)
    res4 <- dbSendQuery(con, "select * from emp where ename = :1",
                        data3 = data.frame(ename = 'SMITH')) 
    data3 <- fetch(res4, n = -1)
  }
}
\keyword{methods}
\keyword{interface}
\keyword{database}
