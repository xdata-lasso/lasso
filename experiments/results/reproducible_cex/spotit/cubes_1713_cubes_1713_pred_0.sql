-- Schema DDL
CREATE TABLE "AIRPORT" (
    "ID" INT,
    "CITY" TEXT,
    "COUNTRY" TEXT,
    "IATA" TEXT,
    "ICAO" TEXT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "OPERATE_COMPANY" (
    "ID" INT,
    "NAME" TEXT,
    "TYPE" TEXT,
    "PRINCIPAL_ACTIVITIES" TEXT,
    "INCORPORATED_IN" TEXT,
    "GROUP_EQUITY_SHAREHOLDING" FLOAT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "FLIGHT" (
    "ID" INT,
    "COMPANY_ID" INT,
    "AIRPORT_ID" INT,
    "VEHICLE_FLIGHT_NUMBER" TEXT,
    "DATE" TEXT,
    "PILOT" TEXT,
    "VELOCITY" FLOAT,
    "ALTITUDE" FLOAT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("COMPANY_ID") REFERENCES "OPERATE_COMPANY"("ID"),
    FOREIGN KEY ("AIRPORT_ID") REFERENCES "AIRPORT"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO AIRPORT VALUES (2, NULL, NULL, 18, 19, 20);
INSERT INTO AIRPORT VALUES (-1, 21, 22, NULL, 24, 25);
INSERT INTO OPERATE_COMPANY VALUES (3, 30, 68, 69, 70, 71);
INSERT INTO OPERATE_COMPANY VALUES (-2, 31, 77, 78, 79, 80);
INSERT INTO FLIGHT VALUES (0, -2, -1, 72, NULL, 74, 75, 76);
INSERT INTO FLIGHT VALUES (-1, -2, -1, 81, 82, 83, 84, 85);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airport_id AS id, n AS count___ FROM (SELECT LHS.id AS id, LHS.city AS city, LHS.country AS country, LHS.iata AS iata, LHS.icao AS icao, LHS.name AS name, LHS.type AS TYPE, LHS.principal_activities AS principal_activities, LHS.incorporated_in AS incorporated_in, LHS.group_equity_shareholding AS group_equity_shareholding, RHS.airport_id AS airport_id, RHS.n AS n FROM (SELECT LHS.id AS id, LHS.city AS city, LHS.country AS country, LHS.iata AS iata, LHS.icao AS icao, LHS.name AS name, RHS.type AS TYPE, RHS.principal_activities AS principal_activities, RHS.incorporated_in AS incorporated_in, RHS.group_equity_shareholding AS group_equity_shareholding FROM airport AS LHS INNER JOIN operate_company AS RHS ON (LHS.id = RHS.id AND LHS.name = RHS.name)) AS LHS CROSS JOIN (SELECT airport_id, COUNT(*) AS n FROM flight GROUP BY airport_id) AS RHS) ORDER BY id, count___ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.id, COUNT(*) FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id JOIN airport AS T3 ON T2.airport_id = T3.id GROUP BY T3.id;

/*
Prediction Result:
(-1, 2)
*/