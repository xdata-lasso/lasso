-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: museum --
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (-2147483648, '5k5swwqcgs', 247012447, '2010');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (2, '8c4pgu7vfe', -1633151678, '2514');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (3, 'a2y', 1115440883, '1957');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (4, '5k5swwqcgs', 247012447, NULL);

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (5, '8c4pgu7vfe', -1633151678, NULL);

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (6, 'a2y', 1115440883, NULL);

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (7, 'hsrwbbp', 13244799, NULL);

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (8, 'hvdltt', -1610064545, NULL);

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (9, 'n', 462974032, NULL);
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
(2,)
*/