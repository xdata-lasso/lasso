-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (1001, 'Allison Hill', 1004, 2003);
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (1002, 'Noah Rhodes', 1011.0, 2003);
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (1003, 'Angie Henderson', 1018.0, 2003);
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