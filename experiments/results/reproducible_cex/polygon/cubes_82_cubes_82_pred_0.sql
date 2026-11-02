-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (9, '13', 2009, '2009');
INSERT INTO "museum" ("museum_id", "name", "num_of_staff", "open_year") VALUES (8, '14', 2011, '-635');
INSERT INTO "visitor" ("id", "name", "level_of_membership", "age") VALUES (11, '2009', 2009, 2009);
INSERT INTO "visitor" ("id", "name", "level_of_membership", "age") VALUES (10, '2009', 2009, 2009);
INSERT INTO "visit" ("museum_id", "visitor_id", "num_of_ticket", "total_spent") VALUES (8, '10', 2009, 2009);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(num_of_staff) OVER () AS avg_num_of_staff_ FROM museum WHERE (num_of_staff = 2009 OR open_year < 2009) ORDER BY avg_num_of_staff_;

/*
Gold Result:
(2010.0,)
*/

-- Prediction Query
SELECT AVG(num_of_staff) FROM museum WHERE open_year < 2009;

/*
Prediction Result:
(2011.0,)
*/