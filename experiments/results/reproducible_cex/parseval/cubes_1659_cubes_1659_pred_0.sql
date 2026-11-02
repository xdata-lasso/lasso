-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manager --
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1, 'man_e319fb', 'man_4e2cb6', 'man_518936', 1, 1);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (-2147483647, 'man_7e2e4d', 'man_8ad73e', 'man_3061a6', 1, 1);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (-1, '5', '5k5swwqcgs', '9n8', 1610062532, -106629402);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (0, '4', 'u7', 'fe4hri', 1914020640, 1268590800);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (-2147483644, 'q_1_5abcb4', 'puzhsrw', 'b', 1072996612, 13244799);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (-2147483643, 'q_1_5abcb4', 'hvdltt', 'lbn', 462974032, -1137908826);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM manager ORDER BY name DESC, manager.manager_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('q_1_5abcb4',)
*/

-- Prediction Query
SELECT Name FROM manager ORDER BY Age DESC, manager.manager_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('4',)
*/