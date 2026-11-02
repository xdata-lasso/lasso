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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'Hawkman', 'e4', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1160656988, -992890117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'Hawkman', 'sr', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2, -2147483648, 906324270, 1908028688);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'Hawkman', 'l', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -845863578, -1610064545);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'Hawkman', '5u', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, 1861536320, 44952191);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'Hawkman', '5c4ec', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, -1683203397, 528680845);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'Hawkman', 'zbuo4nrq', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, 418417917, -1031969798);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'Hawkman', '02eu', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -868774469, -1068298341);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'Hawkman', 'oo3o9hl72kl', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -305670381, -1525670226);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, NULL, 'kf9vq', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 537874887, -461695645);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'Hawkman', 'vy9uxj4', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -1612443122, -2050247126);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, NULL, 'u7vfe4hria2y', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 3, -2147483648, 1115440883, 1644814318);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, NULL, 'hvdlttilbnpr', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 5, -2147483648, 2087640001, 907682809);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, NULL, 'a9', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 6, -2147483648, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, NULL, '52zbuo4nrq', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 7, -2147483648, 418417917, -1031969798);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, NULL, 'liqa1', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, 2074205376, 274769912);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, NULL, 'x14ji7zwau2d', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, 1485335077, -511185946);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, NULL, 'b4yp5qi', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, -227162283, 2056419640);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, NULL, 'y9uxj4', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 11, -2147483648, -1612443122, -2050247126);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (12, NULL, 'x5hncprjtu0', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -1898531797, -1748371085);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1, 't2__39fe34');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (2, 't2__39fe34');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483647, 't2__39fe34');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (4, 'dpos');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (3, '5k5swwqcgs');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (5, 'sr');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (6, 'siie');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (7, '0t5c4ecigc');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (8, '5s5b');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (9, 'oo3o9');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (10, '13pyu');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (11, 'vqx58pz0f');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (12, 'lph2gn');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'u7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.publisher_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T1.superhero_name IN ('Hawkman', 'Karate Kid', 'Speedy');

/*
Gold Result:
('t2__39fe34',)
('t2__39fe34',)
('t2__39fe34',)
('dpos',)
('dpos',)
('dpos',)
('t2__39fe34',)
('t2__39fe34',)
('t2__39fe34',)
*/

-- Prediction Query
SELECT DISTINCT p.publisher_name FROM superhero AS s JOIN publisher AS p ON s.publisher_id = p.id WHERE s.superhero_name IN ('Hawkman', 'Karate Kid', 'Speedy');

/*
Prediction Result:
('t2__39fe34',)
('dpos',)
*/