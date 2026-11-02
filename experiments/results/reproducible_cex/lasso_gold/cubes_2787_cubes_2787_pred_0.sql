-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1028, 'Jamie Arnold', 1029.5, 1030.5, 'themselves');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1038, 'Roy Martin', 1039.5, 1040.5, 'hear');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1031, 1028, 'Montgomery, Hensley and Ray', 1032.5, 'sea');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1036, 1028, 'Delacruz Group', 1037.5, 'fall');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1041, 1038, 'Santiago Ltd', 1042.5, 'write');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM entrepreneur AS LHS WHERE EXISTS(SELECT 1 FROM people AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY company) LIMIT 1);

/*
Gold Result:
('Delacruz Group',)
*/

-- Prediction Query
SELECT T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Height DESC, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Santiago Ltd',)
*/