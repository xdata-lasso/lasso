-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manager --
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (2, '5k5swwqcgs', 'man_5131e0', '9n8', 46, 1610062532);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (3, 'pgu7vfe4', 'man_5131e0', 'hria2ypuzhs', 46, 700293388);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (4, 'wbbp6luhvdlt', 'ilbnp', 'mdpos', 47, -1576219117);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (5, '5k5swwqcgs', '9n8', '4', 50, -734455130);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (6, '5k5swwqcgs', '9n8', '4', NULL, -734455130);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (7, '4h', 'ia2yp', 'uzhsrwbbp6lu', NULL, 1019800248);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (8, 'dlttil', 'n', 'rmdp', NULL, 2026480202);

INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (9, 'ie5', 'nw6klf', 'a9000t5c4eci', NULL, 1149850321);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM manager WHERE (age < 50 AND age <= 46) ORDER BY country;

/*
Gold Result:
('man_5131e0',)
*/

-- Prediction Query
SELECT Country FROM manager WHERE Age > 50 INTERSECT SELECT Country FROM manager WHERE Age < 46;

/*
Prediction Result:
*/