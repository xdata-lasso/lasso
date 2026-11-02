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
INSERT INTO "colour" ("id", "colour") VALUES (2, 't2__867315');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'nw6klf');

INSERT INTO "colour" ("id", "colour") VALUES (4, 't2__867315');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'm52zbu');

INSERT INTO "colour" ("id", "colour") VALUES (1, 't2__867315');

INSERT INTO "colour" ("id", "colour") VALUES (5, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483642, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (7, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483640, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (8, 'p');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483638, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (9, 'unw6klfa');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483636, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (10, 'nrqrofqy');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483634, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (11, 'oo3o9hl72kl');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483632, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (12, 'l0b4y');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'uzhsrwbbp6lu', 'hvdlttilbnpr', -2147483648, 2, 2, 2, -2147483648, -2147483648, -2147483648, 2087640001, 907682809);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'bbp02eut', 'iqa', -2147483648, 4, 3, 2, -2147483648, -2147483648, -2147483648, -314162272, 2137741668);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'ji7zwau2', 'dwyrq13pyu78', -2147483648, 6, 3, 6, -2147483648, -2147483648, -2147483648, 244829661, -1362461264);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'gu7v', 'e4', -2147483648, 1, 1, 5, -2147483648, -2147483648, -2147483648, 1160656988, -992890117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'u7vfe4hria2y', 'uzhs', -2147483648, 6, 7, 7, -2147483648, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'tilbn', 'rmdp', -2147483648, 5, 5, 8, -2147483648, -2147483648, -2147483648, 2026480202, -1576219117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'c4ecigce', '76nium52', -2147483648, -2147483638, 8, 9, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, '02eu', 'liqa1', -2147483648, 7, 7, 10, -2147483648, -2147483648, -2147483648, 2074205376, 274769912);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, '7zwau2dwyr', '13pyu', -2147483648, 9, 11, 11, -2147483648, -2147483648, -2147483648, 176380444, -977635379);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'f9v', 'x58pz', -2147483648, 11, 1, 12, -2147483648, -2147483648, -2147483648, -1529584866, 1196308825);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: attribute --
INSERT INTO "attribute" ("id", "attribute_name") VALUES (-2147483648, 'a9000t5c4eci');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '9n8c4pgu7v');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, '4h');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'ia2yp');

-- Inserting into table: hero_attribute --
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (4, -2147483648, NULL);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (5, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (6, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (7, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (8, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (9, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (10, -2147483648, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id WHERE T3.attribute_value = 100;

/*
Gold Result:
('t2__867315',)
('m52zbu',)
('5k5swwqcgs',)
('p',)
('unw6klfa',)
('nrqrofqy',)
('oo3o9hl72kl',)
('l0b4y',)
*/

-- Prediction Query
SELECT colour.colour FROM colour INNER JOIN superhero ON colour.id = superhero.skin_colour_id INNER JOIN hero_attribute ON superhero.id = hero_attribute.hero_id WHERE hero_attribute.attribute_value = 100;

/*
Prediction Result:
('t2__867315',)
('t2__867315',)
('m52zbu',)
('t2__867315',)
('m52zbu',)
('t2__867315',)
('m52zbu',)
('t2__867315',)
('t2__867315',)
('t2__867315',)
('t2__867315',)
('t2__867315',)
('t2__867315',)
('t2__867315',)
('t2__867315',)
('t2__867315',)
('t2__867315',)
('5k5swwqcgs',)
('p',)
('unw6klfa',)
('nrqrofqy',)
('oo3o9hl72kl',)
('l0b4y',)
*/