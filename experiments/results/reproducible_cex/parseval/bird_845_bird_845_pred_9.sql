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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'ypuzhsrw', 'b', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1072996612);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'ilbnp', 'mdpos', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -1576219117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'u', '4nrq', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 418417917, -1031969798);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'f8jegd21vy9u', 'j4hwbd', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, NULL, -736979194);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'nqcx5h', 'cprj', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, NULL, -841004020);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'zbilyrkn', '6vck6ah0f8js', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, NULL, -658391922);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, '7', 'yfdrz', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, NULL, 61479715);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'og', 'itsj3', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1, -491938169);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'jh3den8c68', '8vacx7', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 0, 1523825314);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, '72ctdctmfg62', '0v', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1, 820970595);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, '2278', '07cvtjpt', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 0, 453836040);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'c4bfkfoac', '0', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1, 76987628);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'xd', 'ysxcmr0o', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 0, 853709925);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, 'm5k', '8qs27p2r', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1, -95808609);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'la3', 'okv8uttmu2', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 0, -1252009958);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (13, 'v42q7sx58b4p', 'aus3', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1, -2090240067);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (12, 'wzw5chn9mo70', 'a9n0jxfo', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 0, -1793230843);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (15, '2odwcl5a', 'msorlwyngc', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1, -323362455);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (14, 'k1yoeyo6l0h', 't', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 0, -795975227);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (17, 'elboeowii', 'z5nxih6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 885499, -251205568);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (16, '9oaawg', '6aqb0tbin', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 8855, -1897615568);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (19, 'c', '3tdu6bd0w960', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 885499, 740386991);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (18, '9yfk7qk162n', '55', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 8855, 2105860871);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');

-- Inserting into table: superpower --
INSERT INTO "superpower" ("id", "power_name") VALUES (2, 't3__8ab48a');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483648, 't3__8ab48a');

INSERT INTO "superpower" ("id", "power_name") VALUES (3, '4');

INSERT INTO "superpower" ("id", "power_name") VALUES (1, 't3__8ab48a');

INSERT INTO "superpower" ("id", "power_name") VALUES (4, 'u5');

INSERT INTO "superpower" ("id", "power_name") VALUES (5, '6b');

INSERT INTO "superpower" ("id", "power_name") VALUES (6, 'dgj5i');

INSERT INTO "superpower" ("id", "power_name") VALUES (7, '78lfvyz7');

INSERT INTO "superpower" ("id", "power_name") VALUES (8, 'zdo2z');

INSERT INTO "superpower" ("id", "power_name") VALUES (9, 'xuzkb52');

INSERT INTO "superpower" ("id", "power_name") VALUES (10, '9tajz9td');

INSERT INTO "superpower" ("id", "power_name") VALUES (11, 'dohvu06d');

-- Inserting into table: hero_power --
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (4, 4);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (6, 5);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (8, 6);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (10, 7);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (12, 8);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (14, 9);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (16, 10);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (18, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.height_cm * 100 > (SELECT AVG(height_cm) FROM superhero) * 80;

/*
Gold Result:
('4',)
('4',)
('4',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
('t3__8ab48a',)
*/

-- Prediction Query
SELECT DISTINCT "superpower"."power_name" FROM "superhero" INNER JOIN "hero_power" ON "superhero"."id" = "hero_power"."hero_id" INNER JOIN "superpower" ON "hero_power"."power_id" = "superpower"."id" WHERE "superhero"."height_cm" > (SELECT AVG("height_cm") * 0.8 FROM "superhero");

/*
Prediction Result:
('4',)
('t3__8ab48a',)
*/