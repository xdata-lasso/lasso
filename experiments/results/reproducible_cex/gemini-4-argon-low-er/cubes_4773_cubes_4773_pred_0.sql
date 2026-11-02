-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (1, 'Beijing', '北京', 'Běijīng', 21000000, 3000.0);
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (2, 'Shanghai', '上海', 'Shànghǎi', 24000000, 3500.0);
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (1, '2020-01-01', 'Stadium A', '1-0', 'Win', 'Cup');
INSERT INTO "hosting_city" ("Year", "Match_ID", "Host_City") VALUES (2020, 1, '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT city FROM (SELECT LHS.city_id AS city_id, LHS.city AS city, LHS.hanzi AS hanzi, LHS.hanyu_pinyin AS hanyu_pinyin, LHS.regional_population AS regional_population, LHS.gdp AS gdp, RHS.host_city AS host_city, RHS.n AS n FROM city AS LHS INNER JOIN (SELECT host_city, n, MAX(n) OVER () AS maxn FROM (SELECT host_city, COUNT(*) AS n FROM hosting_city GROUP BY host_city)) AS RHS ON (LHS.city_id = RHS.maxn)) ORDER BY city;

/*
Gold Result:
('Beijing',)
*/

-- Prediction Query
SELECT T1.city FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id = T2.host_city GROUP BY T2.host_city ORDER BY COUNT(*) DESC, T1.city NULLS LAST LIMIT 1;

/*
Prediction Result:
('Shanghai',)
*/