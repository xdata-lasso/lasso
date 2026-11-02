-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("Code", "Name") VALUES ('C1', 'SameName');
INSERT INTO "country" ("Code", "Name") VALUES ('C2', 'SameName');
INSERT INTO "countrylanguage" ("CountryCode", "Language") VALUES ('C1', 'L1');
INSERT INTO "countrylanguage" ("CountryCode", "Language") VALUES ('C1', 'L2');
INSERT INTO "countrylanguage" ("CountryCode", "Language") VALUES ('C2', 'L1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_t2_language_, name FROM (SELECT name, COUNT(DISTINCT LANGUAGE) AS n_distinct FROM (SELECT countrycode, LANGUAGE, isofficial, percentage, name, continent, region, surfacearea, indepyear, population, lifeexpectancy, gnp, gnpold, localname, governmentform, headofstate, capital, code2, countrycode AS code FROM (SELECT LHS.countrycode AS countrycode, LHS.language AS LANGUAGE, LHS.isofficial AS isofficial, LHS.percentage AS percentage, RHS.name AS name, RHS.continent AS continent, RHS.region AS region, RHS.surfacearea AS surfacearea, RHS.indepyear AS indepyear, RHS.population AS population, RHS.lifeexpectancy AS lifeexpectancy, RHS.gnp AS gnp, RHS.gnpold AS gnpold, RHS.localname AS localname, RHS.governmentform AS governmentform, RHS.headofstate AS headofstate, RHS.capital AS capital, RHS.code2 AS code2 FROM countrylanguage AS LHS INNER JOIN country AS RHS ON (LHS.countrycode = RHS.code))) GROUP BY name) WHERE (n_distinct > 2) ORDER BY count_t2_language_, name NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(T2.Language), T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode GROUP BY T1.Name HAVING COUNT(*) > 2;

/*
Prediction Result:
(3, 'SameName')
*/