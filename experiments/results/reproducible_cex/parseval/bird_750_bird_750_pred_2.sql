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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'wbbp6luhvdlt', 'ilbnp', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1236688122, 2087640001);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'klfa9000t', 'c4ecigce', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1585009206, -53231346);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'rqrofqyp5s', 'bbp02eut', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1347802441, 1673584235);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'oo3o9', 'l7', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1178636309, -1390245819);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'au2dwy', 'q13py', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 244829661, -1362461264);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'p5qi2rkf9v', 'x58pz', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1529584866, 1196308825);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'j4hwbd', 'lph2gn', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1968874827, -664193365);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, '6vck6ah0f8js', 'wlq7xb', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 602161869, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'r', 'z16nijjai5d', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1625552518, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'yzt1afgog', 'itsj3', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -491938169, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 'jh3den8', 'c68x8vacx7', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1523825314, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'f77pzo72ctd', 't', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1284905200, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'q8qdjpe1io22', '8507cvtjp', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1582582341, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'cgsk9', '8c4p', 8, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1871297066, 1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'a2y', 'uzhs', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 700293388, 1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'hvdlttilbnpr', 'dpos', 2, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1576219117, -1823627488);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'cgsk9', '8c4p', 5, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'a2y', 'uzhs', 7, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'dlttil', 'n', 9, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 462974032, -1137908826);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'w6kl', 'a9', 10, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, 'cigce376nium', '52zbuo4nrq', 11, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 418417917, -1031969798);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (1, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (3, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (4, 'siie');

INSERT INTO "gender" ("id", "gender") VALUES (6, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (8, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (2, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (5, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (7, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (9, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (10, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (11, 'Female');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'pgu7vfe4');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.weight_kg) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Female';

/*
Gold Result:
(271195625.7,)
*/

-- Prediction Query
SELECT AVG(T1.weight_kg) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.id = 2;

/*
Prediction Result:
(-1823627488.0,)
*/