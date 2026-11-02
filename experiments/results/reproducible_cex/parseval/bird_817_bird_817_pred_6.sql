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

INSERT INTO "colour" ("id", "colour") VALUES (4, '6nium52zb');

INSERT INTO "colour" ("id", "colour") VALUES (2, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (5, 't2__b34668');

INSERT INTO "colour" ("id", "colour") VALUES (6, 't2__b34668');

INSERT INTO "colour" ("id", "colour") VALUES (7, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (8, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (9, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (10, 'Blue');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, '4h', 'ia2yp', 1, 1, 1, 1, 1, -2147483648, -2147483648, -1670923962, 700293388);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'luhvdltti', 'bnp', 1, 1, 1, 1, 2, -2147483648, -2147483648, 1236688122, 2087640001);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'a9', '00t5c4e', 1, 1, 1, 1, 3, -2147483648, -2147483648, 1274489983, -1683203397);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'nrqrofqy', '5s5b', 1, -2147483647, 4, -2147483647, 1, -2147483648, -2147483648, 2107872094, 882961052);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'yytoo', 'o9hl72kl', 1, 1, 1, 4, 4, -2147483648, -2147483648, -305670381, -1525670226);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, '78d99r', 'jsl', 4, 3, 1, 4, 1, -2147483648, -2147483648, -346339240, 1692174491);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'kf9vq', 'x58pz0f8je', 1, 3, 4, 4, 1, -2147483648, -2147483648, 1196308825, 910894705);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, '9uxj4hwbdvl', 'h2gn', 1, 4, 1, 4, 4, -2147483648, -2147483648, 1968874827, -664193365);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'hncprjtu0dz', '9fjgq8n2f', 4, 1, 1, 4, 1, -2147483648, -2147483648, -1056308489, -1454058168);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'yrkn6vck6ah0', '8j', 1, 1, 4, -2147483647, 1, -2147483648, -2147483648, -932772113, -639539893);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 'xa', '7ryfdrz16n', 1, 3, 1, 4, 4, -2147483648, -2147483648, -1496556994, -2115841792);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'grgj', '8', 4, 1, 1, 4, 1, -2147483648, -2147483648, -458359144, 600440952);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'ri', 'tsj3ayxp1q4', 1, 1, 1, -2147483647, 1, -2147483648, -2147483648, -1538707438, -163600466);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'vacx7afu5', '1of77p', 1, -2147483647, 1, 3, 1, -2147483648, -2147483648, -435350511, 1992637800);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, 'r0oz', 'dgj5i', 1, 3, 1, 1, 1, -2147483648, -2147483648, -176606723, -15162884);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483633, 'k58qs27p', 'r94gth2m', 1, -2147483647, 1, -2147483647, 1, -2147483648, -2147483648, 418247369, -1524425594);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483632, 'v8u', 'tmu2n', 1, 1, 1, -2147483647, 1, -2147483648, -2147483648, -1817527403, -1402164108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'c4pgu7vfe', 'hria2ypu', 3, 2, 2, 2, 5, -2147483648, -2147483648, 1644814318, 1465859724);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'l', 'tilbn', 5, 3, 5, 3, 6, -2147483648, -2147483648, 462974032, -1137908826);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, '000t5c4ec', 'gce', 6, 1, 6, 2, 7, -2147483648, -2147483648, -1585009206, -53231346);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, '5bbp0', '2eutliqa11r', 7, 6, 7, 7, 8, -2147483648, -2147483648, 2137741668, -525979501);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'i7z', 'au2dwy', 8, 5, 8, 7, 9, -2147483648, -2147483648, -953437896, -1097120355);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'b4yp5qi', 'rkf9vqx5', 9, 3, 9, 3, 10, -2147483648, -2147483648, 1836127587, -1529584866);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'c4pgu7vfe', 'hria2ypu', 10, 9, 10, 9, 11, -2147483648, -2147483648, 1644814318, 1465859724);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (1, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483647, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (2, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (4, 'au2dwyrq13');

INSERT INTO "gender" ("id", "gender") VALUES (3, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (5, 't4__8d3199');

INSERT INTO "gender" ("id", "gender") VALUES (6, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (7, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (8, 't4__8d3199');

INSERT INTO "gender" ("id", "gender") VALUES (9, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (10, 'Male');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, '9n8c4pgu7v');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (1, 't3__21ac8d');

INSERT INTO "race" ("id", "race") VALUES (2, 't3__21ac8d');

INSERT INTO "race" ("id", "race") VALUES (-2147483647, 't3__21ac8d');

INSERT INTO "race" ("id", "race") VALUES (3, 'siie5unw6k');

INSERT INTO "race" ("id", "race") VALUES (4, 'liqa1');

INSERT INTO "race" ("id", "race") VALUES (5, '5k5swwqcgs');

INSERT INTO "race" ("id", "race") VALUES (6, 'rwbbp');

INSERT INTO "race" ("id", "race") VALUES (7, 'siie5unw6k');

INSERT INTO "race" ("id", "race") VALUES (8, 'zbuo4nrqrof');

INSERT INTO "race" ("id", "race") VALUES (9, 'oo3o9hl72kl');

INSERT INTO "race" ("id", "race") VALUES (10, '78d99r');

INSERT INTO "race" ("id", "race") VALUES (-2147483637, NULL);

INSERT INTO "race" ("id", "race") VALUES (11, '5k5swwqcgs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.hair_colour_id = T2.id INNER JOIN race AS T3 ON T1.race_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T2.colour = 'Blue' AND T4.gender = 'Male';

/*
Gold Result:
('t3__21ac8d',)
('t3__21ac8d',)
('siie5unw6k',)
('liqa1',)
('liqa1',)
('liqa1',)
('t3__21ac8d',)
('t3__21ac8d',)
('t3__21ac8d',)
('t3__21ac8d',)
('t3__21ac8d',)
('5k5swwqcgs',)
*/

-- Prediction Query
SELECT DISTINCT r.race FROM superhero AS s JOIN gender AS g ON s.gender_id = g.id JOIN colour AS c ON s.hair_colour_id = c.id JOIN race AS r ON s.race_id = r.id WHERE g.gender = 'Male' AND c.colour = 'Blue';

/*
Prediction Result:
('t3__21ac8d',)
('siie5unw6k',)
('liqa1',)
('5k5swwqcgs',)
*/