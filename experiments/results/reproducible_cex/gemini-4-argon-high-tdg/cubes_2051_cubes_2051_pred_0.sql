-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('1', 'Central High', 'Indianapolis', 'Tigers', 1200, '4A', '4A', 'Marion');
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('2', 'Northside Prep', 'Carmel', 'Eagles', 850, '3A', '3A', 'Hamilton');
INSERT INTO budget (School_id, Year, Budgeted, total_budget_percent_budgeted, Invested, total_budget_percent_invested, Budget_invested_percent) VALUES (1, 2022, 50000, 50.0, 25000, 50.0, '50%');
INSERT INTO budget (School_id, Year, Budgeted, total_budget_percent_budgeted, Invested, total_budget_percent_invested, Budget_invested_percent) VALUES (2, 2022, 60000, 60.0, 30000, 50.0, '50%');
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (1, 1, 'Charlie', 15.5);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (2, 1, 'Alice', 20.0);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (3, 2, 'Bob', 9.0);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (4, 2, 'Alice', 9.01);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (5, 1, 'David', 8.99);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (6, 2, 'Eve', -12.0);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (7, 1, 'Frank', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name FROM endowment WHERE (amount >= 9.0) ORDER BY donator_name, endowment.endowment_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT donator_name FROM endowment EXCEPT SELECT donator_name FROM endowment WHERE amount < 9;

/*
Prediction Result:
('Alice',)
('Bob',)
('Charlie',)
('Frank',)
*/