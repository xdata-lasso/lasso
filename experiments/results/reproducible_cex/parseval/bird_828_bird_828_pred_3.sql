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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 't3__33ba10', 'ypuzhsrw', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1908028688, 2122220075);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (0, 'klfa9000t', 'c4ecigce', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1585009206, -53231346);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2437, '2eutliqa11r', 'ytoo3o9', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1666765085, 1178636309);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2438, '2rk', '9v', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 556727997, 1178000634);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-1, '01jh3den', 'c68x8vacx', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1762140823, 1371234901);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: attribute --
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1, 'Speed');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (2438, 'dpos');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (-1, 'j4hwbdvlph');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (2437, 'jswwlq7xb');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');

-- Inserting into table: hero_attribute --
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1072996612);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2438, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2437, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2438, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2438, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2438, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2438, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2437, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2437, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2437, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1992637800);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -820614248);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -698610044);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1021978385);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 199672698);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 2119806856);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1467355421);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1171104889);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1776877925);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1201273976);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -461418236);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -468701684);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -915385605);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -2005628382);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -20116244);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -176606723);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -55240145);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1379859112);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1719383707);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1273687251);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -2096405521);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1803796945);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1252009958);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1908593332);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1719800120);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1177989415);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -499913447);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.superhero_name) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id INNER JOIN superhero AS T3 ON T1.hero_id = T3.id WHERE T2.attribute_name = 'Speed' ORDER BY T1.attribute_value DESC, T1.hero_id NULLS LAST, T1.attribute_id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(52,)
*/

-- Prediction Query
SELECT COUNT(*) FROM attribute INNER JOIN hero_attribute ON attribute.id = hero_attribute.attribute_id INNER JOIN superhero ON hero_attribute.hero_id = superhero.id WHERE attribute.attribute_name = 'Speed' AND hero_attribute.attribute_value = 100;

/*
Prediction Result:
(0,)
*/