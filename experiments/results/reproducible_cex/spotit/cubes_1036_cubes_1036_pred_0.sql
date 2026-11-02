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
INSERT INTO COLLEGE VALUES (1, 0, 7);
INSERT INTO COLLEGE VALUES (0, 1, 10);
INSERT INTO PLAYER VALUES (3, 0, 0, 0);
INSERT INTO PLAYER VALUES (2, 0, 0, 0);
INSERT INTO TRYOUT VALUES (2, 1, 8, 9);
INSERT INTO TRYOUT VALUES (3, 1, 11, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state FROM college ORDER BY state, college.cname NULLS LAST;

/*
Gold Result:
('0',)
('1',)
*/

-- Prediction Query
SELECT DISTINCT state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName;

/*
Prediction Result:
('0',)
*/