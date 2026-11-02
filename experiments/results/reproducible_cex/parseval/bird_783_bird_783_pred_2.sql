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
INSERT INTO "colour" ("id", "colour") VALUES (1, 't2__f60022');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483647, 't2__f60022');

INSERT INTO "colour" ("id", "colour") VALUES (2, 't2__f60022');

INSERT INTO "colour" ("id", "colour") VALUES (4, 'rqro');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (5, 'cd07z2zezjo7');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'a3o');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'vmkrpd');

INSERT INTO "colour" ("id", "colour") VALUES (10, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (11, '2odwcl5a');

INSERT INTO "colour" ("id", "colour") VALUES (12, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (13, 'as6');

INSERT INTO "colour" ("id", "colour") VALUES (14, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (15, 'j');

INSERT INTO "colour" ("id", "colour") VALUES (16, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (17, 'h55y');

INSERT INTO "colour" ("id", "colour") VALUES (18, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (19, 'n2mfx7h');

INSERT INTO "colour" ("id", "colour") VALUES (20, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (21, '8y3a17v4yg');

INSERT INTO "colour" ("id", "colour") VALUES (22, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (23, 'qb9i9f2ccu');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -1364429300, -1257178728);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'siie5unw6k', 'fa9', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'ecigce376n', 'um5', -2147483648, 1, -2147483647, 1, -2147483648, -2147483648, -2147483648, 742285925, -747753377);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 's5bbp02e', 'tliqa1', -2147483648, 4, 2, 1, -2147483648, -2147483648, -2147483648, 2074205376, 274769912);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'hl72klex1', 'ji7zwau2', -2147483648, 1, -2147483647, 4, -2147483648, -2147483648, -2147483648, 364869063, -953437896);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, '8d99rljsl', 'b4yp5qi', -2147483648, 4, -2147483647, 1, -2147483648, -2147483648, -2147483648, -227162283, 2056419640);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'z0f8jegd21vy', '9uxj4hwbdvl', -2147483648, 1, 2, 4, -2147483648, -2147483648, -2147483648, 2103044118, -1642259219);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'qcx5', 'hncprjtu0dz', -2147483648, 4, 1, 1, -2147483648, -2147483648, -2147483648, -1748371085, -1742081330);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'qv0gcb98ozk', 'zbilyrkn', -2147483648, 1, 1, 4, -2147483648, -2147483648, -2147483648, -688098735, 1784916884);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'wwlq7', 'xb72fxa7ryfd', -2147483648, 1, 4, 1, -2147483648, -2147483648, -2147483648, 564390026, -1259474148);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'h', 'ogrgjd8y', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 1129658414, 1250290042);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'q8qdjpe1', 'o22', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 2004147439, -691774480);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'bnou5zi36', '4', -2147483648, 1, 2, 1, -2147483648, -2147483648, -2147483648, -2072838897, -1173368267);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'sxcmr0o', 'ztdgj5i3lq5l', -2147483648, 1, 2, 1, -2147483648, -2147483648, -2147483648, 1339733032, -1556979799);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, '7p2r94gt', '2m', -2147483648, 5, 4, 3, -2147483648, -2147483648, -2147483648, 418247369, -1524425594);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483633, 'mu2ne578lf', 'yz7zzb', -2147483648, 1, 5, 1, -2147483648, -2147483648, -2147483648, 924693315, -705922211);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, '58b4pm', 'u', -2147483648, 7, 7, 6, -2147483648, -2147483648, -2147483648, 1164790775, -200807520);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483631, 'h', '9mo7', -2147483648, 1, 6, 1, -2147483648, -2147483648, -2147483648, -354292049, 238533676);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'ws', 'do2zobb', -2147483648, 9, 5, 8, -2147483648, -2147483648, -2147483648, -397848196, -366775518);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483629, 'wyn', 'gc1dj9erhi', -2147483648, 1, 10, 1, -2147483648, -2147483648, -2147483648, 1056589776, -499913447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'hdt6fuq', 'xuzkb52', -2147483648, 11, 9, 10, -2147483648, -2147483648, -2147483648, -277407746, -670154354);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483627, 'ow', 'i1z', -2147483648, 1, 11, 1, -2147483648, -2147483648, -2147483648, -564679000, -251205568);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'otow9oaawg', '6aqb0tbin', -2147483648, 13, 10, 12, -2147483648, -2147483648, -2147483648, -1897615568, 2085299664);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483625, 'cgumbc', '3tdu6bd0w960', -2147483648, 1, -2147483647, 1, -2147483648, -2147483648, -2147483648, 740386991, 2018368241);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, '9y', 'k7', -2147483648, 15, 13, 14, -2147483648, -2147483648, -2147483648, -1046720861, 643589729);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483623, '06dza3', 'rmkio18r', -2147483648, 1, 7, 1, -2147483648, -2147483648, -2147483648, 431832073, 1510892261);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, '6ewt', 'xxnja', -2147483648, 17, 13, 16, -2147483648, -2147483648, -2147483648, -2080232972, 462225708);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483621, '1cj8', 'h5knz', -2147483648, 1, 7, 1, -2147483648, -2147483648, -2147483648, 1966809332, 1487347213);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, 'gjac', '8q', -2147483648, 19, -2147483647, 18, -2147483648, -2147483648, -2147483648, 280292620, 620355627);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483619, 'dpuap', '6rntdqrhm', -2147483648, 1, 12, 1, -2147483648, -2147483648, -2147483648, 555368535, -1369148652);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (12, 'p490', 'dmsqtg', -2147483648, 21, 20, 20, -2147483648, -2147483648, -2147483648, -1872934808, -1974774786);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483617, 'ik1yhb', '8hlst1p', -2147483648, 1, 8, 1, -2147483648, -2147483648, -2147483648, -1333785554, 1784997708);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (13, 'z78', 'q', -2147483648, 23, 1, 22, -2147483648, -2147483648, -2147483648, -1043357093, -753065777);

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
('cd07z2zezjo7',)
('a3o',)
('vmkrpd',)
('2odwcl5a',)
('as6',)
('j',)
('h55y',)
('n2mfx7h',)
('8y3a17v4yg',)
('qb9i9f2ccu',)
*/

-- Prediction Query
SELECT T1.eye_colour_id FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id WHERE T2.colour = 'Gold';

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