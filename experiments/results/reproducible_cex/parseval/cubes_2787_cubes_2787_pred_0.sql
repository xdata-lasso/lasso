-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483648, 'hria2ypu', 882.963176, 841.297061, 'rwbbp');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (2, 'luhvdltti', 182.319045, 998.421621, 'prmd');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (3, 'posiie5unw6k', 768.216462, 83.204633, '9');

-- Inserting into table: entrepreneur --
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1, 1, 'lhs_0ad83c', 1.0, 'lhs_b81bb5');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483648, 1, 'lhs_719656', 1.0, 'lhs_0d7463');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483646, 3, 'q_2_fcac91', 627.258639, '0t5c4ecigc');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483645, 1, 'q_2_fcac91', 467.07027, 'nium52zbu');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (4, 2, '4nrq', 597.420508, 'fqyp');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (5, 3, 's5bbp02e', 325.080047, 'iqa');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM entrepreneur AS LHS WHERE EXISTS(SELECT 1 FROM people AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY company) LIMIT 1);

/*
Gold Result:
('4nrq',)
*/

-- Prediction Query
SELECT T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Height DESC, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_2_fcac91',)
*/