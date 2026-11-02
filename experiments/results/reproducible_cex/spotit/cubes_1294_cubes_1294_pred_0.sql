-- Schema DDL
CREATE TABLE "FILM" (
    "FILM_ID" INT,
    "RANK_IN_SERIES" INT,
    "NUMBER_IN_SEASON" INT,
    "TITLE" TEXT,
    "DIRECTED_BY" TEXT,
    "ORIGINAL_AIR_DATE" TEXT,
    "PRODUCTION_CODE" TEXT,
    PRIMARY KEY ("FILM_ID")
);
CREATE TABLE "CINEMA" (
    "CINEMA_ID" INT,
    "NAME" TEXT,
    "OPENNING_YEAR" INT,
    "CAPACITY" INT,
    "LOCATION" TEXT,
    PRIMARY KEY ("CINEMA_ID")
);
CREATE TABLE "SCHEDULE" (
    "CINEMA_ID" INT,
    "FILM_ID" INT,
    "DATE" TEXT,
    "SHOW_TIMES_PER_DAY" INT,
    "PRICE" FLOAT,
    PRIMARY KEY ("CINEMA_ID", "FILM_ID"),
    FOREIGN KEY ("CINEMA_ID") REFERENCES "CINEMA"("CINEMA_ID"),
    FOREIGN KEY ("FILM_ID") REFERENCES "FILM"("FILM_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO FILM VALUES (-1, 0, 0, 26, 0, 27, 28);
INSERT INTO FILM VALUES (0, 0, 0, 31, -1, 32, 33);
INSERT INTO CINEMA VALUES (0, 0, 0, 0, 0);
INSERT INTO CINEMA VALUES (1, 0, 0, 0, 0);
INSERT INTO SCHEDULE VALUES (1, 0, 24, 0, 25);
INSERT INTO SCHEDULE VALUES (0, 0, 29, 0, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT directed_by FROM (SELECT film_id, rank_in_series, number_in_season, title, directed_by, original_air_date, production_code, film_id_other, date, show_times_per_day, price, number_in_season AS cinema_id FROM (SELECT LHS.film_id AS film_id, LHS.rank_in_series AS rank_in_series, LHS.number_in_season AS number_in_season, LHS.title AS title, LHS.directed_by AS directed_by, LHS.original_air_date AS original_air_date, LHS.production_code AS production_code, RHS.film_id AS film_id_other, RHS.date AS date, RHS.show_times_per_day AS show_times_per_day, RHS.price AS price FROM film AS LHS INNER JOIN schedule AS RHS ON (LHS.number_in_season = RHS.cinema_id))) ORDER BY directed_by;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT T2.directed_by FROM schedule AS T1 JOIN film AS T2 ON T1.film_id = T2.film_id GROUP BY T2.directed_by ORDER BY SUM(T1.show_times_per_day) DESC, T2.directed_by NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/