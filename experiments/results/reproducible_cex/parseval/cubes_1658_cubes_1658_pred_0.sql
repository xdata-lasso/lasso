-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manager --
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (-2147483648, '5k5swwqcgs', 'man_f13ce5', '9n8', 1610062532, -106629402);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (-2147483647, 'u7', 'Australia ', 'fe4hri', 1914020640, NULL);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (-2147483646, 'ypuzhsrw', 'Australia ', 'b', 1072996612, NULL);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (-2147483645, 'luhvdltti', 'man_f13ce5', 'bnp', 1236688122, NULL);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (-2147483644, 'dpos', 'man_057ab0', 'ie5', -1209887326, NULL);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (-2147483643, 'klfa9000t', 'man_f13ce5', 'c4ecigce', -1585009206, NULL);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (-2147483642, '52zb', 'man_057ab0', 'uo4nrqrofqy', -1106983592, NULL);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (2, '5k5swwqcgs', NULL, '9n8', 1610062532, -106629402);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (3, 'u7', 'man_694d92', 'fe4hri', 1914020640, 1268590800);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (4, 'puzhsrw', 'man_694d92', 'b', 1072996612, 13244799);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (5, 'hvdltt', 'man_694d92', 'lbn', 462974032, -1137908826);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (6, 'siie5unw6k', 'man_694d92', 'fa9', 1620389964, 546571701);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LEVEL AS max_level_ FROM (SELECT * FROM (SELECT * FROM (SELECT LEVEL, manager_id, MAX(country) AS country FROM manager GROUP BY LEVEL, manager_id) ORDER BY country) LIMIT 1);

/*
Gold Result:
(-106629402,)
*/

-- Prediction Query
SELECT MAX(LEVEL) FROM manager WHERE Country <> 'Australia ';

/*
Prediction Result:
(1268590800,)
*/