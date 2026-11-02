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
INSERT INTO "colour" ("id", "colour") VALUES (-2147483648, '4');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'a2y', 'uzhs', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 150, 700293388);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'fqyp', 's5bbp02e', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 151, -751275471);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'jsl', 'b4yp5qi', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 181, -227162283);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'pz0f8jegd', '1vy9uxj4', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 150, -1612443122);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'gndqwnqc', 'x5hncprjtu0', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 150, -1898531797);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'cgsk9', '8c4p', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 3, -2147483648, 150, 1871297066);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'g', 'k9n8c', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, 150, -106629402);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'hria2ypuzhs', 'rwbbp6luhvd', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 7, -2147483648, 150, -1377057208);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'ie5', 'nw6klf', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 6, -2147483648, NULL, 1038707349);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'cgsk9', '8c4p', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, 150, 1871297066);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'ia2yp', 'uzhsrwbbp6lu', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, 150, 1019800248);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'bnp', 'mdpos', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, 150, -1576219117);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '9n8');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, 'gu7v');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1, '5k5swwqcgs');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (2, 'hvdlttilbnpr');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (4, 'siie5unw6k');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (3, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (5, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (7, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (6, 'ilbnp');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (8, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (9, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (10, 'Marvel Comics');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, '4h');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.publisher_name = 'Marvel Comics' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T1.height_cm BETWEEN 150 AND 180;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN publisher_id = 13 THEN 1 ELSE 0 END) AS REAL) * 100.0 / CAST(COUNT(*) AS REAL)) AS marvel_percentage FROM superhero WHERE height_cm BETWEEN 150 AND 180;

/*
Prediction Result:
(0.0,)
*/