-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (company_id, name, headquarters, industry, sales_in_billion, profits_in_billion, assets_in_billion, market_value_in_billion) VALUES (1.0, NULL, NULL, 'default2', 1.0, NULL, 2.0, NULL), (0.0, 'default2', 'default1', 'default1', 1.0, 2.0, 2.0, 1.0), (2.0, NULL, 'default2', 'default1', 0.0, 0.0, 1.0, NULL), (50000.0, NULL, NULL, 'default1', 2.0, 1.0, 2.0, 0.0), (100000.0, NULL, NULL, 'default2', 1.0, 2.0, NULL, NULL);
INSERT INTO people (people_id, age, name, nationality, graduation_college) VALUES (1, 1, 'default1', 'default1', NULL), (2, 2, 'default2', NULL, 'default2'), (0, 0, 'default2', 'default2', NULL), (3, NULL, 'default1', 'default2', 'default2'), (4, NULL, 'default1', NULL, 'default2'), (5, 1, NULL, 'default2', 'default1'), (6, 1, NULL, 'default2', 'default2'), (7, 0, 'default2', 'default2', 'default1'), (8, NULL, 'default2', 'default2', NULL);
INSERT INTO employment (company_id, people_id, year_working) VALUES (1.0, 4, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM employment AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default1',)
('default2',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM employment);

/*
Prediction Result:
('default2',)
('default1',)
('default2',)
('default1',)
(None,)
(None,)
('default2',)
('default2',)
*/