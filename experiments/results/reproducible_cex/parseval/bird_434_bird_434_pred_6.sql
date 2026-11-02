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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 's_s_de1598', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', NULL, 'n', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'A', 373262291, -472966518, -921187550, -2070843029, 328305758, 'tliqa1', 2074205376, 274769912, 'oo3o9', NULL, 'l7', 'klex14ji', '2025-11-18', -453362185, 481163439, '2dwyrq');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -1097120355, '78d99r', 'jsl', 'G', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f', 176555546, -1937207087, 'vy9uxj4', 'wb', 'v', 'ph2', '2021-03-22', -1264842910, -1052964641, 'qcx5');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1748371085, 'q8', 'n2f3dqv0gcb9', 'I', 172461907, 1606439408, 1443629118, -155284187, 1686459626, 'lyr', 1038566008, 32204797, 'k', 'ah0f8jsww', 'q7x', '7', '2024-12-09', 1350414441, 2094425101, '7');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 61479715, 'jja', '5dh', 'O', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 't1afgog', -946046410, -902895762, 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', '2025-10-22', -1099855564, 87529806, 'ctdctmfg62g0');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -241848752, '8507cvtjp', 'ttg6bnou5zi3', 'st__bf1855', -68044929, -1776877925, 1201273976, 1923659053, -1950324754, '7z2zezj', 1448731351, -604098478, 'd5ysxc', NULL, 'r0oz', 'dgj5i', '2025-02-22', -1405314653, 1816660482, 'npi');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'Japanese', 's_s_de1598', '9000t5c4ec');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Japanese', 'G', 'hncprjtu0dz');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'Japanese', 'I', 'yfdrz');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'Japanese', 'O', '5q8qdj');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Japanese', 'O', 'e1io');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Japanese', 'st__bf1855', '5k58');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Japanese', 'st__bf1855', 's27p2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 'st__f624e4', 's_s_de1598', '94gth');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 'Japanese', 's_s_de1598', '2mnajjla3o');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'Japanese', 's_s_de1598', 'v8u');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'tmu2n', 's_s_de1598', '57');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'lfvyz7zzb', 's_s_de1598', '8y');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'kv42q7', 's_s_de1598', 'x58b4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'pmaus3auvmkr', 's_s_de1598', 'pdjwzw5chn9');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'o705', 's_s_de1598', 'a9n0jxfofws');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'do2zobb', 's_s_de1598', 'q0k32od');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'cl5ams', 's_s_de1598', 'orlwyngc1dj');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, '9erhizgk1yoe', 's_s_de1598', 'o6l0hdt');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, 'fuqyxuzkb', 's_s_de1598', '521gwnlas6e');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (13, 'lboeowii1z5', 's_s_de1598', 'xih6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T2.language = 'Japanese' AND (T1.mtgoCode IS NULL OR T1.mtgoCode = '');

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT s.code) FROM sets AS s INNER JOIN set_translations AS st ON s.code = st.setCode WHERE st.language = 'Japanese' AND (s.mtgoCode IS NULL OR s.mtgoCode = '');

/*
Prediction Result:
(2,)
*/