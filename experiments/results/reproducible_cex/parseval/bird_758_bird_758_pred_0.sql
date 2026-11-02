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
INSERT INTO "colour" ("id", "colour") VALUES (2, 't3__de5067');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'tilbn');

INSERT INTO "colour" ("id", "colour") VALUES (4, 't3__de5067');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'x1');

INSERT INTO "colour" ("id", "colour") VALUES (1, 'mkrpdj');

INSERT INTO "colour" ("id", "colour") VALUES (5, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'ia2yp');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'tti');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'klfa9000t');

INSERT INTO "colour" ("id", "colour") VALUES (10, 'uo4nrqrofqy');

INSERT INTO "colour" ("id", "colour") VALUES (11, 'ytoo3o9hl7');

INSERT INTO "colour" ("id", "colour") VALUES (12, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483636, NULL);

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'ia2yp', 'uzhsrwbbp6lu', -2147483648, 2, 2, 2, 1, -2147483648, -2147483648, 185, 1019800248);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'dpos', 'ie5', -2147483648, 2, 3, 3, 1, -2147483648, -2147483648, 185, -1209887326);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'gce376nium52', 'zbuo4nrqrof', -2147483648, 2, 2, 2, 5, -2147483648, -2147483648, 185, 373262291);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'qa1', 'ryytoo3', -2147483648, 2, 3, 2, 3, -2147483648, -2147483648, 185, -1666765085);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, '7zw', 'au2dwyrq13', -2147483648, 2, 6, 3, 1, -2147483648, -2147483648, 185, 2142703426);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'sl0', '4', -2147483648, 4, 3, 3, 1, -2147483648, -2147483648, 185, 1649269347);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'kf9vq', 'x58pz0f8je', -2147483648, 6, 2, 6, 5, -2147483648, -2147483648, 185, 1196308825);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, '9uxj4hwbdvl', 'h2gn', -2147483648, 6, 3, 6, 3, -2147483648, -2147483648, 185, 1968874827);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, '5hncprjtu0d', '79fjgq8', -2147483648, 3, 6, 4, 1, -2147483648, -2147483648, 185, -1255130038);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'gcb98oz', '3zb', -2147483648, 6, 3, 4, 1, -2147483648, -2147483648, 185, -1554531873);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 'k', 'ah0f8jsww', -2147483648, 4, 2, 4, 5, -2147483648, -2147483648, 185, -1388029300);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, '7', 'yfdrz', -2147483648, 2, 3, 4, 3, -2147483648, -2147483648, 185, 61479715);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'dh5ogrgj', '8', -2147483648, 3, 6, 3, 1, -2147483648, -2147483648, 185, -458359144);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'ri', 'tsj3ayxp1q4', -2147483648, 2, 3, 3, 1, -2147483648, -2147483648, 185, -1538707438);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, '68x8vacx7a', 'u5', -2147483648, 2, 2, 2, 1, -2147483648, -2147483648, 185, -290314193);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'ctdctmfg62g0', '5q8qdj', -2147483648, 3, 3, 6, 1, -2147483648, -2147483648, 185, -1139855872);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483632, 'dgj5i', 'lq5lnpim', -2147483648, 4, 2, 6, 1, -2147483648, -2147483648, 1, -55240145);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483631, 'r94gth2m', 'ajjl', -2147483648, 4, 3, 3, 1, -2147483648, -2147483648, 1, -2096405521);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483630, 'tmu2ne578l', 'vy', -2147483648, 3, 2, 4, 1, -2147483648, -2147483648, 185, -451030047);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483629, 'v42q7sx58b4p', 'aus3', -2147483648, 2, 3, 3, 1, -2147483648, -2147483648, 185, -2090240067);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483628, 'n9', 'o705', -2147483648, 6, 2, 2, 1, -2147483648, -2147483648, 185, 238533676);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483627, 'ws', 'do2zobb', -2147483648, 3, 3, 3, 1, -2147483648, -2147483648, 185, -397848196);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'gu7v', 'e4', -2147483648, 1, 5, 6, 2, -2147483648, -2147483648, 185, 1160656988);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'wbbp6', 'uhv', -2147483648, 6, 7, 5, 6, -2147483648, -2147483648, 1, 1526238907);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'dpos', 'ie5', -2147483648, 2, 8, 1, 7, -2147483648, -2147483648, 1, -1209887326);

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

INSERT INTO "race" ("id", "race") VALUES (6, 't2__aa83ad');

INSERT INTO "race" ("id", "race") VALUES (7, NULL);

INSERT INTO "race" ("id", "race") VALUES (8, 'Human');

INSERT INTO "race" ("id", "race") VALUES (9, 't2__aa83ad');

INSERT INTO "race" ("id", "race") VALUES (10, NULL);

INSERT INTO "race" ("id", "race") VALUES (11, 'Human');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
('t3__de5067',)
('tilbn',)
('x1',)
('5k5swwqcgs',)
*/

-- Prediction Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.hair_colour_id = T2.id INNER JOIN race AS T3 ON T1.race_id = T3.id WHERE T1.height_cm = 185 AND T3.race = 'human';

/*
Prediction Result:
*/