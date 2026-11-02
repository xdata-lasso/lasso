-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (1, 'British Museum', 50, '2020');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (2, 'Prado', 50, '2020');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (3, 'Uffizi', 75, '2013');
INSERT INTO museum (Museum_ID, Name, Num_of_Staff, Open_Year) VALUES (4, 'Hermitage', 75, '2014');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___ FROM (SELECT museum_id, open_year, COUNT(*) AS n FROM museum GROUP BY museum_id, open_year) WHERE (open_year <= 2013 OR n <> 2008) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM museum WHERE open_year > 2013 OR open_year < 2008;

/*
Prediction Result:
(3,)
*/