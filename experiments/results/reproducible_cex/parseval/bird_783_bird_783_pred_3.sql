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
INSERT INTO "colour" ("id", "colour") VALUES (1, 't2__3667e3');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483647, 't2__3667e3');

INSERT INTO "colour" ("id", "colour") VALUES (2, 't2__3667e3');

INSERT INTO "colour" ("id", "colour") VALUES (4, 'rqro');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (5, 'j');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'zj');

INSERT INTO "colour" ("id", "colour") VALUES (10, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'a3o');

INSERT INTO "colour" ("id", "colour") VALUES (12, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (11, 'wzw5chn9mo70');

INSERT INTO "colour" ("id", "colour") VALUES (14, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (13, '9erhizgk1yoe');

INSERT INTO "colour" ("id", "colour") VALUES (16, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (15, 'otow9oa');

INSERT INTO "colour" ("id", "colour") VALUES (18, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (17, '9y');

INSERT INTO "colour" ("id", "colour") VALUES (20, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (19, 'b');

INSERT INTO "colour" ("id", "colour") VALUES (22, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (21, 'a8y3a17v4yg');

INSERT INTO "colour" ("id", "colour") VALUES (24, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (23, 'qb9i9f2ccu');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -1364429300, -1257178728);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'siie5unw6k', 'fa9', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'ecigce376n', 'um5', -2147483648, 1, -2147483647, 1, -2147483648, -2147483648, -2147483648, 742285925, -747753377);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 's5bbp02e', 'tliqa1', -2147483648, 4, 2, 1, -2147483648, -2147483648, -2147483648, 2074205376, 274769912);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'hl72klex1', 'ji7zwau2', -2147483648, 1, -2147483647, 4, -2147483648, -2147483648, -2147483648, 364869063, -953437896);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, '8d99rljsl', 'b4yp5qi', -2147483648, 4, -2147483647, 1, -2147483648, -2147483648, -2147483648, -227162283, 2056419640);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'pz0f8jegd', '1vy9uxj4', -2147483648, 1, 3, 4, -2147483648, -2147483648, -2147483648, -1612443122, -2050247126);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'nd', 'wnqcx', -2147483648, 4, -2147483647, 1, -2147483648, -2147483648, -2147483648, 722884590, 580968159);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'u0dz7', 'fjgq8n2f3', -2147483648, 1, -2147483647, 4, -2147483648, -2147483648, -2147483648, 806170397, 513454646);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, '9', 'ozk3zbily', -2147483648, 1, 3, 1, -2147483648, -2147483648, -2147483648, 638024588, -688098735);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, '8j', 'wwlq7', -2147483648, 1, 3, 1, -2147483648, -2147483648, -2147483648, 1255343543, -541746689);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'c68x8vacx', 'afu5w1of7', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 76996700, -435350511);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'mfg62', '0v', -2147483648, 1, 2, 1, -2147483648, -2147483648, -2147483648, 820970595, 1421303999);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, '278507cv', 'jpttg', -2147483648, 5, 4, 6, -2147483648, -2147483648, -2147483648, -2033879835, 1798111945);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, 'c4bfkfoac', '0', -2147483648, 1, 4, 1, -2147483648, -2147483648, -2147483648, 76987628, -253138337);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'ysxcmr0o', 'ztdgj5i3lq5l', -2147483648, 7, -2147483647, 8, -2147483648, -2147483648, -2147483648, 1339733032, -1556979799);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483632, '7p2r94gt', '2m', -2147483648, 1, 8, 1, -2147483648, -2147483648, -2147483648, 418247369, -1524425594);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'tmu2ne578l', 'vy', -2147483648, 9, 7, 10, -2147483648, -2147483648, -2147483648, -451030047, -2052653308);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483630, 'q7sx58b4', 'pmaus3auvmkr', -2147483648, 1, 2, 1, -2147483648, -2147483648, -2147483648, 609771851, -1934017803);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'xfo', 'ws', -2147483648, 11, 9, 12, -2147483648, -2147483648, -2147483648, 1719800120, -210159774);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483628, '0k32odwcl5a', 'msorlwyngc', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -323362455, 453340472);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'dt', 'fuqyxuzkb', -2147483648, 13, 7, 14, -2147483648, -2147483648, -2147483648, -30041412, -277407746);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483626, 'elboeowii', 'z5nxih6', -2147483648, 1, 2, 1, -2147483648, -2147483648, -2147483648, -251205568, 287256667);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, '0', 'bindz', -2147483648, 15, 4, 16, -2147483648, -2147483648, -2147483648, 2085299664, 2038321753);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483624, '5wcgumbc3td', 'u6bd0w9603', -2147483648, 1, 10, 1, -2147483648, -2147483648, -2147483648, -541917667, -961629819);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, '162nh55y3d', 'ohvu06dza3', -2147483648, 17, 15, 18, -2147483648, -2147483648, -2147483648, 1595632888, 2072023304);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483622, 'hy08ftp6', 'wt', -2147483648, 1, 14, 1, -2147483648, -2147483648, -2147483648, -1051623642, 2013745856);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, 'fx7h', '3p6sto1c', -2147483648, 19, 11, 20, -2147483648, -2147483648, -2147483648, 170892881, -1643065004);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483620, 'dyyd1jmgj', 'c', -2147483648, 1, 11, 1, -2147483648, -2147483648, -2147483648, 973811121, 280292620);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (12, 'dpuap', '6rntdqrhm', -2147483648, 21, 11, 22, -2147483648, -2147483648, -2147483648, 555368535, -1369148652);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483618, 'p490', 'dmsqtg', -2147483648, 1, 19, 1, -2147483648, -2147483648, -2147483648, -1872934808, -1974774786);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (13, 'ik1yhb', '8hlst1p', -2147483648, 23, 7, 24, -2147483648, -2147483648, -2147483648, -1333785554, 1784997708);

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
('j',)
('zj',)
('a3o',)
('wzw5chn9mo70',)
('9erhizgk1yoe',)
('otow9oa',)
('9y',)
('b',)
('a8y3a17v4yg',)
('qb9i9f2ccu',)
*/

-- Prediction Query
SELECT superhero.eye_colour_id FROM superhero INNER JOIN colour ON superhero.skin_colour_id = colour.id WHERE colour.colour = 'Gold';

/*
Prediction Result:
(5,)
(7,)
(9,)
(11,)
(13,)
(15,)
(17,)
(19,)
(21,)
(23,)
*/