-- Schema DDL
CREATE TABLE "AIRLINES" (
    "UID" INT,
    "AIRLINE" TEXT,
    "ABBREVIATION" TEXT,
    "COUNTRY" TEXT,
    PRIMARY KEY ("UID")
);
CREATE TABLE "AIRPORTS" (
    "AIRPORTCODE" TEXT,
    "CITY" TEXT,
    "AIRPORTNAME" TEXT,
    "COUNTRY" TEXT,
    "COUNTRYABBREV" TEXT,
    PRIMARY KEY ("AIRPORTCODE")
);
CREATE TABLE "FLIGHTS" (
    "AIRLINE" INT,
    "FLIGHTNO" INT,
    "DESTAIRPORT" TEXT,
    "SOURCEAIRPORT" TEXT,
    PRIMARY KEY ("AIRLINE", "FLIGHTNO"),
    FOREIGN KEY ("DESTAIRPORT") REFERENCES "AIRPORTS"("AIRPORTCODE"),
    FOREIGN KEY ("SOURCEAIRPORT") REFERENCES "AIRPORTS"("AIRPORTCODE")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO AIRLINES VALUES (-1, 0, 15, 16);
INSERT INTO AIRLINES VALUES (0, 0, 17, 18);
INSERT INTO AIRPORTS VALUES (9, 0, 0, 0, 0);
INSERT INTO AIRPORTS VALUES (8, 0, 0, 0, 0);
INSERT INTO FLIGHTS VALUES (-2, 0, 9, 9);
INSERT INTO FLIGHTS VALUES (0, -1, 8, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airline_other AS airline FROM (SELECT * FROM (SELECT * FROM (SELECT airline, flightno, sourceairport, destairport, airline_other, airline AS n FROM (SELECT LHS.airline AS airline, LHS.flightno AS flightno, LHS.sourceairport AS sourceairport, LHS.destairport AS destairport, RHS.airline AS airline_other FROM flights AS LHS INNER JOIN (SELECT airline, COUNT(*) AS n FROM airlines GROUP BY airline) AS RHS ON (LHS.airline = RHS.n))) ORDER BY flightno) LIMIT 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid = T2.Airline GROUP BY T1.Airline ORDER BY COUNT(*) DESC, T1.Airline NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/