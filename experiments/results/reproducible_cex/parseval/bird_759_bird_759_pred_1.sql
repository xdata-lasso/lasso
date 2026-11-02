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
INSERT INTO "colour" ("id", "colour") VALUES (1, 't2__8ba372');

INSERT INTO "colour" ("id", "colour") VALUES (2, 't2__8ba372');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483647, 't2__8ba372');

INSERT INTO "colour" ("id", "colour") VALUES (-1, 't2__8ba372');

INSERT INTO "colour" ("id", "colour") VALUES (4, '6nium52zb');

INSERT INTO "colour" ("id", "colour") VALUES (0, 't2__8ba372');

INSERT INTO "colour" ("id", "colour") VALUES (3, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483641, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (5, 'b');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483639, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (6, 'dposiie5unw');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483637, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (7, 'zbuo4nrqrof');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483635, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (8, '72klex14ji7z');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483633, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (9, '2rk');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483631, NULL);

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'wbbp6luhvdlt', 'ilbnp', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 1236688122, 2087640001);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'lfa', '9000t5c4ec', -2147483648, 1, 2, -2147483647, -2147483648, -2147483648, -2147483648, -1683203397, 528680845);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'qyp5s5bbp0', '2eutliqa11r', -2147483648, -1, 4, 1, -2147483648, -2147483648, -2147483648, 2137741668, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'x1', 'ji7zwau2', -2147483648, 0, 2, 2, -2147483648, -2147483648, -2147483648, 364869063, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'l0b4y', 'p5qi2rkf9v', -2147483648, 0, 4, 2, -2147483648, -2147483648, -2147483648, 556727997, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'vy9uxj4', 'wb', -2147483648, -1, 1, -1, -2147483648, -2147483648, -2147483648, -1929953647, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'x', '5hncprjtu0d', -2147483648, 1, -2147483647, -2147483647, -2147483648, -2147483648, -2147483648, 401805964, -1485777725);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, '7', 'yfdrz', -2147483648, 1, 1, -2147483647, -2147483648, -2147483648, -2147483648, 61479715, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'jd', 'yzt1afgog', -2147483648, 1, -1, -2147483647, -2147483648, -2147483648, -2147483648, -946046410, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, '1jh3den', 'c68x8vacx', -2147483648, 1, -1, -1, -2147483648, -2147483648, -2147483648, -1762140823, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'u7vfe4hria2y', 'uzhs', -2147483648, 3, 1, 2, -2147483648, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'tti', 'bnp', -2147483648, 5, 0, 1, -2147483648, -2147483648, -2147483648, 1236688122, 2087640001);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, '0t5c4ec', 'gce', -2147483648, 6, 2, 6, -2147483648, -2147483648, -2147483648, -1585009206, -53231346);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'bbp02eutliqa', '1ryytoo', -2147483648, 7, -1, -2147483641, -2147483648, -2147483648, -2147483648, 1644911394, -1666765085);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'yrq13pyu78d9', 'rljsl0b4y', -2147483648, 8, 6, -2147483637, -2147483648, -2147483648, -2147483648, -1116181514, 1255852738);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'pz0f8jegd21', 'y9uxj4', -2147483648, 9, 5, -2147483631, -2147483648, -2147483648, -2147483648, -1612443122, -2050247126);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '9n8');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'pgu7vfe4');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id ORDER BY T1.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__8ba372',)
*/

-- Prediction Query
SELECT colour.colour FROM superhero INNER JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.weight_kg = (SELECT MAX(weight_kg) FROM superhero);

/*
Prediction Result:
('t2__8ba372',)
('b',)
*/