-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Ship A', 'Cargo', 2000.0, 'C1', 'US');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Ship B', 'Cargo', 2005.0, 'C2', 'UK');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 1, 'Alice', '20', 'A', '1');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (2, 2, 'Bob', '30', 'B', '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM captain ORDER BY ship_id DESC, captain.captain_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Bob',)
*/

-- Prediction Query
SELECT name FROM captain ORDER BY age, captain.captain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/