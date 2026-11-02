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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'e4', 't1__21c9ce', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1, 1160656988);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'uzhsrwbbp6lu', 't1__21c9ce', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1, 1019800248);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'bnp', 't1__21c9ce', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1, 1236688122);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'a9000t5c4eci', 't1__21c9ce', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, 1, 1149850321);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, '52zb', 't1__21c9ce', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, 1, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'fqyp', 't1__21c9ce', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, 1, -921187550);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, '13pyu', 't1__21c9ce', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1, 176380444);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, '4', 't1__21c9ce', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, NULL, 1649269347);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'f9v', NULL, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1, 556727997);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'cgsk9', '8c4p', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2, -2147483648, NULL, 1871297066);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'ia2yp', 'uzhsrwbbp6lu', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 5, -2147483648, NULL, 1019800248);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'bnp', 'mdpos', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 6, -2147483648, NULL, -1576219117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'fa9', '00t5c4e', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 7, -2147483648, NULL, 1274489983);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'um5', 'zbuo4nrq', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, NULL, 418417917);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, '5bbp0', '2eutliqa11r', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, NULL, 2137741668);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'hl72klex1', 'ji7zwau2', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, NULL, 364869063);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, '78d99r', 'jsl', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 11, -2147483648, NULL, -346339240);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (12, 'rkf9vqx5', 'pz0f8jegd', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, NULL, -283454505);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483647, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (3, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (4, 'siie5unw6k');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (2, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (5, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (6, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (7, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (8, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (9, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (10, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (11, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (12, 'Marvel Comics');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'u7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Marvel Comics' ORDER BY T1.height_cm DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__21c9ce',)
*/

-- Prediction Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Marvel Comics' AND NOT T1.height_cm IS NULL ORDER BY T1.height_cm DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__21c9ce',)
*/