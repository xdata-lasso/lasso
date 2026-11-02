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
INSERT INTO "colour" ("id", "colour") VALUES (1, 't2__75c358');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483647, 't2__75c358');

INSERT INTO "colour" ("id", "colour") VALUES (3, '5c4ec');

INSERT INTO "colour" ("id", "colour") VALUES (4, '5bbp0');

INSERT INTO "colour" ("id", "colour") VALUES (5, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (2, 'tg6bnou5zi');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'pim5');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'yvkv42q7s');

INSERT INTO "colour" ("id", "colour") VALUES (11, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (10, '0');

INSERT INTO "colour" ("id", "colour") VALUES (13, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (12, 'yxuzk');

INSERT INTO "colour" ("id", "colour") VALUES (15, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (14, '0');

INSERT INTO "colour" ("id", "colour") VALUES (17, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (16, 'h55y');

INSERT INTO "colour" ("id", "colour") VALUES (19, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (18, 'n2mfx7h');

INSERT INTO "colour" ("id", "colour") VALUES (21, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (20, '8y3a17v4yg');

INSERT INTO "colour" ("id", "colour") VALUES (23, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (22, 'qb9i9f2ccu');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -1364429300, -1257178728);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'siie5unw6k', 'fa9', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'e376nium52', 'zbuo4nrqrof', -2147483648, 3, 3, 1, -2147483648, -2147483648, -2147483648, 373262291, -472966518);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'iqa', '1ryytoo', -2147483648, 4, 1, 1, -2147483648, -2147483648, -2147483648, 1644911394, -1666765085);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, '4ji7zwa', '2dwyrq', -2147483648, 1, -2147483647, 4, -2147483648, -2147483648, -2147483648, -1097120355, 244829661);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, '4', 'p5qi2rk', -2147483648, 4, 3, 1, -2147483648, -2147483648, -2147483648, -705985602, 537874887);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'd2', 'vy9uxj4', -2147483648, 1, 1, 4, -2147483648, -2147483648, -2147483648, -1612443122, -2050247126);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'nd', 'wnqcx', -2147483648, 4, -2147483647, 1, -2147483648, -2147483648, -2147483648, 722884590, 580968159);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'u0dz7', 'fjgq8n2f3', -2147483648, 1, -2147483647, 4, -2147483648, -2147483648, -2147483648, 806170397, 513454646);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, '8ozk3zbil', 'yrkn6vck6ah0', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -1520489792, -658391922);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'xa', '7ryfdrz16n', -2147483648, 1, 3, 1, -2147483648, -2147483648, -2147483648, -1496556994, -2115841792);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, '7pzo72ctd', 't', -2147483648, 1, 4, 1, -2147483648, -2147483648, -2147483648, -1284905200, 7929158);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'qdjpe1io2', '78507cvt', -2147483648, 1, 3, 1, -2147483648, -2147483648, -2147483648, -1523347137, 1582582341);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'foa', 'cd07z2zezjo7', -2147483648, 2, 4, 5, -2147483648, -2147483648, -2147483648, 304189298, -542502665);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, 'r0oz', 'dgj5i', -2147483648, 1, 3, 1, -2147483648, -2147483648, -2147483648, -176606723, -15162884);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, '7p2r94gth2m', 'ajjl', -2147483648, 6, 5, 7, -2147483648, -2147483648, -2147483648, -2096405521, 1803796945);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483632, '2ne578', 'fvy', -2147483648, 1, 5, 1, -2147483648, -2147483648, -2147483648, -451030047, -2052653308);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'pmaus3auvmkr', 'pdjwzw5chn9', -2147483648, 8, 9, 9, -2147483648, -2147483648, -2147483648, 101754718, 628082526);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483630, 'fwsz', 'o', -2147483648, 1, 3, 1, -2147483648, -2147483648, -2147483648, 1010672881, -1197954156);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'dwcl', '5amsorlwyngc', -2147483648, 10, 3, 11, -2147483648, -2147483648, -2147483648, -323362455, 453340472);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483628, 'k1', 'yoeyo6l0hdt6', -2147483648, 1, -2147483647, 1, -2147483648, -2147483648, -2147483648, 1435223075, 1617348603);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'nlas6e', 'lboeowii1z5', -2147483648, 12, 6, 13, -2147483648, -2147483648, -2147483648, 1557188093, 548968280);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483626, 'xlyotow9', 'aawg', -2147483648, 1, 9, 1, -2147483648, -2147483648, -2147483648, 1044710644, 966412849);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, '39tajz9', 'd8n5w', -2147483648, 14, 5, 15, -2147483648, -2147483648, -2147483648, -1988582944, -794767771);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483624, 'u6bd0w9603', 'vzxw1rxe9y', -2147483648, 1, 15, 1, -2147483648, -2147483648, -2147483648, -1046720861, 643589729);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, '06dza3', 'rmkio18r', -2147483648, 16, 6, 17, -2147483648, -2147483648, -2147483648, 431832073, 1510892261);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483622, '6ewt', 'xxnja', -2147483648, 1, 12, 1, -2147483648, -2147483648, -2147483648, -2080232972, 462225708);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, '1cj8', 'h5knz', -2147483648, 18, 6, 19, -2147483648, -2147483648, -2147483648, 1966809332, 1487347213);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483620, 'gjac', '8q', -2147483648, 1, -2147483647, 1, -2147483648, -2147483648, -2147483648, 280292620, 620355627);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (12, 'dpuap', '6rntdqrhm', -2147483648, 20, 13, 21, -2147483648, -2147483648, -2147483648, 555368535, -1369148652);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483618, 'p490', 'dmsqtg', -2147483648, 1, 21, 1, -2147483648, -2147483648, -2147483648, -1872934808, -1974774786);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (13, 'ik1yhb', '8hlst1p', -2147483648, 22, 9, 23, -2147483648, -2147483648, -2147483648, -1333785554, 1784997708);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483616, 'z78', 'q', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -1043357093, -753065777);

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
('tg6bnou5zi',)
('pim5',)
('yvkv42q7s',)
('0',)
('yxuzk',)
('0',)
('h55y',)
('n2mfx7h',)
('8y3a17v4yg',)
('qb9i9f2ccu',)
*/

-- Prediction Query
SELECT DISTINCT c2.colour AS eye_colour FROM superhero AS sh JOIN colour AS c1 ON sh.skin_colour_id = c1.id JOIN colour AS c2 ON sh.eye_colour_id = c2.id WHERE c1.colour = 'Gold';

/*
Prediction Result:
('tg6bnou5zi',)
('pim5',)
('yvkv42q7s',)
('0',)
('yxuzk',)
('h55y',)
('n2mfx7h',)
('8y3a17v4yg',)
('qb9i9f2ccu',)
*/