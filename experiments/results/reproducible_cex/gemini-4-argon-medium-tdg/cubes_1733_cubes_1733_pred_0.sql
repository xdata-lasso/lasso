-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard anti-join, ORDER BY Name (inserted out of alphabetical order), duplicate names (tests DISTINCT vs ALL), and joining on Company_ID instead of People_ID.
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (1, 30, 'Zack', 'USA', 'MIT');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (2, 25, 'Alice', 'UK', 'Oxford');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (3, 28, 'Alice', 'Canada', 'Toronto');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (4, 40, 'Bob', 'USA', 'Harvard');
INSERT INTO people (People_ID, Age, Name, Nationality, Graduation_College) VALUES (5, 35, 'Charlie', 'USA', 'Stanford');
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (1, 'TechCorp', 'USA', 'Tech', 10.0, 2.0, 50.0, 100.0);
INSERT INTO company (Company_ID, Name, Headquarters, Industry, Sales_in_Billion, Profits_in_Billion, Assets_in_Billion, Market_Value_in_Billion) VALUES (2, 'BioHealth', 'UK', 'Healthcare', 5.0, 1.0, 20.0, 40.0);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (1, 4, 5);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (2, 4, 3);
INSERT INTO employment (Company_ID, People_ID, Year_working) VALUES (1, 5, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM employment AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM employment);

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
*/