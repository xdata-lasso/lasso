-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('1', 'Central High', 'Indianapolis', 'Tigers', 1200, '4A', '4A', 'Marion');
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('2', 'Northview', 'Brazil', 'Knights', 850, '3A', '3A', 'Clay');
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('3', 'Southport', 'Indianapolis', 'Cardinals', 2100, '4A', '6A', 'Marion');
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('4', 'Westfield', 'Westfield', 'Shamrocks', 1800, '4A', '5A', 'Hamilton');
INSERT INTO School (School_id, School_name, Location, Mascot, Enrollment, IHSAA_Class, IHSAA_Football_Class, County) VALUES ('5', 'Eastbrook', 'Marion', 'Panthers', 600, '2A', '2A', 'Grant');
INSERT INTO budget (School_id, Year, Budgeted, total_budget_percent_budgeted, Invested, total_budget_percent_invested, Budget_invested_percent) VALUES (1, 2020, 50000, 25.0, 40000, 20.0, '80.0');
INSERT INTO budget (School_id, Year, Budgeted, total_budget_percent_budgeted, Invested, total_budget_percent_invested, Budget_invested_percent) VALUES (1, 2021, 60000, 30.0, 45000, 22.5, '75.0');
INSERT INTO budget (School_id, Year, Budgeted, total_budget_percent_budgeted, Invested, total_budget_percent_invested, Budget_invested_percent) VALUES (2, 2020, 30000, 15.0, 35000, 17.5, '116.7');
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (1, 1, 'Bob', 20.0);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (2, 3, 'Dave', 30.0);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (3, 2, 'Alice', 40.0);
INSERT INTO endowment (endowment_id, School_id, donator_name, amount) VALUES (4, 4, 'Carol', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT donator_name FROM endowment ORDER BY donator_name, endowment.endowment_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Carol',)
('Dave',)
*/

-- Prediction Query
SELECT DISTINCT donator_name FROM endowment;

/*
Prediction Result:
('Bob',)
('Dave',)
('Alice',)
('Carol',)
*/