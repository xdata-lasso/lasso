-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: mountain --
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1, 'mou_c75f5c', 1.0, 1.0, 'mou_c4f2fe', 'mou_b362ba');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483647, 'mou_884588', 1.0, 1.0, 'mou_d372af', 'mou_6f4b8f');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483646, 'q_1_4e8a4b', 1.0, 1.0, '5k5swwqcgs', '9n8');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483645, 'q_1_4e8a4b', 1.0, 1.0, '4', 'gu7v');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483644, 'q_1_4e8a4b', 1.0, 1.0, 'e4', 'hria2ypuzhs');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483643, 'q_1_4e8a4b', 1.0, 1.0, 'rwbbp6luhvd', 'tti');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483642, 'q_1_4e8a4b', 1.0, 1.0, 'bnp', 'mdpos');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483641, 'q_1_4e8a4b', 1.0, 1.0, 'ie5', 'nw6klf');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483640, 'q_1_4e8a4b', 1.0, 1.0, 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483639, 'q_1_4e8a4b', 1.0, 1.0, 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483638, 'q_1_4e8a4b', 1.0, 1.0, '2eutliqa11r', 'ytoo3o9');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483637, 'q_1_4e8a4b', 1.0, 1.0, 'l7', 'klex14ji');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483636, 'q_1_4e8a4b', 1.0, 1.0, '7zwau2dwyr', '13pyu');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483635, 'q_1_4e8a4b', 1.0, 1.0, '8d99rljsl', 'b4yp5qi');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483634, 'q_1_4e8a4b', 1.0, 1.0, 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483633, 'q_1_4e8a4b', 1.0, 1.0, '1vy9uxj4', 'wb');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483632, 'q_1_4e8a4b', 1.0, 1.0, 'v', 'ph2');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483631, 'q_1_4e8a4b', 1.0, 1.0, 'nd', 'wnqcx');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483630, 'q_1_4e8a4b', 1.0, 1.0, '5hncprjtu0d', '79fjgq8');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483629, 'q_1_4e8a4b', 1.0, 1.0, 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483628, 'q_1_4e8a4b', 1.0, 1.0, 'kn6vc', '6ah');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (-2147483627, 'q_1_4e8a4b', 1.0, 1.0, 'f8jswwl', '7xb72');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (2, 'xa', 584.342044, 801.438125, 'fdrz16n', 'jja');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (3, '5dh', 488.601669, 781.755052, 'grgj', '8');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (4, 'yzt1afgogrit', 743.920586, 657.87028, '3ay', 'p1q430');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (5, 'jh3den8', 596.764785, 46.611179, '68x8vacx7afu', 'w1of77pz');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (6, '72ct', 51.002063, 803.582738, 'mfg62g0v5q8q', 'j');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (7, 'e1io', 443.690199, 518.274259, '07cvtjpt', 'tg6bnou5zi');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (8, '6c4bfkfo', 12.330671, 774.96573, 'd', '7z2zezj');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (9, '7wgx', 50.798088, 486.564401, 'xcmr0', 'ztdg');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (10, '5i3', 172.799686, 913.609637, 'lnpim5k5', 'qs27p2r94');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (11, 'th', 577.602934, 193.695314, 'ajjl', '3');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (12, 'okv8uttmu2', 208.49371, 497.427028, '8lfvyz7zz', 'be8yvkv42q7');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (13, 'x58b4', 710.005534, 238.668607, 'u', '3auvm');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (14, 'rpd', 144.157236, 677.090643, 'zw5chn', 'mo705a9n0');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (15, 'xfo', 82.48091, 296.34381, 'do2zobb', 'q0k32od');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (16, 'cl5ams', 665.099697, 270.763563, 'yngc1d', 'j9erhizgk1');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (17, 'yoeyo6l0hdt6', 834.163912, 876.568312, 'yxuzk', '5');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (18, '1gwnlas6', 907.723998, 65.338043, 'boe', 'wii1');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (19, '5nxih66', 441.511648, 446.264042, 'lyotow', 'oaawg96aq');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (20, '0', 301.874779, 602.319566, 'ndz', '9tajz9td');

INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (21, 'n5wcgumbc', 714.781282, 619.508764, 'tdu6bd0w', '603vzxw1r');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, height, prominence FROM (SELECT * FROM (SELECT * FROM mountain ORDER BY RANGE DESC, mountain.id NULLS LAST) LIMIT 21);

/*
Gold Result:
('rpd', 144.157236, 677.090643)
('q_1_4e8a4b', 1.0, 1.0)
('yoeyo6l0hdt6', 834.163912, 876.568312)
('cl5ams', 665.099697, 270.763563)
('7wgx', 50.798088, 486.564401)
('q_1_4e8a4b', 1.0, 1.0)
('x58b4', 710.005534, 238.668607)
('n5wcgumbc', 714.781282, 619.508764)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('0', 301.874779, 602.319566)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('mou_884588', 1.0, 1.0)
('mou_c75f5c', 1.0, 1.0)
('72ct', 51.002063, 803.582738)
('5nxih66', 441.511648, 446.264042)
('5i3', 172.799686, 913.609637)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
*/

-- Prediction Query
SELECT name, height, prominence FROM mountain WHERE RANGE <> 'Aberdare Range';

/*
Prediction Result:
('mou_884588', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('q_1_4e8a4b', 1.0, 1.0)
('mou_c75f5c', 1.0, 1.0)
('xa', 584.342044, 801.438125)
('5dh', 488.601669, 781.755052)
('yzt1afgogrit', 743.920586, 657.87028)
('jh3den8', 596.764785, 46.611179)
('72ct', 51.002063, 803.582738)
('e1io', 443.690199, 518.274259)
('6c4bfkfo', 12.330671, 774.96573)
('7wgx', 50.798088, 486.564401)
('5i3', 172.799686, 913.609637)
('th', 577.602934, 193.695314)
('okv8uttmu2', 208.49371, 497.427028)
('x58b4', 710.005534, 238.668607)
('rpd', 144.157236, 677.090643)
('xfo', 82.48091, 296.34381)
('cl5ams', 665.099697, 270.763563)
('yoeyo6l0hdt6', 834.163912, 876.568312)
('1gwnlas6', 907.723998, 65.338043)
('5nxih66', 441.511648, 446.264042)
('0', 301.874779, 602.319566)
('n5wcgumbc', 714.781282, 619.508764)
*/