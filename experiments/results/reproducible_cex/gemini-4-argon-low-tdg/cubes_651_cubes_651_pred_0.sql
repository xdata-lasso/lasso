-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests HAVING/WHERE boundary conditions (counts of 0, 1, 2, 3, 4), ORDER BY count and name tie-breaking, and Official/Unofficial language distinction.
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES
('C00', 'ZeroLang', 'Asia', 'East', 100.0, 1990, 1000, 70.0, 100.0, 90.0, 'Zero', 'Republic', 'Head0', 1, 'Z0'),
('C01', 'OneLang', 'Asia', 'East', 100.0, 1990, 1000, 70.0, 100.0, 90.0, 'One', 'Republic', 'Head1', 2, 'O1'),
('C02', 'TwoLang', 'Europe', 'West', 200.0, 1980, 2000, 75.0, 200.0, 180.0, 'Two', 'Monarchy', 'Head2', 3, 'T2'),
('C03', 'ZetaThree', 'Africa', 'North', 300.0, 1970, 3000, 65.0, 300.0, 270.0, 'Zeta', 'Republic', 'Head3', 4, 'Z3'),
('C04', 'AlphaThree', 'Africa', 'South', 400.0, 1960, 4000, 60.0, 400.0, 360.0, 'Alpha', 'Republic', 'Head4', 5, 'A3'),
('C05', 'BetaFour', 'Oceania', 'Pacific', 500.0, 1950, 5000, 80.0, 500.0, 450.0, 'Beta', 'Federation', 'Head5', 6, 'B4');
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES
('C01', 'L1', 'T', 100.0),
('C02', 'L1', 'T', 60.0),
('C02', 'L2', 'F', 40.0),
('C03', 'L1', 'T', 50.0),
('C03', 'L2', 'F', 30.0),
('C03', 'L3', 'F', 20.0),
('C04', 'L1', 'F', 40.0),
('C04', 'L2', 'F', 40.0),
('C04', 'L3', 'F', 20.0),
('C05', 'L1', 'T', 25.0),
('C05', 'L2', 'T', 25.0),
('C05', 'L3', 'T', 25.0),
('C05', 'L4', 'F', 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_t2_language_, name FROM (SELECT name, COUNT(DISTINCT LANGUAGE) AS n_distinct FROM (SELECT countrycode, LANGUAGE, isofficial, percentage, name, continent, region, surfacearea, indepyear, population, lifeexpectancy, gnp, gnpold, localname, governmentform, headofstate, capital, code2, countrycode AS code FROM (SELECT LHS.countrycode AS countrycode, LHS.language AS LANGUAGE, LHS.isofficial AS isofficial, LHS.percentage AS percentage, RHS.name AS name, RHS.continent AS continent, RHS.region AS region, RHS.surfacearea AS surfacearea, RHS.indepyear AS indepyear, RHS.population AS population, RHS.lifeexpectancy AS lifeexpectancy, RHS.gnp AS gnp, RHS.gnpold AS gnpold, RHS.localname AS localname, RHS.governmentform AS governmentform, RHS.headofstate AS headofstate, RHS.capital AS capital, RHS.code2 AS code2 FROM countrylanguage AS LHS INNER JOIN country AS RHS ON (LHS.countrycode = RHS.code))) GROUP BY name) WHERE (n_distinct > 2) ORDER BY count_t2_language_, name NULLS LAST;

/*
Gold Result:
(3, 'AlphaThree')
(3, 'ZetaThree')
(4, 'BetaFour')
*/

-- Prediction Query
SELECT COUNT(T2.Language), T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode GROUP BY T1.Name HAVING COUNT(*) > 2;

/*
Prediction Result:
(3, 'AlphaThree')
(4, 'BetaFour')
(3, 'ZetaThree')
*/