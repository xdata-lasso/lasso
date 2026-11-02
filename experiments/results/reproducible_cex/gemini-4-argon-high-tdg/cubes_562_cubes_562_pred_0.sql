-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (1, 'Alice Smith', 30, 'Metropolis');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (2, 'Bob Jones', 25, 'Gotham');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (3, 'Charlie Brown', 40, 'Star City');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (1, 'Gamma Mart', 'South Ave', 'D2', 200, 'Manager Three');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (2, 'Alpha Store', 'North St', 'D3', 300, 'Manager Two');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (3, 'Delta Shop', 'East Blvd', 'D4', 400, 'Manager One');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (4, 'Beta Boutique', 'West Rd', 'D1', 100, 'Manager Four');
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (1, 2, '2020-01-15', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (2, 2, '2021-06-01', 0);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (3, 4, '2019-03-10', 1);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2021', 1500.50);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('2', '2022', 800.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION, district FROM shop ORDER BY name, shop.shop_id NULLS LAST;

/*
Gold Result:
('Alpha Store', 'North St', 'D3')
('Beta Boutique', 'West Rd', 'D1')
('Delta Shop', 'East Blvd', 'D4')
('Gamma Mart', 'South Ave', 'D2')
*/

-- Prediction Query
SELECT name, LOCATION, district FROM shop ORDER BY number_products DESC, shop.shop_id NULLS LAST;

/*
Prediction Result:
('Delta Shop', 'East Blvd', 'D4')
('Alpha Store', 'North St', 'D3')
('Gamma Mart', 'South Ave', 'D2')
('Beta Boutique', 'West Rd', 'D1')
*/