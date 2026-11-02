-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1014, 'David Leblanc', '570 Sarah Wells
Johnbury, FM 74865', 'your', 1015, 'Nicholas Cabrera');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1016, 'Scott Pierce', '570 Sarah Wells
Johnbury, FM 74865', 'end', 1017, 'George Chapman');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1018, 'Lisa Hernandez', '6670 Bruce Stream Suite 133
New Shane, NE 24551', 'material', 1019, 'John Russell');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION, district FROM shop ORDER BY name, shop.shop_id NULLS LAST;

/*
Gold Result:
('David Leblanc', '570 Sarah Wells\nJohnbury, FM 74865', 'your')
('Lisa Hernandez', '6670 Bruce Stream Suite 133\nNew Shane, NE 24551', 'material')
('Scott Pierce', '570 Sarah Wells\nJohnbury, FM 74865', 'end')
*/

-- Prediction Query
SELECT name, LOCATION, district FROM shop ORDER BY number_products DESC, shop.shop_id NULLS LAST;

/*
Prediction Result:
('Lisa Hernandez', '6670 Bruce Stream Suite 133\nNew Shane, NE 24551', 'material')
('Scott Pierce', '570 Sarah Wells\nJohnbury, FM 74865', 'end')
('David Leblanc', '570 Sarah Wells\nJohnbury, FM 74865', 'your')
*/