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
INSERT INTO "colour" ("id", "colour") VALUES (1, 't2__ac9c82');

INSERT INTO "colour" ("id", "colour") VALUES (4, 't2__ac9c82');

INSERT INTO "colour" ("id", "colour") VALUES (6, '4');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'e376nium52');

INSERT INTO "colour" ("id", "colour") VALUES (2, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483643, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (5, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483641, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (7, 'ypuzhsrw');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483639, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (8, 'w6kl');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483637, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (9, 'u');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483635, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (10, 'tliqa1');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483633, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (11, 'au2dwyrq13');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'uzhsrwbbp6lu', 'hvdlttilbnpr', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 2087640001, 907682809);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'qrofqyp5s5b', 'p', -2147483648, 6, 3, 1, -2147483648, -2147483648, -2147483648, 882961052, 743312762);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, '1', 'ryytoo3', -2147483648, 6, 4, 1, -2147483648, -2147483648, -2147483648, -1666765085, 1178636309);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'au2dwy', 'q13py', -2147483648, 6, 3, 3, -2147483648, -2147483648, -2147483648, 244829661, -1362461264);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, '9fjgq8n2f', 'dqv0gcb9', -2147483648, 6, 3, 1, -2147483648, -2147483648, -2147483648, 172461907, 1606439408);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'a7ryfd', 'z16ni', -2147483648, 6, 1, 1, -2147483648, -2147483648, -2147483648, 2011234363, -1483100200);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'xp1q430', 'jh3den8', -2147483648, 6, 4, 1, -2147483648, -2147483648, -2147483648, 195720193, 1774087382);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'gu7v', 'e4', -2147483648, 2, 2, 2, -2147483648, -2147483648, -2147483648, 1160656988, -992890117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'gu7v', 'e4', -2147483648, 2, 5, 5, -2147483648, -2147483648, -2147483648, 1160656988, -992890117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'hvdlttilbnpr', 'dpos', -2147483648, 1, 7, 7, -2147483648, -2147483648, -2147483648, -1576219117, -1823627488);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, '5c4ec', 'gce', -2147483648, 1, 8, 8, -2147483648, -2147483648, -2147483648, -1585009206, -53231346);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'rofqyp5s5b', 'p', -2147483648, -2147483641, -2147483639, 9, -2147483648, -2147483648, -2147483648, 882961052, 743312762);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'oo3o9hl72kl', 'x1', -2147483648, 2, 10, 10, -2147483648, -2147483648, -2147483648, -74849714, 105869088);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, 'jsl', 'b4yp5qi', -2147483648, 9, 11, 11, -2147483648, -2147483648, -2147483648, -227162283, 2056419640);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: attribute --
INSERT INTO "attribute" ("id", "attribute_name") VALUES (-2147483648, 'nw6klf');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '9n8c4pgu7v');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, '4h');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'ia2yp');

-- Inserting into table: hero_attribute --
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (4, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (4, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (4, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (5, -2147483648, NULL);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (6, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (7, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (8, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (9, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (10, -2147483648, 100);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (11, -2147483648, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id WHERE T3.attribute_value = 100;

/*
Gold Result:
('t2__ac9c82',)
('e376nium52',)
('5k5swwqcgs',)
('ypuzhsrw',)
('w6kl',)
('u',)
('tliqa1',)
('au2dwyrq13',)
*/

-- Prediction Query
SELECT T3.colour FROM hero_attribute AS T1 JOIN superhero AS T2 ON T1.hero_id = T2.id JOIN colour AS T3 ON T2.skin_colour_id = T3.id WHERE T1.attribute_value = 100;

/*
Prediction Result:
('t2__ac9c82',)
('t2__ac9c82',)
('e376nium52',)
('t2__ac9c82',)
('e376nium52',)
('t2__ac9c82',)
('e376nium52',)
('t2__ac9c82',)
('t2__ac9c82',)
('t2__ac9c82',)
('t2__ac9c82',)
('t2__ac9c82',)
('t2__ac9c82',)
('t2__ac9c82',)
('t2__ac9c82',)
('t2__ac9c82',)
('t2__ac9c82',)
('5k5swwqcgs',)
('ypuzhsrw',)
('w6kl',)
('u',)
('tliqa1',)
('au2dwyrq13',)
*/