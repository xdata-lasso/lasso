-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: device --
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483647, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483646, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483645, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483644, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483643, '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483642, 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483641, 'v', 'ph2', 'nd', 'wnqcx', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483640, '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483639, 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483638, 'xa', '7ryfdrz16n', 'jja', '5dh', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483637, 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483636, 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483635, '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483634, 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483633, 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483632, 'r0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483631, 'r94gth2m', 'ajjl', '3', 'okv8uttmu2', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483630, 'e578', 'fvy', '7zzbe8y', 'kv42q7', NULL);

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483629, 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', NULL);

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483628, 'a9n0jxfofws', 'do2zobb', 'q0k32od', 'cl5ams', NULL);

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483627, 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', NULL);

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483626, '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', NULL);

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483625, '9oaawg', '6aqb0tbin', 'z', '9tajz9td', NULL);

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483624, 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483623, '55', '3dohvu0', 'dza35rmki', '18ri', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483622, 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483621, 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483620, 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483619, 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483618, 'lc', 'qb9i9f', 'ccukjq1q', 'ik1yhb', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483617, '8hlst1p', 'qomiztvb6m', 'iz78aqql', 'd8ftb8', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483616, '9114q', 'r', '6b', 'jeuuwsj8kj', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483615, '85', 'pxlvri', 'surz0kaqtncg', 'c8s3b7v88k', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483614, 'dmdbdh', '6j47n', 'ar50hs', 'han', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483613, 'xdpunmw', 'wx', 'rlawk', '14r5dqt', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483612, 'mg97a', 'z2o20', 'pj6ddlysu6ip', 'dk', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483611, 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483610, 'ouirl', 'rpouit63xyf', 'mjwpp2', 'mb3aj0ju0', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483609, '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483608, '54o6qjektb1', '2', 'zg3r', 'jkwns47j2j', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483607, '8', 'c', 'y', 'vjwq49yr', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483606, 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu', '7k10', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483605, 'z2my1ogyv1r', 'ez', 'x', '1', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483604, 'l', 'upgly78oit', 'xeilpe019cy', 'od033dlhd', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483603, 'vnhed', '9lqv26u3', '1spxpw30', 'g', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483602, 'kxginl', '6id', 'p61l', 'o3ak162o', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483601, 'cagjeevxzxlu', '49kuboe8cd', '4u', 'kh', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483600, 'llbwvdpu5v0e', 'u', 'y9v2z12983', '5xoepacxdb2f', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483599, 'c296xiy', 'et8xjhcf46c', 'pe', 'rxa61sjv8nv', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483598, 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483597, '9q', '2qg01huij', '7f8kqhiu5g', '8gxb', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483596, 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483595, '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483594, 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483593, '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483592, 'mn', 'w4m0', 'rwbjk', 'bph6gdw', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483591, '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483590, '38gfxswb2d0', 'mxwdb7o', 'p5qo1', '4c6', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483589, 'gwnkd4kc3ii', 'axz', '90nhs', '9gob', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483588, '6', 'rn5u', 'phy', 'n', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483587, 'a', 'vhvyx8s', 'r', 'fs3qn0b', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483586, 'm2rlxcrw', 'x0', '3rzgz84lqm', '2w', 'dev_f548c9');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483585, 'b1b3vun66e0i', 'olt0', '0zi90o50q', '33g865zm6', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483584, 'p', 'ewew092p40', '2vil21', 'sad6q5', 'dev_102bbf');

INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (-2147483583, 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', 'dev_102bbf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT software_platform FROM (SELECT LHS.software_platform AS software_platform, LHS.n AS n, RHS.software_platform AS software_platform_other, RHS.n AS n_other FROM (SELECT software_platform, COUNT(*) AS n FROM device GROUP BY software_platform) AS LHS CROSS JOIN (SELECT software_platform, COUNT(*) AS n FROM device GROUP BY software_platform) AS RHS) WHERE (n > n_other) ORDER BY software_platform;

/*
Gold Result:
('dev_102bbf',)
('dev_f548c9',)
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST LIMIT 1;

/*
Prediction Result:
('dev_102bbf',)
*/