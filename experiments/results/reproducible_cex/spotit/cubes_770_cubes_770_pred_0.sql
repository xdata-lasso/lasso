-- Schema DDL
CREATE TABLE "CITY" (
    "CITY_ID" INT,
    "OFFICIAL_NAME" TEXT,
    "STATUS" TEXT,
    "AREA_KM_2" FLOAT,
    "POPULATION" FLOAT,
    "CENSUS_RANKING" TEXT,
    PRIMARY KEY ("CITY_ID")
);
CREATE TABLE "FARM" (
    "FARM_ID" INT,
    "YEAR" INT,
    "TOTAL_HORSES" FLOAT,
    "WORKING_HORSES" FLOAT,
    "TOTAL_CATTLE" FLOAT,
    "OXEN" FLOAT,
    "BULLS" FLOAT,
    "COWS" FLOAT,
    "PIGS" FLOAT,
    "SHEEP_AND_GOATS" FLOAT,
    PRIMARY KEY ("FARM_ID")
);
CREATE TABLE "FARM_COMPETITION" (
    "COMPETITION_ID" INT,
    "HOST_CITY_ID" INT,
    "YEAR" INT,
    "THEME" TEXT,
    "HOSTS" TEXT,
    PRIMARY KEY ("COMPETITION_ID"),
    FOREIGN KEY ("HOST_CITY_ID") REFERENCES "CITY"("CITY_ID")
);
CREATE TABLE "COMPETITION_RECORD" (
    "COMPETITION_ID" INT,
    "FARM_ID" INT,
    "RANK" INT,
    PRIMARY KEY ("COMPETITION_ID", "FARM_ID"),
    FOREIGN KEY ("FARM_ID") REFERENCES "FARM"("FARM_ID"),
    FOREIGN KEY ("COMPETITION_ID") REFERENCES "FARM_COMPETITION"("COMPETITION_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CITY VALUES (-1, 19, 20, 21, 1000, 22);
INSERT INTO CITY VALUES (0, 23, 24, 25, 1001, 26);
INSERT INTO FARM VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO FARM VALUES (1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO FARM_COMPETITION VALUES (1, 0, 0, 13, 14);
INSERT INTO FARM_COMPETITION VALUES (0, -1, 0, 0, 15);
INSERT INTO COMPETITION_RECORD VALUES (1, 1, 0);
INSERT INTO COMPETITION_RECORD VALUES (0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme FROM (SELECT LHS.city_id AS city_id, LHS.official_name AS official_name, LHS.status AS status, LHS.area_km_2 AS area_km_2, LHS.population AS population, LHS.census_ranking AS census_ranking, RHS.year AS YEAR, RHS.theme AS theme, RHS.host_city_id AS host_city_id, RHS.hosts AS hosts FROM (SELECT * FROM city WHERE (population > 1000.0)) AS LHS INNER JOIN farm_competition AS RHS ON (LHS.city_id = RHS.competition_id)) ORDER BY theme;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT T2.Theme FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID = T2.Host_city_ID WHERE T1.Population > 1000;

/*
Prediction Result:
('13',)
*/