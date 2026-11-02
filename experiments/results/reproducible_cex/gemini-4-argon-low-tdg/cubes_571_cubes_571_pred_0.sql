-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Empty evaluation table and NULL employee name handling
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (10, 'Zack', 22, 'Boston');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (20, 'Aaron', 29, 'Seattle');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (30, NULL, 45, 'Austin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM employee AS LHS WHERE NOT EXISTS(SELECT 1 FROM evaluation AS RHS WHERE (LHS.employee_id = RHS.employee_id))) ORDER BY name;

/*
Gold Result:
(None,)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM employee WHERE NOT Employee_ID IN (SELECT Employee_ID FROM evaluation);

/*
Prediction Result:
('Zack',)
('Aaron',)
(None,)
*/