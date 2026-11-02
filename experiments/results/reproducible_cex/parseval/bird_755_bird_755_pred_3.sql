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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'e4', 'sup_a7df33', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1160656988, -992890117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'sr', 'sup_6cfb58', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 906324270, 1908028688);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'l', 'sup_7c004c', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -845863578, -1610064545);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'posiie5unw6k', 'sup_e31069', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1151980946, 1620389964);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'ecigce376n', 'sup_954d1d', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1313172851, -761141909);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'nrqrofqy', 'sup_a7df33', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1106983592, 1884179925);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'eutliqa11r', 'sup_a7df33', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 2137741668, -525979501);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, '72klex14ji7z', 'sup_7c004c', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -2081315180, 1909986641);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'yu78', 'sup_e31069', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 244829661, -1362461264);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'p5qi2rkf9v', 'sup_954d1d', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 556727997, 1178000634);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 'vy9uxj4', 'sup_a7df33', -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, -2147483648, -1612443122, -2050247126);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'nqcx5h', 'sup_6cfb58', -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, -2147483648, -1245312912, 1575412235);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'gq8', 'sup_7c004c', -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, -2147483648, -1255130038, -1762857309);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'kn6vc', 'sup_e31069', -2147483648, -2147483648, -2147483648, -2147483648, 11, -2147483648, -2147483648, 1784916884, 37673509);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, 'xa', 'sup_954d1d', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 1294666887, -515895469);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483633, 'jai', 'sup_a7df33', -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, -2147483648, 1746373317, 1360271423);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483632, '8', 'sup_6cfb58', -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, -2147483648, -458359144, 600440952);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483631, 'tsj', 'sup_7c004c', -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, -2147483648, -197933860, 2111987706);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483630, '1jh3den', 'sup_e31069', -2147483648, -2147483648, -2147483648, -2147483648, 11, -2147483648, -2147483648, 357330522, -683007527);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483629, '1of77p', 'sup_954d1d', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -435350511, 1992637800);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483628, '62', 'sup_a7df33', -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, -2147483648, -1744557630, 1870300798);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483627, '1i', 'sup_6cfb58', -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, -2147483648, 1897687032, -241848752);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483626, 'ttg6', 'sup_7c004c', -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, -2147483648, 1467355421, -1171104889);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483625, 'f', 'sup_e31069', -2147483648, -2147483648, -2147483648, -2147483648, 11, -2147483648, -2147483648, -1173368267, 382831862);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483624, 'zjo7wgxd5ysx', 'sup_954d1d', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -2005628382, 1721638020);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483623, '5i3', 'sup_a7df33', -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, -2147483648, -1405314653, 1816660482);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483622, '58q', 'sup_6cfb58', -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, -2147483648, 1817366143, 1615073310);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483621, '2m', 'sup_7c004c', -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, -2147483648, 418247369, -1524425594);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483620, 'uttmu2ne5', 'sup_e31069', -2147483648, -2147483648, -2147483648, -2147483648, 11, -2147483648, -2147483648, -1402164108, 2123471885);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483619, 'yvkv42q7s', 'sup_954d1d', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 1735561423, 756202403);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483618, 'w5chn9m', 'sup_7c004c', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 823835795, -354292049);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483617, 'fwsz', 'sup_e31069', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -210159774, 270415200);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483616, '2odwcl5a', 'sup_954d1d', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 292557306, 709097796);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483615, 'yoeyo6l0hdt6', 'sup_7c004c', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1435223075, 1617348603);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483614, '5', 'sup_e31069', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -206528034, -1686002788);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483613, 'boeowii1z5nx', 'sup_954d1d', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1552469358, 7342822);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483612, 'bindz', 'sup_7c004c', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 2085299664, 2038321753);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483611, 'cgumbc', 'sup_e31069', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1295379066, 1071401016);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483610, 'xw1rxe9yfk7', 'sup_954d1d', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1046720861, 643589729);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483609, 'mkio18ri2hy', 'sup_7c004c', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1853955201, -805997097);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483608, 'mzn2mfx', 'sup_e31069', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1243701948, -156175571);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483607, '8sh', 'sup_954d1d', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -63214972, 1106724223);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483606, 'jmgjach', 'sup_a7df33', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1122899168, -161108900);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483605, 'y', 'sup_6cfb58', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1941472821, -2082238979);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483604, 'm5', 'sup_7c004c', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -648564084, -1573704891);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483603, '0xdmsqtge', 'sup_e31069', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1391541536, -1025517017);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483602, 'jq1', 'sup_954d1d', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1584429327, -1575692857);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483601, 'st1', NULL, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 2101986789, 1980131681);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483600, 'm4iz78aqq', NULL, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1370566258, 948460309);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483599, 'r', NULL, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 36589303, -1537647691);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483598, 'h85', NULL, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -609840352, 486475144);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483597, '0kaqtnc', NULL, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 697582781, 428944759);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (1, 'Demi-God');

INSERT INTO "race" ("id", "race") VALUES (-2147483647, 'Demi-God');

INSERT INTO "race" ("id", "race") VALUES (2, 'Demi-God');

INSERT INTO "race" ("id", "race") VALUES (8, 'gd');

INSERT INTO "race" ("id", "race") VALUES (9, 'nd');

INSERT INTO "race" ("id", "race") VALUES (10, 'z');

INSERT INTO "race" ("id", "race") VALUES (11, 'cb98ozk3zbil');

INSERT INTO "race" ("id", "race") VALUES (12, 'wlq7xb');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Demi-God';

/*
Gold Result:
('sup_a7df33',)
('sup_6cfb58',)
('sup_7c004c',)
('sup_e31069',)
('sup_954d1d',)
('sup_7c004c',)
('sup_e31069',)
('sup_954d1d',)
('sup_7c004c',)
('sup_e31069',)
('sup_954d1d',)
('sup_7c004c',)
('sup_e31069',)
('sup_954d1d',)
('sup_7c004c',)
('sup_e31069',)
('sup_954d1d',)
('sup_7c004c',)
('sup_e31069',)
('sup_954d1d',)
('sup_a7df33',)
('sup_6cfb58',)
('sup_7c004c',)
('sup_e31069',)
('sup_954d1d',)
(None,)
(None,)
(None,)
(None,)
(None,)
('sup_a7df33',)
('sup_a7df33',)
*/

-- Prediction Query
SELECT superhero.full_name FROM superhero INNER JOIN race ON superhero.race_id = race.id WHERE race.race = 'Demi-God' LIMIT 5;

/*
Prediction Result:
('sup_a7df33',)
('sup_6cfb58',)
('sup_7c004c',)
('sup_e31069',)
('sup_954d1d',)
*/