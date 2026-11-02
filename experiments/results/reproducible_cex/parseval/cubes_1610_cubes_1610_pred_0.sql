-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (1, '5k5swwqcgs', '9n8', '4', -734455130);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483647, 'nprmdposii', '5u', 'w6kl', 1620389964);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483646, '5c4ec', 'gce', '76nium52', -443340271);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483645, 'nrqrofqy', '5s5b', 'p', 882961052);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483644, 'tliqa1', 'ryytoo3', '9hl7', 1178636309);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483643, '4ji7zwa', '2dwyrq', '3pyu78d', -977635379);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483642, 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', -283454505);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483641, 'j4hwbdvlph', 'gndqwnqc', 'x5hncprjtu0', -1898531797);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483640, '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', -688098735);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483639, 'h', 'f8jswwl', '7xb72', 1350414441);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483638, '7ryfdrz16n', 'jja', '5dh', 1583472758);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483637, 'jd', 'yzt1afgog', 'itsj3', -491938169);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483636, 'jh3den8', 'c68x8vacx7', 'f', -47052816);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483635, 'f77pzo72ctd', 't', 'mfg62g0v5q8q', -1488156735);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483634, '2278', '07cvtjpt', 'tg6bnou5zi', 1944978593);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483633, 'kf', 'oacd07z2zez', 'o7w', -542502665);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483632, 'xcmr0', 'ztdg', '5i3', -1405314653);

INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483631, 'pim5', '58q', 's27p2r94gth2', 1162591638);

-- Inserting into table: church --
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1, 'hria2ypu', 'hsrwbbp', 13244799, 'hvdltt');

-- Inserting into table: wedding --
INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, 1, 1, -1610064545);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483647, 1, 546571701);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483646, 1, 757448742);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483645, 1, 743312762);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483644, 1, -1390245819);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483643, 1, 1661181156);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483642, 1, 233994589);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483641, 1, -1748371085);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483640, 1, 1784916884);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483639, 1, 2094425101);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483638, 1, 1449284300);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483637, 1, -106471771);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483636, 1, 645287482);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483635, 1, -1858644047);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483634, 1, 1722106924);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483633, 1, 1999335832);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483632, 1, 1816660482);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (1, -2147483631, 1, -2136247961);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT female_id AS count__distinct_church_id_ FROM (SELECT church_id, female_id, COUNT(DISTINCT church_id) AS n_distinct FROM wedding GROUP BY church_id, female_id) WHERE (church_id <> 2016 AND n_distinct = church_id) ORDER BY count__distinct_church_id_;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT church_id) FROM wedding WHERE YEAR = 2016;

/*
Prediction Result:
(0,)
*/