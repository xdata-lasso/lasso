-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: church --
INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (1, 'chu_756ae5', 'chu_13cbce', 1, 'chu_ea4b8f');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483647, 'chu_bc3acd', 'chu_d80c94', 1, 'chu_d1f81e');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483646, 'q_1_53b030', '5k5swwqcgs', 1, '9n8');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483645, 'q_1_53b030', '4', 1, 'gu7v');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483644, 'q_1_53b030', 'e4', 1, 'hria2ypuzhs');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (3, 'rwbbp6luhvd', 'tti', -1364429300, 'nprmdposii');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483648, '5u', 'w6kl', 1620389964, '00t5c4ecigc');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (2, 'e376nium52', 'zbuo4nrqrof', 373262291, 'p5s5bbp');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483640, 'q_1_53b030', '02eutliqa11r', 1, 'ytoo3o9');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483639, 'q_1_53b030', 'l7', 1, 'klex14ji');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483638, 'q_1_53b030', '7zwau2dwyr', 1, '13pyu');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (4, '8d99rljsl', 'b4yp5qi', -227162283, 'f9v');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483650, 'x58pz', 'f8jegd2', 1675430660, 'y9uxj4');

INSERT INTO "church" ("church_id", "name", "organized_by", "open_date", "continuation_of") VALUES (-2147483649, 'wb', 'v', 1581736075, 'gndqwnqc');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_date FROM (SELECT * FROM (SELECT * FROM church ORDER BY church_id DESC) LIMIT 3);

/*
Gold Result:
('8d99rljsl', -227162283)
('rwbbp6luhvd', -1364429300)
('e376nium52', 373262291)
*/

-- Prediction Query
SELECT name, open_date FROM church ORDER BY open_date DESC, church.church_id NULLS LAST LIMIT 3;

/*
Prediction Result:
('x58pz', 1675430660)
('5u', 1620389964)
('wb', 1581736075)
*/