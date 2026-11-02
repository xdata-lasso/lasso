-- Schema DDL
CREATE TABLE "STATION" (
    "STATION_ID" INT,
    "NAME" TEXT,
    "ANNUAL_ENTRY_EXIT" FLOAT,
    "ANNUAL_INTERCHANGES" FLOAT,
    "TOTAL_PASSENGERS" FLOAT,
    "LOCATION" TEXT,
    "MAIN_SERVICES" TEXT,
    "NUMBER_OF_PLATFORMS" INT,
    PRIMARY KEY ("STATION_ID")
);
CREATE TABLE "TRAIN" (
    "TRAIN_ID" INT,
    "NAME" TEXT,
    "TIME" TEXT,
    "SERVICE" TEXT,
    PRIMARY KEY ("TRAIN_ID")
);
CREATE TABLE "TRAIN_STATION" (
    "TRAIN_ID" INT,
    "STATION_ID" INT,
    PRIMARY KEY ("TRAIN_ID", "STATION_ID"),
    FOREIGN KEY ("STATION_ID") REFERENCES "STATION"("STATION_ID"),
    FOREIGN KEY ("TRAIN_ID") REFERENCES "TRAIN"("TRAIN_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STATION VALUES (1, 1, 27, 28, 29, 30, 31, 0);
INSERT INTO STATION VALUES (0, 1, 32, 33, 34, 30, 35, 0);
INSERT INTO TRAIN VALUES (1, 0, 0, 0);
INSERT INTO TRAIN VALUES (0, 0, 0, 0);
INSERT INTO TRAIN_STATION VALUES (1, 0);
INSERT INTO TRAIN_STATION VALUES (0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LOCATION, name, COUNT(*) AS n FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.annual_entry_exit AS annual_entry_exit, RHS.annual_interchanges AS annual_interchanges, RHS.total_passengers AS total_passengers, RHS.location AS LOCATION, RHS.main_services AS main_services, RHS.number_of_platforms AS number_of_platforms FROM train_station AS LHS INNER JOIN station AS RHS ON (LHS.station_id = RHS.station_id)) GROUP BY LOCATION, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('1', 2)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id;

/*
Prediction Result:
('1', 1)
('1', 1)
*/