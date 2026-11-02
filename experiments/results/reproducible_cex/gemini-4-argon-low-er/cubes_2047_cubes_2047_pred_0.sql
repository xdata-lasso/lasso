-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('1', 'B High School', 'Loc1', 'Mascot1', 100, 'A', 'A', 'County1');
INSERT INTO "School" ("School_id", "School_name", "Location", "Mascot", "Enrollment", "IHSAA_Class", "IHSAA_Football_Class", "County") VALUES ('2', 'A High School', 'Loc2', 'Mascot2', 200, 'B', 'B', 'County2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name, LOCATION, mascot FROM school ORDER BY school_name, school.school_id NULLS LAST;

/*
Gold Result:
('A High School', 'Loc2', 'Mascot2')
('B High School', 'Loc1', 'Mascot1')
*/

-- Prediction Query
SELECT school_name, LOCATION, mascot FROM school;

/*
Prediction Result:
('B High School', 'Loc1', 'Mascot1')
('A High School', 'Loc2', 'Mascot2')
*/