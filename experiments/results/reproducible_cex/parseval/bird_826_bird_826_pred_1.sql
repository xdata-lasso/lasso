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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 't2__d8276c', 'e4', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1160656988, 1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 't2__d8276c', 'uzhsrwbbp6lu', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1019800248, 1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-1, 't2__d8276c', '5u', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 5, -2147483648, 1861536320, 1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (0, 't2__2f7ae3', '00t5c4ecigc', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 5, -2147483648, 528680845, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'qcx5', 'hncprjtu0dz', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2, -2147483648, -1748371085, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'cgsk9', '8c4p', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 3, -2147483648, 1871297066, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'ia2yp', 'uzhsrwbbp6lu', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, 1019800248, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'bnp', 'mdpos', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 6, -2147483648, -1576219117, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'fa9', '00t5c4e', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 7, -2147483648, 1274489983, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'um5', 'zbuo4nrq', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, 418417917, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, '5bbp0', '2eutliqa11r', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, 2137741668, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'hl72klex1', 'ji7zwau2', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, 364869063, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, '78d99r', 'jsl', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 11, -2147483648, -346339240, NULL);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1, 'DC Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483647, 'DC Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (0, 'DC Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (5, 'mdpos');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (-1, 'DC Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (2, 'hwbdvlph');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (3, 'DC Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (4, 'DC Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (6, 'DC Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (7, 'DC Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (8, 'DC Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (9, 'DC Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (10, 'DC Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (11, 'DC Comics');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'u7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'DC Comics' ORDER BY T1.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__d8276c',)
*/

-- Prediction Query
SELECT T2.superhero_name FROM publisher AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.publisher_id WHERE T1.publisher_name = 'DC Comics' AND NOT T2.weight_kg IS NULL ORDER BY T2.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('t2__d8276c',)
*/