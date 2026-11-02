-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (1, 'Alice Smith', 30, 'New York');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (2, 'Bob Jones', 25, 'Boston');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (3, 'Charlie Brown', 40, 'Chicago');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (1, 'Corner Mart', 'Main St', 'North', 20, 'Dan White');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (2, 'Mega Store', 'Broadway', 'East', 500, 'Eve Black');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (3, 'Quick Stop', 'Oak Ave', 'South', 90, 'Frank Green');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (4, 'Hyper Plaza', 'Park Blvd', 'West', 1000, 'Grace Hall');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (5, 'Midway Shop', 'Pine Rd', 'Central', 150, 'Hank King');
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (1, 2, '2020-01-10', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (2, 2, '2021-03-15', 0);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (3, 1, '2019-07-01', 1);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('1', '2022', 1500.0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('3', '2021', 2000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT shop_id, name, LOCATION, district, number_products, manager_name, AVG(number_products) OVER () AS meannumber_products FROM shop) ORDER BY number_products DESC) LIMIT 3);

/*
Gold Result:
('Hyper Plaza',)
('Mega Store',)
('Midway Shop',)
*/

-- Prediction Query
SELECT name FROM shop WHERE number_products > (SELECT AVG(number_products) FROM shop);

/*
Prediction Result:
('Mega Store',)
('Hyper Plaza',)
*/