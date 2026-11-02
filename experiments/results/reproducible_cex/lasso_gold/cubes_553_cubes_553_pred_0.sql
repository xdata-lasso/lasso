-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1006, 'Jonathan Johnson', 1007, 'Lake Debra');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1008, 'Christopher Bernard', 1008, 'Port Lindachester');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employee ORDER BY name, employee.employee_id NULLS LAST;

/*
Gold Result:
('Christopher Bernard',)
('Jonathan Johnson',)
*/

-- Prediction Query
SELECT name FROM employee ORDER BY age, employee.employee_id NULLS LAST;

/*
Prediction Result:
('Jonathan Johnson',)
('Christopher Bernard',)
*/