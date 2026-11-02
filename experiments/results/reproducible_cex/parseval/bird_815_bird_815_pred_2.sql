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
INSERT INTO "colour" ("id", "colour") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'ia2yp', 'uzhsrwbbp6lu', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1019800248, -1910425938);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'bbp02eut', 'iqa', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -314162272, 2137741668);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, '9hl7', 'klex14ji', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -453362185, 481163439);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'u0dz7', 'fjgq8n2f3', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 806170397, 513454646);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, '8ozk3zbil', 'yrkn6vck6ah0', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -1520489792, -658391922);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'xa', '7ryfdrz16n', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -1496556994, -2115841792);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'qcgsk9', '8c4p', 2, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'ia2yp', 'uzhsrwbbp6lu', 5, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 5, 1019800248, -1910425938);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'nprmdposii', '5u', 6, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 6, 1861536320, 44952191);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, '0t5c4ecigc', 'e376nium52', 7, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 7, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'rofqyp5s5b', 'p', 8, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 8, 882961052, 743312762);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'a11ry', 'ytoo3o9hl7', 9, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 9, 1178636309, -1390245819);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, '7zwau2dwyr', '13pyu', 10, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 10, 176380444, -977635379);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, 'yp5qi2rk', '9v', 11, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 11, 556727997, 1178000634);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (1, 'Good');

INSERT INTO "alignment" ("id", "alignment") VALUES (3, 'Good');

INSERT INTO "alignment" ("id", "alignment") VALUES (4, 'tilbn');

INSERT INTO "alignment" ("id", "alignment") VALUES (2, 'Good');

INSERT INTO "alignment" ("id", "alignment") VALUES (5, 'Good');

INSERT INTO "alignment" ("id", "alignment") VALUES (6, 't2__80dc31');

INSERT INTO "alignment" ("id", "alignment") VALUES (7, 't2__80dc31');

INSERT INTO "alignment" ("id", "alignment") VALUES (8, 't2__80dc31');

INSERT INTO "alignment" ("id", "alignment") VALUES (9, NULL);

INSERT INTO "alignment" ("id", "alignment") VALUES (10, NULL);

INSERT INTO "alignment" ("id", "alignment") VALUES (11, NULL);

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (1, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (3, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (4, 'siie5unw6k');

INSERT INTO "gender" ("id", "gender") VALUES (2, 't3__c7792d');

INSERT INTO "gender" ("id", "gender") VALUES (5, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (6, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (7, 't3__c7792d');

INSERT INTO "gender" ("id", "gender") VALUES (8, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (9, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (10, 't3__c7792d');

INSERT INTO "gender" ("id", "gender") VALUES (11, NULL);

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, '9n8c4pgu7v');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'e4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.alignment = 'Good' AND T3.gender = 'Female';

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.id = 1 AND T3.id = 2;

/*
Prediction Result:
(0,)
*/