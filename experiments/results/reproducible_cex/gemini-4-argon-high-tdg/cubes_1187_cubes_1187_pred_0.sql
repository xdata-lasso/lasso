-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (1, 'Orphan Ship', 'Cargo', 1995.0, 'First', 'USA');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (2, 'Active Ship', 'Destroyer', 2005.0, 'Second', 'UK');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (3, 'Fleet Ship', 'Cruiser', 2010.0, 'Third', 'France');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (1, NULL, NULL, NULL, NULL, 'Admiral');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (2, 2, 'Smith', '50', 'First', 'Admiral');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (3, 2, 'Jones', '40', 'Second', 'Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (4, 2, 'Jones', '40', 'Second', 'Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (5, 3, 'Brown', '35', 'Third', NULL);
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (6, NULL, 'Davis', '38', 'First', NULL);
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (7, 3, 'Miller', '28', 'Third', 'Lieutenant');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (8, 2, 'Wilson', '22', 'Second', 'Ensign');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (9, 3, 'Moore', '23', 'Third', 'Ensign');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (10, 3, 'Taylor', '24', 'First', 'Ensign');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, rank FROM (SELECT rank, COUNT(*) AS n FROM captain GROUP BY rank) ORDER BY count___, rank NULLS LAST;

/*
Gold Result:
(1, 'Lieutenant')
(2, 'Admiral')
(2, 'Captain')
(2, None)
(3, 'Ensign')
*/

-- Prediction Query
SELECT COUNT(*), rank FROM captain GROUP BY rank;

/*
Prediction Result:
(2, None)
(2, 'Admiral')
(2, 'Captain')
(3, 'Ensign')
(1, 'Lieutenant')
*/