-- Schema DDL
CREATE TABLE "FLIGHT" (
    "FLNO" FLOAT,
    "AID" FLOAT,
    "ORIGIN" TEXT,
    "DESTINATION" TEXT,
    "DISTANCE" FLOAT,
    "DEPARTURE_DATE" DATE,
    "ARRIVAL_DATE" DATE,
    "PRICE" FLOAT,
    PRIMARY KEY ("FLNO"),
    FOREIGN KEY ("AID") REFERENCES "AIRCRAFT"("AID")
);
CREATE TABLE "AIRCRAFT" (
    "AID" FLOAT,
    "NAME" TEXT,
    "DISTANCE" FLOAT,
    PRIMARY KEY ("AID")
);
CREATE TABLE "EMPLOYEE" (
    "EID" FLOAT,
    "NAME" TEXT,
    "SALARY" FLOAT,
    PRIMARY KEY ("EID")
);
CREATE TABLE "CERTIFICATE" (
    "EID" FLOAT,
    "AID" FLOAT,
    PRIMARY KEY ("EID", "AID"),
    FOREIGN KEY ("AID") REFERENCES "AIRCRAFT"("AID"),
    FOREIGN KEY ("EID") REFERENCES "EMPLOYEE"("EID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO FLIGHT VALUES (3, 8, 0, 16, 17, '0001-01-01', '0001-01-01', 18);
INSERT INTO FLIGHT VALUES (4, 8, 0, 16, 17, '0001-01-01', '0001-01-01', 18);
INSERT INTO AIRCRAFT VALUES (8, 0, 0);
INSERT INTO AIRCRAFT VALUES (5, 0, 0);
INSERT INTO EMPLOYEE VALUES (6, 0, 0);
INSERT INTO EMPLOYEE VALUES (7, 0, 0);
INSERT INTO CERTIFICATE VALUES (6, 5);
INSERT INTO CERTIFICATE VALUES (6, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin_other AS origin FROM (SELECT LHS.departure_date AS departure_date, LHS.origin AS origin, LHS.n AS n, RHS.departure_date AS departure_date_other, RHS.origin AS origin_other, RHS.n AS n_other FROM (SELECT departure_date, origin, COUNT(*) AS n FROM flight GROUP BY departure_date, origin) AS LHS CROSS JOIN (SELECT departure_date, origin, COUNT(*) AS n FROM flight GROUP BY departure_date, origin) AS RHS) WHERE (n < n_other) ORDER BY origin;

/*
Gold Result:
*/

-- Prediction Query
SELECT origin FROM Flight GROUP BY origin ORDER BY COUNT(*) DESC, origin NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/