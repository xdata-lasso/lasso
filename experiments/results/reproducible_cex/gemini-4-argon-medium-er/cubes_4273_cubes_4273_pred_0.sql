-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (Company_ID, Name, Headquarters) VALUES (1, 'CompA', 'NY');
INSERT INTO company (Company_ID, Name, Headquarters) VALUES (2, 'CompB', 'LA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters FROM (SELECT LHS.n AS n, RHS.headquarters AS headquarters, RHS.n AS n_other FROM (SELECT MAX(n) AS n FROM (SELECT headquarters, COUNT(*) AS n FROM company GROUP BY headquarters)) AS LHS CROSS JOIN (SELECT headquarters, COUNT(*) AS n FROM company GROUP BY headquarters) AS RHS) WHERE (n <= n_other) ORDER BY headquarters;

/*
Gold Result:
('LA',)
('NY',)
*/

-- Prediction Query
SELECT Headquarters FROM company GROUP BY Headquarters ORDER BY COUNT(*) DESC, Headquarters NULLS LAST LIMIT 1;

/*
Prediction Result:
('LA',)
*/