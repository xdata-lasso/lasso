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
INSERT INTO "colour" ("id", "colour") VALUES (2, 't3__ad412c');

INSERT INTO "colour" ("id", "colour") VALUES (1, 'tilbn');

INSERT INTO "colour" ("id", "colour") VALUES (4, 't3__ad412c');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'x1');

INSERT INTO "colour" ("id", "colour") VALUES (3, '9rljsl0b4');

INSERT INTO "colour" ("id", "colour") VALUES (5, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'ia2yp');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'tti');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'klfa9000t');

INSERT INTO "colour" ("id", "colour") VALUES (10, 'uo4nrqrofqy');

INSERT INTO "colour" ("id", "colour") VALUES (11, 'ytoo3o9hl7');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483637, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (12, '5k5swwqcgs');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'ia2yp', 'uzhsrwbbp6lu', -2147483648, 2, 2, 2, 1, -2147483648, -2147483648, 185, 1019800248);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'dpos', 'ie5', -2147483648, 2, 1, 1, 1, -2147483648, -2147483648, 185, -1209887326);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'gce376nium52', 'zbuo4nrqrof', -2147483648, 2, 2, 2, 5, -2147483648, -2147483648, 185, 373262291);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'qa1', 'ryytoo3', -2147483648, 2, 1, 2, 3, -2147483648, -2147483648, 185, -1666765085);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, '7zw', 'au2dwyrq13', -2147483648, 2, 6, 1, 1, -2147483648, -2147483648, 185, 2142703426);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, '5qi2', 'kf9vq', -2147483648, 4, 3, 3, 1, -2147483648, -2147483648, 185, 537874887);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'd2', 'vy9uxj4', -2147483648, 6, 2, 2, 5, -2147483648, -2147483648, 185, -1612443122);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'h2gndqwnqcx5', 'hncprjtu0dz', -2147483648, 2, 1, 1, 3, -2147483648, -2147483648, 185, -1748371085);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'dqv0gcb9', 'ozk3zbily', -2147483648, 4, 6, 2, 1, -2147483648, -2147483648, 185, 638024588);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'h0f8jswwlq7x', '7', -2147483648, 2, 3, 3, 1, -2147483648, -2147483648, 185, 602161869);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 'dr', 'z16nijjai5d', -2147483648, 4, 2, 6, 5, -2147483648, -2147483648, 185, -1625552518);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, '8', 'yzt1afgogrit', -2147483648, 2, 1, 1, 3, -2147483648, -2147483648, 185, 678047687);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, '1q43', '1jh3den', -2147483648, 6, 6, 4, 1, -2147483648, -2147483648, 185, 357330522);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'x7afu5w1of77', 'zo72', -2147483648, 3, 3, 2, 1, -2147483648, -2147483648, 185, -1957268147);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, '62', '0v', -2147483648, 2, 2, 2, 1, -2147483648, -2147483648, 185, 820970595);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'io22785', '7cvtjpt', -2147483648, 2, 1, 2, 1, -2147483648, -2147483648, 185, 453836040);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483632, 'pim5', '58q', -2147483648, 1, 2, 1, 1, -2147483648, -2147483648, 1, 1817366143);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483631, '4gth2mnaj', 'la3', -2147483648, 3, 1, 4, 1, -2147483648, -2147483648, 1, 1803796945);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483630, 'mu2ne', '78lfvyz7', -2147483648, 3, 2, 3, 1, -2147483648, -2147483648, 185, 448935289);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483629, 'yvkv42q7sx58', 'b4pmaus3auv', -2147483648, 3, 1, 3, 1, -2147483648, -2147483648, 185, -1278087274);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483628, 'w5chn9m', 'o705a9n0jxfo', -2147483648, 1, 2, 4, 1, -2147483648, -2147483648, 185, -1793230843);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483627, 'obb0q0k', '2odwcl5a', -2147483648, 6, 1, 6, 1, -2147483648, -2147483648, 185, 292557306);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'gu7v', 'e4', -2147483648, 3, 5, 6, 2, -2147483648, -2147483648, 185, 1160656988);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'wbbp6', 'uhv', -2147483648, 6, 7, 5, 6, -2147483648, -2147483648, 1, 1526238907);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'dpos', 'ie5', -2147483648, 2, 8, 3, 7, -2147483648, -2147483648, 1, -1209887326);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'gce', '76nium52', -2147483648, 2, 9, 2, 8, -2147483648, -2147483648, NULL, -443340271);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'p', '02eutliqa11r', -2147483648, 8, 10, 2, 9, -2147483648, -2147483648, NULL, 2137741668);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, '4ji7zwa', '2dwyrq', -2147483648, 4, 11, 5, 10, -2147483648, -2147483648, NULL, -1097120355);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'gu7v', 'e4', -2147483648, 10, 12, 8, 11, -2147483648, -2147483648, 185, 1160656988);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '9n8c4pgu7v');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'e4');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (1, 'Human');

INSERT INTO "race" ("id", "race") VALUES (4, 'Human');

INSERT INTO "race" ("id", "race") VALUES (5, '9000t5c4ec');

INSERT INTO "race" ("id", "race") VALUES (3, 'bbp02eut');

INSERT INTO "race" ("id", "race") VALUES (2, NULL);

INSERT INTO "race" ("id", "race") VALUES (6, 't2__c7a342');

INSERT INTO "race" ("id", "race") VALUES (7, NULL);

INSERT INTO "race" ("id", "race") VALUES (8, 'Human');

INSERT INTO "race" ("id", "race") VALUES (9, 't2__c7a342');

INSERT INTO "race" ("id", "race") VALUES (10, NULL);

INSERT INTO "race" ("id", "race") VALUES (11, 'Human');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
('t3__ad412c',)
('tilbn',)
('x1',)
('9rljsl0b4',)
('5k5swwqcgs',)
*/

-- Prediction Query
SELECT T1.colour FROM colour AS T1 JOIN superhero AS T2 ON T1.id = T2.hair_colour_id WHERE T2.height_cm = 185 AND T2.race_id = (SELECT id FROM race WHERE race = 'Human');

/*
Prediction Result:
('t3__ad412c',)
('tilbn',)
('x1',)
('9rljsl0b4',)
('x1',)
('9rljsl0b4',)
('x1',)
('9rljsl0b4',)
('t3__ad412c',)
('tilbn',)
('t3__ad412c',)
('tilbn',)
('t3__ad412c',)
('tilbn',)
*/