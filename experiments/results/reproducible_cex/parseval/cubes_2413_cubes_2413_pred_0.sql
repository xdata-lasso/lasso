-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483647, 'hria2ypu', 1644814318, 'sr', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483646, 'wbbp6luhvdlt', -841692980, 'bnp', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483645, 'mdpos', -1576219117, '5u', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483644, 'w6kl', 1620389964, '00t5c4ecigc', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483643, 'e376nium52', -443340271, 'uo4nrqrofqy', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483642, '5s5b', 2107872094, '02eutliqa11r', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483641, 'ytoo3o9', -1666765085, '72klex14ji7z', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483640, 'au2dwy', -953437896, '3pyu78d', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483639, '9rljsl0b4', 1649269347, 'p5qi2rkf9v', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483638, 'x58pz', -1529584866, 'd2', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483637, 'vy9uxj4', -1612443122, 'd', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483636, 'lph2gn', 1968874827, 'nqcx5h', 'sta_01cbf0', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483635, 'cprj', -841004020, 'dz79fjg', 'sta_01cbf0', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483634, '8n2f3', 806170397, 'qv0gcb98ozk', 'sta_01cbf0', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483633, 'zbilyrkn', -688098735, '6ah', 'sta_41b3cd', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483632, 'f8jswwl', 1255343543, '7', 'sta_41b3cd', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483631, '2fxa7ryfdrz', 61479715, 'jja', 'sta_41b3cd', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483630, '5dh', 1583472758, 'rg', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483629, 'd8y', 1129658414, '1afgo', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483628, 'ri', -902895762, 'ayxp1q43', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483627, '1jh3den', 357330522, '68x8vacx7a', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483626, 'u5', -290314193, 'f77pzo72ctd', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483625, 't', -1284905200, '62', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483624, '0v', 820970595, 'qdjpe1io2', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483623, '78507cvt', -1523347137, 'ttg6bnou5zi3', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483622, 'c4bfkfoac', -406331049, 'ezjo7wg', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483621, 'd5ysxc', -405743609, 'g', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483620, '5i3', -1405314653, '5lnpim5k58qs', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483619, '7p2r94gt', 1273687251, '2mnajjla3o', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483618, 'v8u', 618058035, '2ne578', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483617, 'fvy', -451030047, 'be8yvkv42q7', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483616, 'x58b4', -1122409769, 'u', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483615, '3auvm', 274891948, 'pdjwzw5chn9', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483614, 'o705', 238533676, 'jxfofws', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483613, 'do2zobb', -397848196, '0k32odwcl5a', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483612, 'msorlwyngc', -323362455, 'j9erhizgk1', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483611, 'yoeyo6l0hdt6', 1435223075, 'qyxuzk', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483610, '5', -206528034, 'wn', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483609, 'as6', -2076274980, 'ow', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483608, 'i1z', -564679000, '66', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483607, 'q2xlyoto', 1774679448, 'oaawg96aq', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483606, '0', -850941333, 'indz39tajz', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483605, 'td8n5wcgu', -1275298282, '3', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483604, 'tdu6bd0w96', -379749892, 'vzxw1rxe9y', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483603, 'k7', -1046720861, '162nh55y3d', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483602, 'ohvu06dza3', 1595632888, 'mkio18ri2hy', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483601, '08ftp6ewtqxx', 1664452437, 'jabymzn2mfx7', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483600, '33', 1220047834, '6sto1cj8sh5k', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483599, 'zys7', 1487347213, 'yd1jmgj', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483598, 'c', 973811121, 'ta8y3a17v4', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483597, 'ygmayq3qdpu', 1595033206, '96rn', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483596, 'dqrhm', 555368535, 'ic7', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483595, 'dn2np490xdm', 1996699977, 'tgelc', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483594, 'qb9i9f', -788896327, 'q1q', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483593, 'ik1yhb', 1862728578, 't1pqomiztvb6', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483592, '4iz7', 195316816, 'qlud8', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483591, 'tb', 192271618, '9114qbre6bj', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483590, 'uu', -1451520332, '85', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483589, 'pxlvri', 986268139, 'urz0kaqtncg', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483588, 'c8s3b7v88k', -622923312, 'dbdh', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483587, '6j47n', -556370776, '50hsj', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483586, 'an', 1195320303, 'dpunmw', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483585, 'wx', -1040088060, 'awk', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483584, '14r5dqt', 1298113538, 'g97a', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483583, 'z2o20', -1079009577, 'ddlysu6ip', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483582, 'dk', 658507818, '2gir31vwq5', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483581, 'oa2sb3u', 1388661799, '1pa', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483580, 'cvwnyq', -1005394301, 'uirlrpouit', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483579, '63xyfvmjwpp', 1913338832, '3', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483578, 'j', 960696718, 'u0h', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483577, 'r133ir1a', -569461411, 'hpl2i9e', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483576, 'ap8pg', 1752727653, 'qwt', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483575, 'r54o6', -1042838119, 'kt', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483574, '1', 1464469520, 'nzg3rjkw', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483573, 'ns47j2ja8dc', -1955129162, 'vjwq49yr', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483572, 'nxs6dvdxdo2v', 1805923837, 'plj9fj', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483571, 'uun7k1', -251621840, 'y1ogyv1rgeza', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483570, 'xc1clupgly', 139907579, 'txe', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483569, 'lpe', 1163377746, 'cy7od033d', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483568, 'hds', -690382359, 'ed', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483567, '9lqv26u3', -169055351, 'spxpw30bgwkx', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483566, 'in', -1919229426, '61l2', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483565, 'o3ak162ocagj', 1361395061, 'vx', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483564, 'xlu49ku', -2051917235, '8c', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483563, 'e', 1557266002, 'ekhllb', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483562, 'vdpu5v', -400879450, 'u', 'sta_01cbf0', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483561, 'y9v2z12983', 1870044139, 'oepacx', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483560, 'b', -220327705, 'c296xiy', 'sta_41b3cd', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483559, 'et8xjhcf46c', 312333412, 'erxa61sjv8nv', 'sta_41b3cd', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country_other AS country FROM (SELECT LHS.country AS country, LHS.opening_year AS opening_year, LHS.n AS n, RHS.country AS country_other, RHS.opening_year AS opening_year_other, RHS.n AS n_other FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS LHS CROSS JOIN (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS RHS) WHERE (n < n_other) ORDER BY country;

/*
Gold Result:
(None,)
('sta_01cbf0',)
('sta_41b3cd',)
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('sta_01cbf0',)
*/