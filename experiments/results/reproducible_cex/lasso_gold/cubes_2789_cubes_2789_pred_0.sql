-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1054, 'Jennifer Jones', 1055.5, 1056.5, 'white');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1062, 'Charles Mcgee', 1063.5, 1064.5, 'nothing');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1057, 1054, 'Walter, Edwards and Rios', 1060.5, 'Simon Woodroffe');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1058, 1054, 'Wilkerson-Day', 1069.5, 'Peter Jones');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1065, 1062, 'Burgess-Patterson', 1068.5, 'Simon Woodroffe');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1066, 1062, 'Ross, Robinson and Bright', 1077.5, 'Peter Jones');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_birth" FROM (SELECT "LHS"."entrepreneur_id" AS "entrepreneur_id", "LHS"."people_id" AS "people_id", "LHS"."company" AS "company", "LHS"."money_requested" AS "money_requested", "LHS"."investor" AS "investor", "LHS"."name" AS "name", "LHS"."height" AS "height", "LHS"."weight" AS "weight", "LHS"."date_of_birth" AS "date_of_birth" FROM (SELECT "LHS"."entrepreneur_id" AS "entrepreneur_id", "LHS"."people_id" AS "people_id", "LHS"."company" AS "company", "LHS"."money_requested" AS "money_requested", "LHS"."investor" AS "investor", "RHS"."name" AS "name", "RHS"."height" AS "height", "RHS"."weight" AS "weight", "RHS"."date_of_birth" AS "date_of_birth" FROM "entrepreneur" AS "LHS" INNER JOIN "people" AS "RHS" ON ("LHS"."people_id" = "RHS"."people_id")) AS "LHS" INNER JOIN (SELECT * FROM "entrepreneur" WHERE ("investor" = 'Simon Woodroffe' OR "investor" = 'Peter Jones')) AS RHS ON (LHS.entrepreneur_id = RHS.entrepreneur_id AND LHS.people_id = RHS.people_id AND LHS.company = RHS.company AND LHS.money_requested = RHS.money_requested AND LHS.investor = RHS.investor)) ORDER BY date_of_birth, "date_of_birth" NULLS LAST;

/*
Gold Result:
('nothing',)
('nothing',)
('white',)
('white',)
*/

-- Prediction Query
SELECT T2.Date_of_Birth FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID WHERE T1.Investor = 'Simon Woodroffe' OR T1.Investor = 'Peter Jones';

/*
Prediction Result:
('white',)
('white',)
('nothing',)
('nothing',)
*/