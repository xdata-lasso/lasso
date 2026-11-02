-- Schema DDL
CREATE TABLE "COLLEGE" (
    "CNAME" TEXT,
    "STATE" TEXT,
    "ENR" FLOAT,
    PRIMARY KEY ("CNAME")
);
CREATE TABLE "PLAYER" (
    "PID" FLOAT,
    "PNAME" TEXT,
    "YCARD" TEXT,
    "HS" FLOAT,
    PRIMARY KEY ("PID")
);
CREATE TABLE "TRYOUT" (
    "PID" FLOAT,
    "CNAME" TEXT,
    "PPOS" TEXT,
    "DECISION" TEXT,
    PRIMARY KEY ("CNAME", "PID"),
    FOREIGN KEY ("CNAME") REFERENCES "COLLEGE"("CNAME"),
    FOREIGN KEY ("PID") REFERENCES "PLAYER"("PID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COLLEGE VALUES (3, 0, 0);
INSERT INTO COLLEGE VALUES (4, 0, 0);
INSERT INTO PLAYER VALUES (7, 0, 0, 0);
INSERT INTO PLAYER VALUES (5, 0, 0, 0);
INSERT INTO TRYOUT VALUES (7, 4, 0, 13);
INSERT INTO TRYOUT VALUES (7, 3, 0, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT ppos FROM (SELECT LHS.pid AS pid, LHS.ppos AS ppos, LHS.n AS n, RHS.pid AS pid_other, RHS.ppos AS ppos_other, RHS.n AS n_other FROM (SELECT pid, ppos, COUNT(*) AS n FROM tryout GROUP BY pid, ppos) AS LHS CROSS JOIN (SELECT pid, ppos, COUNT(*) AS n FROM tryout GROUP BY pid, ppos) AS RHS) WHERE (n > n_other) ORDER BY ppos;

/*
Gold Result:
*/

-- Prediction Query
SELECT pPos FROM tryout GROUP BY pPos ORDER BY COUNT(*) DESC, pPos NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/