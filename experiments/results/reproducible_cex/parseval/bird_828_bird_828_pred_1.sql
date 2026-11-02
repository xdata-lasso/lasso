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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 't3__bad7e9', 'ypuzhsrw', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1908028688, 2122220075);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-1, 't3__bad7e9', 'klfa9000t', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1408123494, -1964997180);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (0, 'nrqrofqy', '5s5b', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2107872094, 882961052);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2437, 't3__bad7e9', 'lex', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1775126557, -74849714);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2438, 'u78d99r', 'jsl', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -346339240, 1692174491);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: attribute --
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1, 'Speed');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (-1, 'Speed');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (0, 'dpos');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (2437, 'Speed');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (2438, 'cx5hn');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');

-- Inserting into table: hero_attribute --
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1072996612);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 0, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 0, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2438, -1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2437, 0, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 0, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2438, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2437, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2438, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2437, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2438, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2437, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -458359144);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 600440952);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -902895762);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -197933860);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1235416111);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1923912467);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -683007527);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 2035306060);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 765724008);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1099855564);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1284905200);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 7929158);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 569007824);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1139855872);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1962347906);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -866772222);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 944975670);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1575410149);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1950324754);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 2115816682);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -604098478);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1248858185);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1721638020);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 983324983);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 0, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 0, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 448935289);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -2090240067);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 234957614);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.superhero_name) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id INNER JOIN superhero AS T3 ON T1.hero_id = T3.id WHERE T2.attribute_name = 'Speed' ORDER BY T1.attribute_value DESC, T1.hero_id NULLS LAST, T1.attribute_id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(43,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Speed' AND hero_attribute.attribute_value = 100;

/*
Prediction Result:
(0,)
*/