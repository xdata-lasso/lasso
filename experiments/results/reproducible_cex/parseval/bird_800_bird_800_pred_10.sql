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

INSERT INTO "colour" ("id", "colour") VALUES (2, 'mdpos');

INSERT INTO "colour" ("id", "colour") VALUES (4, 'e5u');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (5, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (10, 'Blue');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'sup_7090cd', 'ypuzhsrw', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 1908028688, 2122220075);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'sup_7090cd', 'tti', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -1364429300, -1257178728);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'sup_7090cd', 'a9000t5c4eci', -2147483648, 4, 2, 1, -2147483648, -2147483648, -2147483648, 1149850321, -1833165707);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'sup_7090cd', 'zbuo4nrqrof', -2147483648, 4, 2, 2, -2147483648, -2147483648, -2147483648, 373262291, -472966518);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'sup_7090cd', '02eutliqa11r', -2147483648, 4, 2, 1, -2147483648, -2147483648, -2147483648, 2137741668, -525979501);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'sup_7090cd', '72klex14ji7z', -2147483648, 1, 2, 1, -2147483648, -2147483648, -2147483648, -2081315180, 1909986641);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'sup_a075e1', 'pyu78d99', -2147483648, 1, 2, 4, -2147483648, -2147483648, -2147483648, -977635379, 1661181156);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, NULL, 'vy9uxj4', -2147483648, 1, 1, 2, -2147483648, -2147483648, -2147483648, -1612443122, -2050247126);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, NULL, 'dqwn', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -1070063173, 555413010);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, NULL, 'tu0', -2147483648, 1, 1, 2, -2147483648, -2147483648, -2147483648, -1898531797, -1748371085);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, NULL, 'dqv0gcb9', -2147483648, 1, 4, 1, -2147483648, -2147483648, -2147483648, 172461907, 1606439408);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, NULL, 'yrkn6vck6ah0', -2147483648, 1, 2, 1, -2147483648, -2147483648, -2147483648, -1520489792, -658391922);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, NULL, '2fxa7ryfd', -2147483648, 1, 4, 4, -2147483648, -2147483648, -2147483648, 564390026, -1259474148);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'cgsk9', '8c4p', -2147483648, 3, 3, 4, -2147483648, -2147483648, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'cgsk9', '8c4p', -2147483648, 5, 3, 4, -2147483648, -2147483648, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'a2y', 'uzhs', -2147483648, 6, 1, 4, -2147483648, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'hvdlttilbnpr', 'dpos', -2147483648, 7, 6, 4, -2147483648, -2147483648, -2147483648, -1576219117, -1823627488);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'a9000t5c4eci', 'gce376nium52', -2147483648, 8, 6, 2, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'fqyp', 's5bbp02e', -2147483648, 9, 3, 5, -2147483648, -2147483648, -2147483648, -751275471, -1347802441);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'ytoo3o9hl7', 'klex14ji', -2147483648, 10, 7, 7, -2147483648, -2147483648, -2147483648, -453362185, 481163439);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '9n8');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.colour = 'Blue' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id;

/*
Gold Result:
(35.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "colour"."colour" = 'Blue' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("superhero"."superhero_name") FROM "superhero" INNER JOIN "colour" ON "superhero"."eye_colour_id" = "colour"."id";

/*
Prediction Result:
(50.0,)
*/