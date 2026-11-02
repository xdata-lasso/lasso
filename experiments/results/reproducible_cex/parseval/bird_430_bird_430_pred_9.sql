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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'Shadowmoor', 'swwqcgsk', 't1__10f0d4', 1610062532, -106629402, 1871297066, 809183447, 89267185, 'e4', 1160656988, -992890117, 'a2ypuzhsrwbb', 'p6luhvdlttil', 't1__b375e4', 'n', '2022-09-14', 1236688122, 2087640001, 'dposiie5unw');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (0, 1408123494, 'Shadowmoor', '4', 'code_2', 374105386, 1274489983, -1683203397, 528680845, -1585009206, '52zb', 757448742, -1179823637, 'rqro', 'fqyp5s5bbp0', 't1__0964f0', '2eutliqa11r', '2024-03-30', -525979501, 1898504886, 'o3o9hl72klex');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 1775126557, 'ji7zwau2', 'dwyrq13pyu78', 'A', 244829661, -1362461264, -904834265, -346339240, 1692174491, 'qi2rkf9v', 556727997, 1178000634, 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', '2022-01-29', 2103044118, -1642259219, 'nd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, 401805964, 'Shadowmoor', 'gq8', '?', -1255130038, -1762857309, 806170397, 513454646, -688216274, 'gcb98ozk3z', 1686459626, -1554531873, 'yrkn6vck6ah0', '8j', 't1__0964f0', 'wwlq7', '2024-02-16', -541746689, 1294666887, 'fdrz16n');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -1496556994, 'i', 'dh5ogrgj', 't2__e68ec6', -458359144, 600440952, 1568069663, -1794176801, -1194675273, 'itsj3', -491938169, -106471771, '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', '2023-06-03', -1284905200, 7929158, '0v');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (1, 'Italian', 't1__10f0d4', 'klfa9000t');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-1, 'Italian', 'A', 'wnqcx');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (0, 'Italian', 'A', '5hncprjtu0d');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Italian', 't2__e68ec6', 'q8qdjpe1');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Italian', 't2__e68ec6', 'o22');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 't2__93270e', 't1__10f0d4', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, NULL, 't1__10f0d4', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 't2__93270e', 't1__10f0d4', '4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 't2__93270e', 't1__10f0d4', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 't2__93270e', 't1__10f0d4', 'e4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 't2__93270e', 't1__10f0d4', 'hria2ypuzhs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 't2__93270e', 't1__10f0d4', 'rwbbp6luhvd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 't2__93270e', 't1__10f0d4', 'tti');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.id FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.block = 'Shadowmoor' AND T2.language = 'Italian' ORDER BY T1.id, T2.id NULLS LAST LIMIT 2;

/*
Gold Result:
('t1__b375e4', 1)
*/

-- Prediction Query
SELECT T1.id, T1.code FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Italian' AND T1.block = 'Shadowmoor' ORDER BY T1.code, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 2;

/*
Prediction Result:
(1, 't1__10f0d4')
*/