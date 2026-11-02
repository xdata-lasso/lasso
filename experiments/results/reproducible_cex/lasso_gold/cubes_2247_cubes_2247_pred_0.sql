-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1027, 'Millerport', 'husband', 'they', 1031, 1035.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1028, 'Barbaraland', 'fall', 'his', 1042.0, 1048.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1029, 'Lake Jeremyport', 'long', 'commercial', 1053.0, 1061.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1030, 'Port Jesseville', 'prove', 'hospital', 1064.0, 1074.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1047, 'Lake Mark', 'individual', 'low', 1051, 1055.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1048, 'East Lydiamouth', 'usually', 'character', 1062.0, 1068.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1049, 'Adamsborough', 'who', 'evidence', 1073.0, 1081.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1050, 'Jasonfort', 'question', 'chair', 1084.0, 1094.5);
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1039, 'hear', 'science', 'away', 'shoulder', 'hundred');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1040, 'determine', 'write', 'politics', 'election', 'expect');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1041, 'religious', 'result', 'Congress', 'common', 'wish');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1042, 'example', 'raise', 'none', 'maintain', 'push');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1059, 'employee', 'everyone', 'water', 'discuss', 'benefit');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1060, 'size', 'skin', 'past', 'certainly', 'someone');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1061, 'option', 'pattern', 'inside', 'Mr', 'anyone');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1062, 'nothing', 'later', 'high', 'minute', 'traditional');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (2059, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (2039, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (2029, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (2019, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1949, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1939, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1929, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (1043, 2059.0, 1027);
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (1044, 2039.0, 1027);
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (1045, 2029.0, 1027);
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (1046, 2019.0, 1027);
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (1063, 2059.0, 1047);
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (1064, 1949.0, 1047);
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (1065, 1939.0, 1047);
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (1066, 1929.0, 1047);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT host_city FROM (SELECT * FROM (SELECT * FROM hosting_city ORDER BY match_id DESC, hosting_city.year NULLS LAST) LIMIT 1);

/*
Gold Result:
('1027',)
*/

-- Prediction Query
SELECT host_city FROM hosting_city ORDER BY YEAR DESC LIMIT 1;

/*
Prediction Result:
('1047',)
*/