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

INSERT INTO "colour" ("id", "colour") VALUES (3, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (4, 'posiie5unw6k');

INSERT INTO "colour" ("id", "colour") VALUES (2, 't3__c3f72f');

INSERT INTO "colour" ("id", "colour") VALUES (5, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (6, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (7, 't3__c3f72f');

INSERT INTO "colour" ("id", "colour") VALUES (8, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (9, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (10, 't3__c3f72f');

INSERT INTO "colour" ("id", "colour") VALUES (11, NULL);

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'ia2yp', 'uzhsrwbbp6lu', -2147483648, 1, 1, 1, -2147483648, 1, -2147483648, 1019800248, -1910425938);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'yp5s5', 'bbp02eutliqa', -2147483648, 1, 1, 4, -2147483648, 1, -2147483648, -314162272, 2137741668);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, '72klex14ji7z', 'au2dwy', -2147483648, 1, 1, 1, -2147483648, 1, -2147483648, -953437896, -1097120355);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'yp5qi2rk', '9v', -2147483648, 1, 1, 1, -2147483648, 1, -2147483648, 556727997, 1178000634);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'vy9uxj4', 'wb', -2147483648, 1, 1, 3, -2147483648, 1, -2147483648, -1929953647, 1581736075);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, '5hncpr', 'tu0', -2147483648, 1, 3, 4, -2147483648, 1, -2147483648, -1898531797, -1748371085);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'qv0gcb98ozk', 'zbilyrkn', -2147483648, 1, 4, 4, -2147483648, 1, -2147483648, -688098735, 1784916884);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, '7xb72', 'xa', -2147483648, 1, 3, 1, -2147483648, 1, -2147483648, 1294666887, -515895469);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'i', 'dh5ogrgj', -2147483648, 1, 1, 1, -2147483648, 1, -2147483648, -458359144, 600440952);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'itsj3', 'y', -2147483648, 1, 1, 1, -2147483648, 1, -2147483648, -598313376, 1972233925);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 'jh3den8c68', '8vacx7', -2147483648, 1, 3, 3, -2147483648, 1, -2147483648, 1523825314, 2078438287);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'f77pzo72ctd', 't', -2147483648, 1, 3, 1, -2147483648, 1, -2147483648, -1284905200, 7929158);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'qcgsk9', '8c4p', -2147483648, 2, 2, 4, -2147483648, 3, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'ia2yp', 'uzhsrwbbp6lu', -2147483648, 5, 1, 1, -2147483648, 5, -2147483648, 1019800248, -1910425938);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'nprmdposii', '5u', -2147483648, 6, 3, 1, -2147483648, 6, -2147483648, 1861536320, 44952191);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, '000t5c4ec', 'gce', -2147483648, 7, 6, 5, -2147483648, 7, -2147483648, -1585009206, -53231346);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'rqro', 'fqyp5s5bbp0', -2147483648, 8, 6, 8, -2147483648, 8, -2147483648, 743312762, -1822992503);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, '1ryytoo', 'o9hl72kl', -2147483648, 9, 4, 1, -2147483648, 9, -2147483648, -305670381, -1525670226);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, '2dwyrq13pyu7', 'd99rljsl0', -2147483648, 10, 10, 6, -2147483648, 10, -2147483648, -2031361952, 1649269347);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'kf9vq', 'x58pz0f8je', -2147483648, 11, 5, 8, -2147483648, 11, -2147483648, 1196308825, 910894705);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '9n8');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (2, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (4, 'bnp');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (3, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (5, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (6, 't2__9f855a');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (7, 't2__9f855a');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (8, 't2__9f855a');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (9, NULL);

INSERT INTO "publisher" ("id", "publisher_name") VALUES (10, NULL);

INSERT INTO "publisher" ("id", "publisher_name") VALUES (11, NULL);

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'pgu7vfe4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN colour AS T3 ON T1.eye_colour_id = T3.id WHERE T2.publisher_name = 'Marvel Comics' AND T3.colour = 'Blue';

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT T3.colour, COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN colour AS T3 ON T1.eye_colour_id = T3.id WHERE T2.publisher_name = 'Marvel Comics' GROUP BY T3.colour ORDER BY COUNT(T1.id) DESC, T3.colour NULLS LAST;

/*
Prediction Result:
('Blue', 12)
('t3__c3f72f', 1)
(None, 1)
*/