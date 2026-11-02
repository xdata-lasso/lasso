-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1078, 'Nicholas Mcbride', 2115.0, 'Sanchezfort');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1079, 'Amy Jones', 2095.0, 'Leeville');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1080, 'Gary Palmer', 2085.0, 'Gomezchester');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1081, 'John Ryan', 2075.0, 'Shieldston');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1090, 'Leah Smith', 2115.0, 'North Deniseside');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1091, 'Corey Herrera', 2005.0, 'North Sarabury');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1092, 'Clifford Ford', 1995.0, 'South Todd');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1093, 'Angela Morton', 1985.0, 'Port Richard');
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1078, 'report', 1086.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1078, 'ready', 1093.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1078, 'race', 1100.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1078, 'billion', 1107.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1090, 'artist', 1098.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1090, 'community', 1105.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1090, 'hundred', 1112.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1090, 'able', 1119.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.employee_id AS employee_id, LHS.name AS name, LHS.age AS age, LHS.city AS city, RHS.year_awarded AS year_awarded, RHS.bonus AS bonus FROM employee AS LHS INNER JOIN evaluation AS RHS ON (LHS.employee_id = RHS.employee_id)) ORDER BY age DESC) LIMIT 1);

/*
Gold Result:
('Nicholas Mcbride',)
*/

-- Prediction Query
SELECT t1.name FROM employee AS t1 JOIN evaluation AS t2 ON t1.Employee_ID = t2.Employee_ID ORDER BY t2.bonus DESC, t1.employee_id NULLS LAST, t2.employee_id NULLS LAST, t2.year_awarded NULLS LAST LIMIT 1;

/*
Prediction Result:
('Leah Smith',)
*/