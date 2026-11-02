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
INSERT INTO FLIGHT VALUES (4, 9, 10, 11, 75, '0001-01-01', '0001-01-01', 76);
INSERT INTO FLIGHT VALUES (5, 6, 12, 12, 77, '0001-01-01', '0001-01-01', 78);
INSERT INTO AIRCRAFT VALUES (9, 14, 15);
INSERT INTO AIRCRAFT VALUES (6, 0, 16);
INSERT INTO EMPLOYEE VALUES (7, 0, 0);
INSERT INTO EMPLOYEE VALUES (8, 0, 0);
INSERT INTO CERTIFICATE VALUES (8, 6);
INSERT INTO CERTIFICATE VALUES (7, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.aid AS aid, LHS.price AS price, LHS.n AS n, RHS.name AS name, RHS.distance AS distance FROM (SELECT aid, price, COUNT(*) AS n FROM (SELECT flno, destination AS origin, destination, distance, departure_date, arrival_date, price, aid, flno_other, distance_other, departure_date_other, arrival_date_other, price_other, aid_other FROM (SELECT flno, origin, origin AS destination, distance, departure_date, arrival_date, price, aid, flno_other, distance_other, departure_date_other, arrival_date_other, price_other, aid_other FROM (SELECT LHS.flno AS flno, LHS.origin AS origin, LHS.destination AS destination, LHS.distance AS distance, LHS.departure_date AS departure_date, LHS.arrival_date AS arrival_date, LHS.price AS price, LHS.aid AS aid, RHS.flno AS flno_other, RHS.distance AS distance_other, RHS.departure_date AS departure_date_other, RHS.arrival_date AS arrival_date_other, RHS.price AS price_other, RHS.aid AS aid_other FROM flight AS LHS INNER JOIN flight AS RHS ON (LHS.origin = RHS.destination AND LHS.destination = RHS.origin)))) GROUP BY aid, price) AS LHS LEFT JOIN aircraft AS RHS ON (LHS.aid = RHS.aid)) ORDER BY name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT T2.name FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid = T2.aid GROUP BY T1.aid HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/