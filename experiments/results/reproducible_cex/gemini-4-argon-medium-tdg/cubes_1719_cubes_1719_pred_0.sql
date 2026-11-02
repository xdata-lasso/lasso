-- Schema DDL
CREATE TABLE "Campuses" ("Id" INTEGER PRIMARY KEY, "Campus" TEXT, "Location" TEXT, "County" TEXT, "Year" INTEGER);

CREATE TABLE "csu_fees" ("Campus" INTEGER PRIMARY KEY, "Year" INTEGER, "CampusFee" INTEGER, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "degrees" ("Year" INTEGER, "Campus" INTEGER, "Degrees" INTEGER, PRIMARY KEY ("Year", "Campus"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "discipline_enrollments" ("Campus" INTEGER, "Discipline" INTEGER, "Year" INTEGER, "Undergraduate" INTEGER, "Graduate" INTEGER, PRIMARY KEY ("Campus", "Discipline"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "enrollments" ("Campus" INTEGER, "Year" INTEGER, "TotalEnrollment_AY" INTEGER, "FTE_AY" INTEGER, PRIMARY KEY ("Campus", "Year"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "faculty" ("Campus" INTEGER, "Year" INTEGER, "Faculty" REAL, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (1, 'San Francisco State University', 'San Francisco', 'San Francisco', 1995);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (2, 'San Francisco State University', 'San Francisco', 'San Francisco', 1996);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (3, 'San Francisco State University', 'San Francisco', 'San Francisco', 1997);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (4, 'San Jose State University', 'San Jose', 'Santa Clara', 1995);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (5, 'San Francisco State University', 'San Francisco', 'San Francisco', NULL);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (6, NULL, 'San Francisco', 'San Francisco', 1995);
INSERT INTO "csu_fees" ("Campus", "Year", "CampusFee") VALUES (1, 2000, 1500);
INSERT INTO "csu_fees" ("Campus", "Year", "CampusFee") VALUES (2, 1995, 1600);
INSERT INTO "csu_fees" ("Campus", "Year", "CampusFee") VALUES (3, 1995, 1700);
INSERT INTO "csu_fees" ("Campus", "Year", "CampusFee") VALUES (4, 1995, 1800);
INSERT INTO "csu_fees" ("Campus", "Year", "CampusFee") VALUES (5, 1995, 1900);
INSERT INTO "csu_fees" ("Campus", "Year", "CampusFee") VALUES (6, 1995, 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "campusfee" FROM (SELECT "LHS"."id" AS "id", "LHS"."campus" AS "campus", "LHS"."location" AS "location", "LHS"."county" AS "county", "LHS"."year" AS "year", "RHS"."year" AS "year_other", "RHS"."campusfee" AS "campusfee" FROM (SELECT * FROM "campuses" WHERE ("campus" = 'San Francisco State University' AND YEAR < 1996)) AS LHS INNER JOIN csu_fees AS RHS ON (LHS.id = RHS.campus)) ORDER BY campusfee, "campusfee" NULLS LAST;

/*
Gold Result:
(1500,)
*/

-- Prediction Query
SELECT campusfee FROM campuses AS T1 JOIN csu_fees AS T2 ON T1.id = t2.campus WHERE t1.campus = 'San Francisco State University' AND T2.year = 1996;

/*
Prediction Result:
*/