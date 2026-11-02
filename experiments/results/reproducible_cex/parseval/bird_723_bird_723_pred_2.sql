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
INSERT INTO "colour" ("id", "colour") VALUES (1, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (4, '5bbp0');

INSERT INTO "colour" ("id", "colour") VALUES (2, 't4__130be3');

INSERT INTO "colour" ("id", "colour") VALUES (5, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (6, 't4__130be3');

INSERT INTO "colour" ("id", "colour") VALUES (7, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (8, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (9, 't4__130be3');

INSERT INTO "colour" ("id", "colour") VALUES (10, NULL);

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'wbbp6luhvdlt', 'ilbnp', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 1236688122, 2087640001);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, '5u', 'w6kl', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'gce', '76nium52', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'cgsk9', '8c4p', -2147483648, 2, 2, 4, -2147483648, -2147483648, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'a2y', 'uzhs', -2147483648, 5, 1, 4, -2147483648, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'hvdlttilbnpr', 'dpos', -2147483648, 6, 6, 4, -2147483648, -2147483648, -2147483648, -1576219117, -1823627488);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'a9000t5c4eci', 'gce376nium52', -2147483648, 7, 4, 1, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'fqyp', 's5bbp02e', -2147483648, 8, 2, 5, -2147483648, -2147483648, -2147483648, -751275471, -1347802441);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'ytoo3o9hl7', 'klex14ji', -2147483648, 9, 7, 7, -2147483648, -2147483648, -2147483648, -453362185, 481163439);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, '13pyu', '8d99rljsl', -2147483648, 10, 1, 5, -2147483648, -2147483648, -2147483648, -346339240, 1692174491);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '9n8');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'pgu7vfe4');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'hria2ypuzhs');

-- Inserting into table: superpower --
INSERT INTO "superpower" ("id", "power_name") VALUES (1, 'Agility');

INSERT INTO "superpower" ("id", "power_name") VALUES (2, 'Agility');

INSERT INTO "superpower" ("id", "power_name") VALUES (3, 'fqyp');

INSERT INTO "superpower" ("id", "power_name") VALUES (4, 'Agility');

INSERT INTO "superpower" ("id", "power_name") VALUES (5, 'Agility');

INSERT INTO "superpower" ("id", "power_name") VALUES (6, 't3__70d805');

INSERT INTO "superpower" ("id", "power_name") VALUES (7, 't3__70d805');

INSERT INTO "superpower" ("id", "power_name") VALUES (8, NULL);

INSERT INTO "superpower" ("id", "power_name") VALUES (9, NULL);

INSERT INTO "superpower" ("id", "power_name") VALUES (10, NULL);

-- Inserting into table: hero_power --
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (4, 4);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 5);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (6, 6);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (7, 7);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (8, 8);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (9, 9);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (10, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN colour AS T4 ON T1.eye_colour_id = T4.id WHERE T3.power_name = 'Agility' AND T4.colour = 'Blue';

/*
Gold Result:
(32,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT superhero.id) AS count FROM hero_power INNER JOIN superhero ON hero_power.hero_id = superhero.id INNER JOIN superpower ON hero_power.power_id = superpower.id INNER JOIN colour ON superhero.eye_colour_id = colour.id WHERE superpower.power_name = 'Agility' AND colour.colour = 'Blue';

/*
Prediction Result:
(3,)
*/