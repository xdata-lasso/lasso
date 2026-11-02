-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: museum --
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (-2147483648, '5k5swwqcgs', NULL, '2509');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (-2147483647, '9n8', NULL, '2509');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (2, '4', 2009, 'gu7v');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (3, 'e4', 1160656988, '1958');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (-2147483644, '5k5swwqcgs', 1, '9n8');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (-2147483643, '4', 1, 'gu7v');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (-2147483642, 'e4', 1, 'hria2ypuzhs');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (-2147483641, 'rwbbp6luhvd', 1, 'tti');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (-2147483640, 'bnp', 1, 'mdpos');

INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (-2147483639, 'ie5', 1, 'nw6klf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(num_of_staff) OVER () AS avg_num_of_staff_ FROM museum WHERE (num_of_staff = 2009 OR open_year < 2009) ORDER BY avg_num_of_staff_;

/*
Gold Result:
(580329498.5,)
*/

-- Prediction Query
SELECT AVG(num_of_staff) FROM museum WHERE open_year < 2009;

/*
Prediction Result:
(1160656988.0,)
*/