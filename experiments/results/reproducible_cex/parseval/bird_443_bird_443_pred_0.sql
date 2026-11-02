-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__1c2d96', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'expansion');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, -1666765085, '72klex14ji7z', 'au2dwy', 't2__45cf5e', -953437896, -1097120355, 244829661, -1362461264, -904834265, 'b4yp5qi', -227162283, 2056419640, 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', 'gndqwnqc', '2024-02-11', 722884590, 580968159, 'expansion');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -1245312912, 'rjtu', 'dz79fjg', 'code_2', -1255130038, -1762857309, 806170397, 513454646, -688216274, 'gcb98ozk3z', 1686459626, -1554531873, 'yrkn6vck6ah0', '8j', 'wwlq7', 'xb72fxa7ryfd', '2023-02-06', 777149609, 61479715, 'expansion');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -598313376, 'q4301jh', 'den8c68x', 'A', 1774087382, 1732258051, -1762140823, 1371234901, -290314193, 'f77pzo72ctd', 481546706, -1784554553, '2g0v5q8qd', 'jpe1io22785', '7cvtjpt', 'tg6bnou5zi', '2025-03-18', -68044929, -1776877925, 'expansion');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 1201273976, 'oacd07z2zez', 'o7w', ']', -542502665, 1999335832, -526612570, -546516406, -405743609, 'g', -20116244, -176606723, '5lnpi', '5k58', 's27p2', '94gth', '2024-12-19', 1162591638, -2136247961, 'la3');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -1122409769, 'u', '3auvm', 'C', 274891948, 609771851, -1934017803, 1105964624, -663234145, 'h', 101754718, 628082526, '9n0jxfofwsz', 'o', '2zobb0q0k32o', 'w', '2020-06-05', 2061558815, 895277769, 'amsorlwyng');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483642, 1468640756, 'boeowii1z5nx', 'h66', '%', -251205568, 287256667, 1614799674, 1083479253, 1774679448, 'oaawg96aq', -2061634386, -850941333, 'indz39tajz', 'td8n5wcgu', 'bc3t', 'u', '2025-09-04', 1295379066, 1071401016, 'w9603vz');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483641, 1510892261, 'y0', '8ftp6ewtqx', '?', 2013745856, 917362079, -1312038093, 687330820, -224390110, 'x7', -1659775598, -891525031, '1cj8', 'h5knz', 'ys7dyyd1jmg', 'jach8qta8y3', '2020-01-22', -735270562, 614314115, 'ma');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'a9000t5c4eci', 't1__1c2d96', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'zbuo4nrqrof', 't1__1c2d96', 'qyp5s5bbp0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, '2eutliqa11r', 't1__1c2d96', 'ytoo3o9');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'jja', 't2__45cf5e', '5dh');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'ogrgjd8y', 't2__45cf5e', 't1afgog');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'itsj3', 't2__45cf5e', 'y');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 'okv8uttmu2', ']', 'e578');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 'fvy', ']', '7zzbe8y');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 'kv42q7', ']', 'x58b4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, '1', 'C', 'j');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483638, '9erhizgk1yoe', 'C', 'o6l0hdt');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483637, 'fuqyxuzkb', 'C', '521gwnlas6e');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483636, 'xw1rxe9yfk7', '%', 'k162n');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483635, '55', '%', '3dohvu0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483634, 'dza35rmki', '%', '18ri');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483633, 'q3qdpua', '?', '96rn');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483632, 'dqrhm', '?', 'wlic7dn2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483631, 'p490', '?', 'dmsqtg');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483630, 'lc', 't2__45cf5e', 'qb9i9f');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483629, 'ccukjq1q', 't2__45cf5e', 'ik1yhb');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483628, '8hlst1p', 't2__45cf5e', 'qomiztvb6m');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483627, 'iz78aqql', 't2__45cf5e', 'd8ftb8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483626, '9114q', 't1__1c2d96', 'r');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483625, '6b', 't1__1c2d96', 'jeuuwsj8kj');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483624, '85', 't1__1c2d96', 'pxlvri');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483623, 'surz0kaqtncg', 't1__1c2d96', 'c8s3b7v88k');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483622, 'dmdbdh', 't1__1c2d96', '6j47n');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483621, 'ar50hs', 't1__1c2d96', 'han');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483620, 'xdpunmw', 't1__1c2d96', 'wx');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483619, 'rlawk', 't1__1c2d96', '14r5dqt');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483618, 'mg97a', 't1__1c2d96', 'z2o20');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '5k5swwqcgs', 't1__1c2d96', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '4', 't1__1c2d96', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'e4', 't1__1c2d96', 'hria2ypuzhs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'rwbbp6luhvd', 't1__1c2d96', 'tti');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'bnp', 't1__1c2d96', 'mdpos');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'ie5', 't1__1c2d96', 'nw6klf');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'a9000t5c4eci', 't1__1c2d96', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'zbuo4nrqrof', 't1__1c2d96', 'qyp5s5bbp0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, '2eutliqa11r', 't1__1c2d96', 'ytoo3o9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.setCode FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.type = 'expansion' GROUP BY T2.setCode;

/*
Gold Result:
('t1__1c2d96',)
('t2__45cf5e',)
*/

-- Prediction Query
SELECT code FROM sets WHERE type = 'expansion';

/*
Prediction Result:
('t1__1c2d96',)
('t2__45cf5e',)
('code_2',)
('A',)
*/