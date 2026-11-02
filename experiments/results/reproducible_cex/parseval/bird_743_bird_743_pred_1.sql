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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'e4', 'hria2ypuzhs', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'hvdlttilbnpr', 'dpos', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1, -1576219117, -1823627488);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, '6nium52zb', 'uo4nrqrofqy', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, 1, -1106983592, 1884179925);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'ryytoo3', '9hl7', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 4, 1178636309, -1390245819);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, '7zwau2dwyr', '13pyu', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, 1, 176380444, -977635379);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'yp5qi2rk', '9v', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 4, 556727997, 1178000634);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'gd', '1vy9uxj4', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, 1, -1612443122, -2050247126);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'nd', 'wnqcx', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 4, 722884590, 580968159);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'u0dz7', 'fjgq8n2f3', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, 1, 806170397, 513454646);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, '8ozk3zbil', 'yrkn6vck6ah0', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 4, -1520489792, -658391922);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'xa', '7ryfdrz16n', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1, -1496556994, -2115841792);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'rg', 'd8y', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1, 1129658414, 1250290042);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'tg6bnou5zi', '6c4bfkfo', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1, -1950324754, 2115816682);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, '5', 'sxcmr0o', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1, 853709925, -870767087);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, 'im5k', '8qs27p2r', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1, -95808609, -244633520);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'qcgsk9', '8c4p', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2, 2, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'rwbbp', 'luhvdltti', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 5, 5, -1364429300, -1257178728);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'qcgsk9', '8c4p', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 6, 6, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'ia2yp', 'uzhsrwbbp6lu', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 7, 7, 1019800248, -1910425938);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'nprmdposii', '5u', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 8, 8, 1861536320, 44952191);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, '0t5c4ecigc', 'e376nium52', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 9, 9, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'rofqyp5s5b', 'p', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 10, 10, 882961052, 743312762);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (1, 'Bad');

INSERT INTO "alignment" ("id", "alignment") VALUES (3, 'Bad');

INSERT INTO "alignment" ("id", "alignment") VALUES (4, 'bbp02eut');

INSERT INTO "alignment" ("id", "alignment") VALUES (2, 'Bad');

INSERT INTO "alignment" ("id", "alignment") VALUES (5, NULL);

INSERT INTO "alignment" ("id", "alignment") VALUES (6, 'Bad');

INSERT INTO "alignment" ("id", "alignment") VALUES (7, 'Bad');

INSERT INTO "alignment" ("id", "alignment") VALUES (8, 'Bad');

INSERT INTO "alignment" ("id", "alignment") VALUES (9, 'Bad');

INSERT INTO "alignment" ("id", "alignment") VALUES (10, 'Bad');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1, '5k5swwqcgs');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (3, 'nw6klf');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (4, '0t5c4ecigc');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (2, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (5, 'vfe4hria2');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (6, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (7, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (8, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (9, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (10, 'Marvel Comics');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'u7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (CAST(COUNT(*) AS REAL) * 100 / (SELECT COUNT(*) FROM superhero)), CAST(SUM(CASE WHEN T2.publisher_name = 'Marvel Comics' THEN 1 ELSE 0 END) AS REAL) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN alignment AS T3 ON T3.id = T1.alignment_id WHERE T3.alignment = 'Bad';

/*
Gold Result:
(77.27272727272727, 6.0)
*/

-- Prediction Query
SELECT (SUM(alignment.alignment = 'Neutral') * 100.0 / COUNT(superhero.id)) AS neutral_alignment_percentage, COUNT(CASE WHEN alignment.alignment = 'Neutral' AND publisher.publisher_name = 'Marvel Comics' THEN superhero.id END) AS marvel_neutral_alignment_count FROM superhero JOIN alignment ON superhero.alignment_id = alignment.id JOIN publisher ON superhero.publisher_id = publisher.id;

/*
Prediction Result:
(0.0, 0)
*/