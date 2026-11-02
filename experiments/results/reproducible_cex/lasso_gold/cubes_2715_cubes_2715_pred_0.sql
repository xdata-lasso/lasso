-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "grade", "school", "location", "type") VALUES (1011, 'traditional', 'yes', '845 Kelly Estate
Smithview, NY 23917', 'movement');
INSERT INTO "school" ("school_id", "grade", "school", "location", "type") VALUES (1012, 'while', 'unit', '893 Nathaniel Estates Apt. 957
North Sarahport, IA 08093', 'our');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school, TYPE FROM (SELECT * FROM school AS LHS WHERE NOT EXISTS(SELECT 1 FROM school_bus AS RHS WHERE (LHS.school_id = RHS.school_id))) ORDER BY school, TYPE NULLS LAST;

/*
Gold Result:
('unit', 'our')
('yes', 'movement')
*/

-- Prediction Query
SELECT school, TYPE FROM school WHERE NOT school_id IN (SELECT school_id FROM school_bus);

/*
Prediction Result:
('yes', 'movement')
('unit', 'our')
*/