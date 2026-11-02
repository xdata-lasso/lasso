-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "country", "is_male", "age") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', -734455130);

-- Inserting into table: church --
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483648, 'hria2ypu', 'hsrwbbp', 13244799, 'hvdltt');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483647, 'nprmdposii', '5u', 1861536320, '6klfa9');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483646, '5c4ec', 'gce', -1585009206, '52zb');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483645, 'rqro', 'fqyp5s5bbp0', 743312762, 'eutliqa11r');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483644, 'oo3o9hl72kl', 'x1', -74849714, '7zw');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483643, 'dwyrq13pyu78', '9', 244829661, 'jsl');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483642, 'p5qi2rk', '9v', 556727997, '8pz0f8je');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483641, 'vy9uxj4', 'wb', -1929953647, 'ph2');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483640, 'wnqcx', '5hncprjtu0d', 401805964, 'gq8');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483639, 'dqv0gcb9', 'ozk3zbily', 638024588, '6vck6ah0f8js');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483638, '7xb72', 'xa', 1294666887, 'fdrz16n');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483637, 'i', 'dh5ogrgj', -458359144, '1afgogritsj');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483636, 'p1q430', 'jh3den8', 195720193, 'vacx7afu5');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483635, 'f77pzo72ctd', 't', -1284905200, '62');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483634, 'q8qdjpe1', 'o22', 2004147439, 'tjpttg');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483633, 'u5zi', '6c4bfkfo', -1950324754, '7z2zezj');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483632, 'd5ysxc', 'r0oz', -870767087, 'j5');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483631, '5lnpi', '5k58', -1125548818, '94gth');

-- Inserting into table: wedding --
INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483648, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483647, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483646, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483645, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483644, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483643, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483642, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483641, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483640, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483639, -2147483648, -2147483648, NULL);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483638, -2147483648, -2147483648, NULL);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483637, -2147483648, -2147483648, NULL);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483636, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483635, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483634, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483633, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483632, -2147483648, -2147483648, 1);

INSERT INTO "wedding" ("church_id", "male_id", "female_id", "year") VALUES (-2147483631, -2147483648, -2147483648, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT YEAR, COUNT(*) AS n FROM wedding GROUP BY YEAR) WHERE (YEAR >= 2016 OR n > 2016) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM wedding WHERE YEAR = 2016;

/*
Prediction Result:
(0,)
*/