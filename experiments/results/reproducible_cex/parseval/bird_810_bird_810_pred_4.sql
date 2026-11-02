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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'e4', 'hria2ypuzhs', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'rmdp', 'siie', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -45536098, 1861536320);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-1, 'e376nium52', 'zbuo4nrqrof', -2147483648, -2147483648, -2147483648, -2147483648, 0, -2147483648, -2147483648, 373262291, -472966518);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (0, '02eutliqa11r', 'ytoo3o9', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1666765085, 1178636309);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, '8ozk3zbil', 'yrkn6vck6ah0', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1520489792, -658391922);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'a7ryfd', 'z16ni', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 2011234363, -1483100200);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'u7vfe4hria2y', 'uzhs', -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'posiie5unw6k', 'fa9', -2147483648, -2147483648, -2147483648, -2147483648, 5, -2147483648, -2147483648, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'zbuo4nrq', 'rofqyp5s5b', -2147483648, -2147483648, -2147483648, -2147483648, 7, -2147483648, -2147483648, 2107872094, 882961052);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'o3o9hl72klex', '4ji7zwa', -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, -2147483648, 2123196517, 364869063);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'yp5qi2rk', '9v', -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, -2147483648, 556727997, 1178000634);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'v', 'ph2', -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, -2147483648, 1298861365, 1968874827);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: attribute --
INSERT INTO "attribute" ("id", "attribute_name") VALUES (-2147483648, 'b');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (0, 'ex1');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (1, 'ji7zwau2');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (-1, 'pz0f8jegd');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (1, 't3__e61066');

INSERT INTO "race" ("id", "race") VALUES (2, 't3__e61066');

INSERT INTO "race" ("id", "race") VALUES (-2147483647, 't3__e61066');

INSERT INTO "race" ("id", "race") VALUES (0, 't3__e61066');

INSERT INTO "race" ("id", "race") VALUES (-1, 't3__e61066');

INSERT INTO "race" ("id", "race") VALUES (6, '3pyu78d');

INSERT INTO "race" ("id", "race") VALUES (3, '4');

INSERT INTO "race" ("id", "race") VALUES (-2147483641, NULL);

INSERT INTO "race" ("id", "race") VALUES (4, '5k5swwqcgs');

INSERT INTO "race" ("id", "race") VALUES (-2147483639, NULL);

INSERT INTO "race" ("id", "race") VALUES (5, 'p6luhvdlttil');

INSERT INTO "race" ("id", "race") VALUES (-2147483637, NULL);

INSERT INTO "race" ("id", "race") VALUES (7, 'c4ecigce');

INSERT INTO "race" ("id", "race") VALUES (-2147483635, NULL);

INSERT INTO "race" ("id", "race") VALUES (8, 'liqa1');

INSERT INTO "race" ("id", "race") VALUES (-2147483633, NULL);

INSERT INTO "race" ("id", "race") VALUES (9, '3pyu78d99r');

INSERT INTO "race" ("id", "race") VALUES (-2147483631, NULL);

INSERT INTO "race" ("id", "race") VALUES (10, 'f8jegd21vy9u');

-- Inserting into table: hero_attribute --
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 1072996612);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, -1399556171);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, 1419861592);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 0, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, -1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, -1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 0, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, -1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, -1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 0, -211209314);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -1, 806170397);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 0, 1746373317);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, -1478247928);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -1, 1129658414);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, -1, -491938169);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -1, 518609210);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, -163600466);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 1, 645287482);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, -2147483648, -820614248);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (4, -2147483648, 2122220075);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (5, -1, 1990080517);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (6, -1, -1822992503);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (7, 1, -1021749117);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (8, 0, -461695645);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (9, 1, -1245682094);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN race AS T3 ON T1.race_id = T3.id ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('5k5swwqcgs',)
*/

-- Prediction Query
SELECT T3.race FROM superhero AS T1 JOIN hero_attribute AS T2 ON T1.id = T2.hero_id JOIN race AS T3 ON T1.race_id = T3.id WHERE T2.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute) LIMIT 1;

/*
Prediction Result:
('5k5swwqcgs',)
*/