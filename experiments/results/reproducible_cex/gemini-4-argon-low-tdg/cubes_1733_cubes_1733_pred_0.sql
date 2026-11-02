-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (1, 28, 'Zara', 'USA', 'MIT');
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (2, 34, 'Alice', 'UK', 'Oxford');
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (3, 45, 'Bob', 'Canada', 'Toronto');
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (4, 22, 'Alice', 'USA', 'Harvard');
INSERT INTO "people" ("People_ID", "Age", "Name", "Nationality", "Graduation_College") VALUES (5, 50, 'Charlie', 'UK', 'Cambridge');
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (1, 'TechCorp', 'USA', 'Technology', 50.5, 10.2, 100.0, 200.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (2, 'BioHealth', 'UK', 'Healthcare', 20.0, 4.5, 45.0, 80.0);
INSERT INTO "company" ("Company_ID", "Name", "Headquarters", "Industry", "Sales_in_Billion", "Profits_in_Billion", "Assets_in_Billion", "Market_Value_in_Billion") VALUES (5, 'FinBank', 'Canada', 'Finance', 80.0, 15.0, 500.0, 150.0);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (1, 3, 5);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (2, 3, 3);
INSERT INTO "employment" ("Company_ID", "People_ID", "Year_working") VALUES (5, 5, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM employment AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zara',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM employment);

/*
Prediction Result:
('Zara',)
('Alice',)
('Alice',)
*/