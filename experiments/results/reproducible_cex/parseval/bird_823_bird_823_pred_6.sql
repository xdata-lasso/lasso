-- Schema DDL
CREATE TABLE alignment (id INTEGER NOT NULL PRIMARY KEY, alignment TEXT DEFAULT NULL);

CREATE TABLE attribute (id INTEGER NOT NULL PRIMARY KEY, attribute_name TEXT DEFAULT NULL);

CREATE TABLE colour (id INTEGER NOT NULL PRIMARY KEY, colour TEXT DEFAULT NULL);

CREATE TABLE gender (id INTEGER NOT NULL PRIMARY KEY, gender TEXT DEFAULT NULL);

CREATE TABLE publisher (id INTEGER NOT NULL PRIMARY KEY, publisher_name TEXT DEFAULT NULL);

CREATE TABLE race (id INTEGER NOT NULL PRIMARY KEY, race TEXT DEFAULT NULL);

CREATE TABLE superhero (id INTEGER NOT NULL PRIMARY KEY, superhero_name TEXT DEFAULT NULL, full_name TEXT DEFAULT NULL, gender_id INTEGER DEFAULT NULL, eye_colour_id INTEGER DEFAULT NULL, hair_colour_id INTEGER DEFAULT NULL, skin_colour_id INTEGER DEFAULT NULL, race_id INTEGER DEFAULT NULL, publisher_id INTEGER DEFAULT NULL, alignment_id INTEGER DEFAULT NULL, height_cm INTEGER DEFAULT NULL, weight_kg INTEGER DEFAULT NULL, FOREIGN KEY (alignment_id) REFERENCES alignment (id), FOREIGN KEY (eye_colour_id) REFERENCES colour (id), FOREIGN KEY (gender_id) REFERENCES gender (id), FOREIGN KEY (hair_colour_id) REFERENCES colour (id), FOREIGN KEY (publisher_id) REFERENCES publisher (id), FOREIGN KEY (race_id) REFERENCES race (id), FOREIGN KEY (skin_colour_id) REFERENCES colour (id));

CREATE TABLE hero_attribute (hero_id INTEGER DEFAULT NULL, attribute_id INTEGER DEFAULT NULL, attribute_value INTEGER DEFAULT NULL, FOREIGN KEY (attribute_id) REFERENCES attribute (id), FOREIGN KEY (hero_id) REFERENCES superhero (id));

CREATE TABLE superpower (id INTEGER NOT NULL PRIMARY KEY, power_name TEXT DEFAULT NULL);

CREATE TABLE hero_power (hero_id INTEGER DEFAULT NULL, power_id INTEGER DEFAULT NULL, FOREIGN KEY (hero_id) REFERENCES superhero (id), FOREIGN KEY (power_id) REFERENCES superpower (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: colour --
INSERT INTO "colour" ("id", "colour") VALUES (-2147483648, '9n8');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 't1__8df170', 'ia2yp', 1, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -1670923962, 700293388);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 't1__8df170', 'dlttil', 4, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 429706943, 462974032);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 't1__8df170', '6klfa9', 1, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 't1__8df170', 'ecigce376n', 4, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1313172851, -761141909);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 't1__8df170', '4nrq', 1, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, 418417917, -1031969798);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 't1__8df170', 'p', 4, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 882961052, 743312762);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 't1__8df170', 'a11ry', 1, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, -525979501, 1898504886);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 't1__8df170', '72klex14ji7z', 4, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2081315180, 1909986641);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 't1__8df170', '3pyu78d99r', 1, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, -1362461264, -904834265);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 't1__8df170', 'qi2rkf9v', 1, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 556727997, 1178000634);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 't1__d7eb55', 'gd', 1, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -283454505, 233994589);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, NULL, '72fxa7ryfd', 1, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 564390026, -1259474148);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, NULL, 'h', 1, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1583472758, 1449284300);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, NULL, 't1afgog', 1, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -946046410, -902895762);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, NULL, 'q4301jh', 1, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -163600466, -1826414375);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483633, NULL, 'x7afu5w1of77', 1, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -1099855564, 87529806);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483632, NULL, 'mfg62g0v5q8q', 1, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -1488156735, -1858644047);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483631, NULL, '7cvtjpt', 1, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 453836040, 1467355421);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483630, NULL, '36c', 1, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1722106924, -2072838897);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'qcgsk9', '8c4p', 3, -2147483648, -2147483648, -2147483648, -2147483648, 2, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'ia2yp', 'uzhsrwbbp6lu', 5, -2147483648, -2147483648, -2147483648, -2147483648, 5, -2147483648, 1019800248, -1910425938);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'nprmdposii', '5u', 6, -2147483648, -2147483648, -2147483648, -2147483648, 6, -2147483648, 1861536320, 44952191);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, '0t5c4ecigc', 'e376nium52', 7, -2147483648, -2147483648, -2147483648, -2147483648, 7, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'rofqyp5s5b', 'p', 8, -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, 882961052, 743312762);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'a11ry', 'ytoo3o9hl7', 9, -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, 1178636309, -1390245819);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'qcgsk9', '8c4p', 10, -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, 1871297066, 809183447);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (1, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (2, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (4, 'p');

INSERT INTO "gender" ("id", "gender") VALUES (3, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (5, 't2__91912c');

INSERT INTO "gender" ("id", "gender") VALUES (6, 't2__91912c');

INSERT INTO "gender" ("id", "gender") VALUES (7, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (8, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (9, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (10, 'Female');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (3, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (4, 'ie5');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (2, NULL);

INSERT INTO "publisher" ("id", "publisher_name") VALUES (5, 't3__c32bc6');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (6, NULL);

INSERT INTO "publisher" ("id", "publisher_name") VALUES (7, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (8, 't3__c32bc6');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (9, NULL);

INSERT INTO "publisher" ("id", "publisher_name") VALUES (10, 'Marvel Comics');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'pgu7vfe4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.publisher_name = 'Marvel Comics' AND T3.gender = 'Female';

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT COUNT(T1.superhero_name) FROM superhero AS T1 JOIN gender AS T2 ON T1.gender_id = T2.id JOIN publisher AS T3 ON T1.publisher_id = T3.id WHERE T2.gender = 'Female' AND T3.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(4,)
*/