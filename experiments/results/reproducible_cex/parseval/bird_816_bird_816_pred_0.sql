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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 't1__57dcd9', 'ypuzhsrw', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1908028688, 2122220075);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 't1__57dcd9', 'w6kl', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'zbuo4nrq', 'rofqyp5s5b', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2107872094, 882961052);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'g', 'k9n8c', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -106629402, 1871297066);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, NULL, 'g', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -890215420, 1610062532);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: attribute --
INSERT INTO "attribute" ("id", "attribute_name") VALUES (-2147483648, 'p6luhvdlttil');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');

-- Inserting into table: hero_attribute --
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 75);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 75);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 76);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2, -2147483648, 75);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2, -2147483648, 75);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2, -2147483648, 75);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 75);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 76);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 75);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 76);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 75);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 76);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 81);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 75);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (4, -2147483648, NULL);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (5, -2147483648, 75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id WHERE T2.attribute_value BETWEEN 75 AND 80;

/*
Gold Result:
('t1__57dcd9',)
('t1__57dcd9',)
('t1__57dcd9',)
('zbuo4nrq',)
('zbuo4nrq',)
('zbuo4nrq',)
('t1__57dcd9',)
('t1__57dcd9',)
('t1__57dcd9',)
('t1__57dcd9',)
('t1__57dcd9',)
('t1__57dcd9',)
('t1__57dcd9',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT T2.superhero_name FROM hero_attribute AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id WHERE T1.attribute_value BETWEEN 75 AND 80;

/*
Prediction Result:
('t1__57dcd9',)
('zbuo4nrq',)
(None,)
*/