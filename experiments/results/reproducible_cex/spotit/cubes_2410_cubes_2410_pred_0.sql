-- Schema DDL
CREATE TABLE "SWIMMER" (
    "ID" INT,
    "NAME" TEXT,
    "NATIONALITY" TEXT,
    "METER_100" FLOAT,
    "METER_200" TEXT,
    "METER_300" TEXT,
    "METER_400" TEXT,
    "METER_500" TEXT,
    "METER_600" TEXT,
    "METER_700" TEXT,
    "TIME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "STADIUM" (
    "ID" INT,
    "NAME" TEXT,
    "CAPACITY" INT,
    "CITY" TEXT,
    "COUNTRY" TEXT,
    "OPENING_YEAR" INT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "EVENT" (
    "ID" INT,
    "STADIUM_ID" INT,
    "NAME" TEXT,
    "YEAR" TEXT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("STADIUM_ID") REFERENCES "STADIUM"("ID")
);
CREATE TABLE "RECORD" (
    "SWIMMER_ID" INT,
    "EVENT_ID" INT,
    "ID" INT,
    "RESULT" TEXT,
    PRIMARY KEY ("SWIMMER_ID", "EVENT_ID"),
    FOREIGN KEY ("SWIMMER_ID") REFERENCES "SWIMMER"("ID"),
    FOREIGN KEY ("EVENT_ID") REFERENCES "EVENT"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO SWIMMER VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO SWIMMER VALUES (-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO STADIUM VALUES (-1, 12, 0, 13, 14, 0);
INSERT INTO STADIUM VALUES (0, 17, 0, 18, 19, 0);
INSERT INTO EVENT VALUES (-1, 0, 15, 16);
INSERT INTO EVENT VALUES (0, 0, 20, 21);
INSERT INTO RECORD VALUES (0, 0, 0, 0);
INSERT INTO RECORD VALUES (0, -1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM stadium AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT id, name, capacity, city, country, opening_year, id_other, name_other, YEAR, id AS stadium_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.capacity AS capacity, LHS.city AS city, LHS.country AS country, LHS.opening_year AS opening_year, RHS.id AS id_other, RHS.name AS name_other, RHS.year AS YEAR FROM stadium AS LHS INNER JOIN event AS RHS ON (LHS.id = RHS.stadium_id))) AS RHS WHERE (LHS.id = RHS.id AND LHS.opening_year = RHS.opening_year))) ORDER BY name;

/*
Gold Result:
('12',)
*/

-- Prediction Query
SELECT name FROM stadium WHERE NOT id IN (SELECT stadium_id FROM event);

/*
Prediction Result:
('12',)
*/