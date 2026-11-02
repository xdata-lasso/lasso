-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (1, 4, 'ExxonMobil', 'USA', 'Oil and gas', 433.5, 41.1, 331.1, 407.4);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (2, 1, 'Walmart', 'USA', 'Retail', 446.9, 15.7, 193.4, 208.3);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (3, 8, 'Toyota', 'Japan', 'Automotive', 228.5, 3.6, 371.3, 146.7);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (4, 2, 'Royal Dutch Shell', 'Netherlands', 'Oil and gas', 470.2, 30.9, 340.5, 227.6);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (5, 10, 'ICBC', 'China', 'Banking', 82.6, 25.1, 2039.1, 237.4);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (6, 5, 'Carrefour', 'France', 'Retail', 113.2, 0.5, 65.7, 16.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (7, 9, 'Volkswagen', 'Germany', 'Automotive', 221.9, 21.5, 328.7, 79.5);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (8, 6, 'Tesco', 'UK', 'Retail', 103.3, 4.5, 78.8, 42.5);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (9, 3, 'Chevron', 'USA', 'Oil and gas', 236.3, 26.9, 209.5, 218.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (10, 7, 'Costco', 'USA', 'Retail', 93.9, 1.5, 27.1, 39.6);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (101, 1998, 'Houston', 'Alice Smith', 'Bob Jones', 'Charlie Brown');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (102, 2005, 'London', 'David Clark', 'Eva Green', 'Frank White');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (101, 1, 1);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (102, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT main_industry FROM company ORDER BY main_industry;

/*
Gold Result:
('Automotive',)
('Banking',)
('Oil and gas',)
('Retail',)
*/

-- Prediction Query
SELECT DISTINCT main_industry FROM company;

/*
Prediction Result:
('Oil and gas',)
('Retail',)
('Automotive',)
('Banking',)
*/