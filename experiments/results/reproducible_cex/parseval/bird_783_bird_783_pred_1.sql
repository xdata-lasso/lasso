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
INSERT INTO "colour" ("id", "colour") VALUES (1, 't2__a1416a');

INSERT INTO "colour" ("id", "colour") VALUES (2, 't2__a1416a');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483647, 't2__a1416a');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'cigce376nium');

INSERT INTO "colour" ("id", "colour") VALUES (4, 'eutliqa11r');

INSERT INTO "colour" ("id", "colour") VALUES (5, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (6, '7z2zezjo7wg');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'la3');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (10, 'wzw5chn9mo70');

INSERT INTO "colour" ("id", "colour") VALUES (11, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (12, '9erhizgk1yoe');

INSERT INTO "colour" ("id", "colour") VALUES (13, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (14, 'otow9oa');

INSERT INTO "colour" ("id", "colour") VALUES (15, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (16, 'xw1rxe9yfk7');

INSERT INTO "colour" ("id", "colour") VALUES (17, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (18, 'xxnja');

INSERT INTO "colour" ("id", "colour") VALUES (19, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (20, 'ma');

INSERT INTO "colour" ("id", "colour") VALUES (21, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (22, '9');

INSERT INTO "colour" ("id", "colour") VALUES (23, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (24, 'd8ftb8');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -1364429300, -1257178728);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'siie', 'unw6klfa', -2147483648, 2, -2147483647, 1, -2147483648, -2147483648, -2147483648, 1419861592, 700088193);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'uo4nrqrofqy', '5s5b', -2147483648, 3, 3, 1, -2147483648, -2147483648, -2147483648, 2107872094, 882961052);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'oo3o9hl72kl', 'x1', -2147483648, 4, 4, 1, -2147483648, -2147483648, -2147483648, -74849714, 105869088);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'yrq13p', 'u78d99r', -2147483648, 1, -2147483647, 4, -2147483648, -2147483648, -2147483648, -1362461264, -904834265);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'qi2rkf9v', 'x58pz', -2147483648, 4, 3, 1, -2147483648, -2147483648, -2147483648, -1529584866, 1196308825);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, '9uxj4hwbdvl', 'h2gn', -2147483648, 1, 3, 4, -2147483648, -2147483648, -2147483648, 1968874827, -664193365);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'cprj', 'u0dz7', -2147483648, 4, -2147483647, 1, -2147483648, -2147483648, -2147483648, 401805964, -1485777725);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'dqv0gcb98ozk', 'zbilyrkn', -2147483648, 1, 3, 4, -2147483648, -2147483648, -2147483648, -688098735, 1784916884);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'wwlq7', 'xb72fxa7ryfd', -2147483648, 1, 3, 1, -2147483648, -2147483648, -2147483648, 564390026, -1259474148);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'h', 'ogrgjd8y', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 1129658414, 1250290042);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'v5q8qdj', 'e1io', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -241848752, 2004147439);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'tg6bnou5zi', '6c4bfkfo', -2147483648, 1, 2, 1, -2147483648, -2147483648, -2147483648, -1950324754, 2115816682);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'cmr0oz', 'dgj5i', -2147483648, 1, 3, 1, -2147483648, -2147483648, -2147483648, -176606723, -15162884);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, '58q', 's27p2r94gth2', -2147483648, 6, 2, 5, -2147483648, -2147483648, -2147483648, 1162591638, -2136247961);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483633, 'tmu2ne578l', 'vy', -2147483648, 1, 5, 1, -2147483648, -2147483648, -2147483648, -451030047, -2052653308);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'q7sx58b4', 'pmaus3auvmkr', -2147483648, 8, -2147483647, 7, -2147483648, -2147483648, -2147483648, 609771851, -1934017803);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483631, 'xfo', 'ws', -2147483648, 1, 10, 1, -2147483648, -2147483648, -2147483648, 1719800120, -210159774);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, '0k32odwcl5a', 'msorlwyngc', -2147483648, 10, 1, 9, -2147483648, -2147483648, -2147483648, -323362455, 453340472);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483629, 'dt', 'fuqyxuzkb', -2147483648, 1, 8, 1, -2147483648, -2147483648, -2147483648, -30041412, -277407746);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'elboeowii', 'z5nxih6', -2147483648, 12, -2147483647, 11, -2147483648, -2147483648, -2147483648, -251205568, 287256667);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483627, '0', 'bindz', -2147483648, 1, 2, 1, -2147483648, -2147483648, -2147483648, 2085299664, 2038321753);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'n5wcgumbc', '3tdu6bd0w960', -2147483648, 14, 8, 13, -2147483648, -2147483648, -2147483648, 740386991, 2018368241);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483625, '55', '3dohvu0', -2147483648, 1, 13, 1, -2147483648, -2147483648, -2147483648, 30861410, -438741674);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'io18ri2hy08', 'tp', -2147483648, 16, 8, 15, -2147483648, -2147483648, -2147483648, 24053253, -646944990);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483623, 'mfx7h33p', '6sto1cj8sh5k', -2147483648, 1, 6, 1, -2147483648, -2147483648, -2147483648, 1106724223, 1966809332);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'jmgjach', 'qta8y3a17', -2147483648, 18, 12, 17, -2147483648, -2147483648, -2147483648, -735270562, 614314115);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483621, 'uap9', 'rntdqrhm5', -2147483648, 1, 14, 1, -2147483648, -2147483648, -2147483648, -648564084, -1573704891);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, '90xdmsqt', 'el', -2147483648, 20, 14, 19, -2147483648, -2147483648, -2147483648, -1974774786, 422046500);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483619, 'kjq1qu', 'k1y', -2147483648, 1, 14, 1, -2147483648, -2147483648, -2147483648, 775289854, -2052350430);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (12, 'qomi', 'tvb6m4i', -2147483648, 22, 9, 21, -2147483648, -2147483648, -2147483648, -2128972904, -1043357093);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483617, 'r', '6b', -2147483648, 1, 13, 1, -2147483648, -2147483648, -2147483648, -1537647691, 364280973);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (13, 'h85', 'pxlvri', -2147483648, 24, 9, 23, -2147483648, -2147483648, -2147483648, 986268139, 2042428747);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '9n8');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'pgu7vfe4');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.skin_colour_id = T3.id WHERE T3.colour = 'Gold';

/*
Gold Result:
('7z2zezjo7wg',)
('la3',)
('wzw5chn9mo70',)
('9erhizgk1yoe',)
('otow9oa',)
('xw1rxe9yfk7',)
('xxnja',)
('ma',)
('9',)
('d8ftb8',)
*/

-- Prediction Query
SELECT colour.colour FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.skin_colour_id = (SELECT id FROM colour WHERE colour = 'Gold');

/*
Prediction Result:
('7z2zezjo7wg',)
*/