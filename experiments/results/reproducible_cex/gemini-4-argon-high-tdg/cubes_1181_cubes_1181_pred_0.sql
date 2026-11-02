-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (5, 'Ship_A', 'Type_A', 1950.0, 'SClass_A', 'Flag_A');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (10, 'Ship_Z', 'Type_Z', 2020.0, 'SClass_Z', 'Flag_Z');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (50, 'Ship_M', 'Type_M', 1990.0, 'SClass_M', 'Flag_M');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (99, 'Ship_Unassigned', 'Type_U', 2025.0, 'SClass_U', 'Flag_U');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (1, 10, 'AA_OverallFirst', '18', 'Class_AA', 'Rank_AA');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (10, 50, 'M_Winner', '40', 'Class_M', 'Rank_M');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (20, 50, 'A_TieFirst', '20', 'Class_A', 'Rank_A');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (30, 50, 'Z_TieLast', '60', 'Class_Z', 'Rank_Z');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (100, 5, 'ZZ_OverallLast', '80', 'Class_ZZ', 'Rank_ZZ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM captain ORDER BY ship_id DESC, captain.captain_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('M_Winner',)
*/

-- Prediction Query
SELECT name FROM captain ORDER BY age, captain.captain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('AA_OverallFirst',)
*/