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
INSERT INTO "colour" ("id", "colour") VALUES (1, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483647, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (4, 'ci');

INSERT INTO "colour" ("id", "colour") VALUES (2, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (5, 't2__51b4ad');

INSERT INTO "colour" ("id", "colour") VALUES (6, 't2__51b4ad');

INSERT INTO "colour" ("id", "colour") VALUES (7, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (8, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (9, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (10, 'Blue');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, '4h', 'ia2yp', 1, 1, 1, 1, 1, -2147483648, -2147483648, -1670923962, 700293388);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'luhvdltti', 'bnp', 1, 1, 1, 1, 1, -2147483648, -2147483648, 1236688122, 2087640001);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'ie5', 'nw6klf', 1, 1, 1, -2147483647, 1, -2147483648, -2147483648, 1038707349, 1419861592);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'e376nium52', 'zbuo4nrqrof', 1, 3, 4, 1, 1, -2147483648, -2147483648, 373262291, -472966518);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'ryytoo3', '9hl7', 1, 3, 1, 4, 4, -2147483648, -2147483648, 1178636309, -1390245819);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'yrq13pyu78d9', 'rljsl0b4y', 4, 4, 1, 3, 1, -2147483648, -2147483648, -1116181514, 1255852738);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, '9v', 'x58pz', 1, 4, 4, -2147483647, 1, -2147483648, -2147483648, -1529584866, 1196308825);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, '9uxj4hw', 'd', 1, 4, 1, 3, 4, -2147483648, -2147483648, -736979194, 2103044118);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'q', 'nqcx5h', 4, 4, 1, -2147483647, 1, -2147483648, -2147483648, -1245312912, 1575412235);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'dz79fjg', '8n2f3', 1, -2147483647, 4, 3, 1, -2147483648, -2147483648, 806170397, 513454646);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, '9', 'ozk3zbily', 1, 4, 1, 1, 4, -2147483648, -2147483648, 638024588, -688098735);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, '8j', 'wwlq7', 4, 1, 1, 4, 1, -2147483648, -2147483648, 1255343543, -541746689);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'z16ni', 'jai', 1, 4, 1, 1, 1, -2147483648, -2147483648, 1746373317, 1360271423);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'jd', 'yzt1afgog', 1, -2147483647, 1, 3, 1, -2147483648, -2147483648, -946046410, -902895762);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, '6b', 'ou5z', 1, -2147483647, 1, 3, 1, -2147483648, -2147483648, 1691780814, 1944978593);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483633, 'oa', 'cd07z2zezjo7', 1, 1, 1, -2147483647, 1, -2147483648, -2147483648, 304189298, -542502665);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483632, 'm', '0oztd', 1, 4, 1, 3, 1, -2147483648, -2147483648, -1699185893, 875300074);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'c4pgu7vfe', 'hria2ypu', 3, 2, 2, 2, 2, -2147483648, -2147483648, 1644814318, 1465859724);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'l', 'tilbn', 5, 3, 5, 3, 5, -2147483648, -2147483648, 462974032, -1137908826);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, '000t5c4ec', 'gce', 6, 1, 6, 2, 6, -2147483648, -2147483648, -1585009206, -53231346);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, '5bbp0', '2eutliqa11r', 7, 6, 7, 7, 7, -2147483648, -2147483648, 2137741668, -525979501);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'i7z', 'au2dwy', 8, 5, 8, 7, 8, -2147483648, -2147483648, -953437896, -1097120355);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'b4yp5qi', 'rkf9vqx5', 9, 3, 9, 3, 9, -2147483648, -2147483648, 1836127587, -1529584866);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'c4pgu7vfe', 'hria2ypu', 10, 9, 10, 9, 10, -2147483648, -2147483648, 1644814318, 1465859724);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (1, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483647, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (2, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (4, 'ji7zwau2');

INSERT INTO "gender" ("id", "gender") VALUES (3, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (5, 't4__c31137');

INSERT INTO "gender" ("id", "gender") VALUES (6, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (7, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (8, 't4__c31137');

INSERT INTO "gender" ("id", "gender") VALUES (9, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (10, 'Male');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, '9n8c4pgu7v');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (1, 't3__4053aa');

INSERT INTO "race" ("id", "race") VALUES (-2147483647, 't3__4053aa');

INSERT INTO "race" ("id", "race") VALUES (3, 't3__4053aa');

INSERT INTO "race" ("id", "race") VALUES (4, 'bbp02eutliqa');

INSERT INTO "race" ("id", "race") VALUES (2, '5k5swwqcgs');

INSERT INTO "race" ("id", "race") VALUES (5, 'rwbbp');

INSERT INTO "race" ("id", "race") VALUES (6, 'siie5unw6k');

INSERT INTO "race" ("id", "race") VALUES (7, 'zbuo4nrqrof');

INSERT INTO "race" ("id", "race") VALUES (8, 'oo3o9hl72kl');

INSERT INTO "race" ("id", "race") VALUES (9, '78d99r');

INSERT INTO "race" ("id", "race") VALUES (10, '5k5swwqcgs');

INSERT INTO "race" ("id", "race") VALUES (-2147483637, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.hair_colour_id = T2.id INNER JOIN race AS T3 ON T1.race_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T2.colour = 'Blue' AND T4.gender = 'Male';

/*
Gold Result:
('t3__4053aa',)
('t3__4053aa',)
('t3__4053aa',)
('bbp02eutliqa',)
('bbp02eutliqa',)
('bbp02eutliqa',)
('t3__4053aa',)
('t3__4053aa',)
('t3__4053aa',)
('t3__4053aa',)
('t3__4053aa',)
('5k5swwqcgs',)
*/

-- Prediction Query
SELECT race.race FROM superhero JOIN gender ON superhero.gender_id = gender.id JOIN colour ON superhero.hair_colour_id = colour.id JOIN race ON superhero.race_id = race.id WHERE gender.gender = 'Male' AND colour.colour = 'blue';

/*
Prediction Result:
*/