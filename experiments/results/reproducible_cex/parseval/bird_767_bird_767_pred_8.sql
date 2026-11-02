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
INSERT INTO "colour" ("id", "colour") VALUES (1, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (2, '4nrq');

INSERT INTO "colour" ("id", "colour") VALUES (4, 's5bbp02e');

INSERT INTO "colour" ("id", "colour") VALUES (3, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (5, 'b');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'siie5unw6k');

INSERT INTO "colour" ("id", "colour") VALUES (7, '4nrq');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'eutliqa11r');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'hvdlttilbnpr', 'dpos', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -1576219117, -1823627488);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'a9000t5c4eci', 'gce376nium52', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'tliqa1', 'ryytoo3', -2147483648, 1, 2, 4, -2147483648, -2147483648, -2147483648, -1666765085, 1178636309);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, '7zw', 'au2dwyrq13', -2147483648, 1, 2, 4, -2147483648, -2147483648, -2147483648, 2142703426, -533293970);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, '0b4', 'p5qi2rk', -2147483648, 4, 1, 4, -2147483648, -2147483648, -2147483648, -705985602, 537874887);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'd2', 'vy9uxj4', -2147483648, 2, 4, 1, -2147483648, -2147483648, -2147483648, -1612443122, -2050247126);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'nd', 'wnqcx', -2147483648, 1, 4, 1, -2147483648, -2147483648, -2147483648, 722884590, 580968159);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'bilyrkn', '6vck6ah0f8js', -2147483648, 1, 2, 1, -2147483648, -2147483648, -2147483648, -658391922, -1388029300);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, '7ryfdrz16n', 'jja', -2147483648, 1, 1, 2, -2147483648, -2147483648, -2147483648, -7597509, -1625552518);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'u7vfe4hria2y', 'uzhs', -2147483648, 2, 3, 3, -2147483648, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'l', 'tilbn', -2147483648, 5, 4, 5, -2147483648, -2147483648, -2147483648, 462974032, -1137908826);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, '0t5c4ecigc', 'e376nium52', -2147483648, 1, 5, 6, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, '5s5b', 'p', -2147483648, 2, 5, 7, -2147483648, -2147483648, -2147483648, 882961052, 743312762);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, '9hl7', 'klex14ji', -2147483648, 7, 3, 8, -2147483648, -2147483648, -2147483648, -453362185, 481163439);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '9n8');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, 'pgu7vfe4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'ia2yp');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'uzhsrwbbp6lu');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(*) AS REAL) / SUM(CASE WHEN T2.id = 1 THEN 1 ELSE 0 END) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id;

/*
Gold Result:
(2.8,)
*/

-- Prediction Query
SELECT CAST(COUNT(T1.id) AS REAL) / SUM(CASE WHEN T2.colour = 'No Colour' THEN 1 ELSE 0 END) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id;

/*
Prediction Result:
(None,)
*/