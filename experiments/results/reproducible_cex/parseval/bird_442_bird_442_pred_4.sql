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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (2, 1, 'Masques', '5k5swwqcgs', 't2__9a25a3', 247012447, -1980249628, -734455130, 1744686505, -1633151678, 'a2y', 1115440883, 1644814318, 'sr', 'wbbp6luhvdlt', 'ilbnp', 'mdpos', '2021-06-28', -1602639011, -45536098, 'w6kl');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (3, 1, 'Masques', 'a9', 'code_1', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2024-12-15', -1822992503, -868774469, 'qa1');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -1021749117, '3pyu78d99r', 'jsl', 'O', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f', 176555546, -1937207087, 'vy9uxj4', 'wb', 'v', 'ph2', '2021-03-22', -1264842910, -1052964641, 'qcx5');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, 580968159, 'cprj', 'u0dz7', 'G', 401805964, -1485777725, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk', -155284187, 1686459626, 'lyr', 'kn6vck6ah0f8', 'sww', 'q7x', '2020-03-27', 602161869, 1350414441, 'a7ryfd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (4, -55602865, NULL, 'swwqcgsk', 't1__bcfe01', 1610062532, -106629402, 1871297066, 809183447, 89267185, 'e4', 1160656988, -992890117, 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'ryytoo3', 't2__9a25a3', '9hl7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'klex14ji', 't2__9a25a3', '7zwau2dwyr');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '9000t5c4ec', 't1__bcfe01', 'gce');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '76nium52', 't1__bcfe01', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'qyp5s5bbp0', 't1__bcfe01', '2eutliqa11r');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'ytoo3o9', 't1__bcfe01', 'l7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'klex14ji', 't1__bcfe01', '7zwau2dwyr');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, '13pyu', 't1__bcfe01', '8d99rljsl');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'b4yp5qi', 't1__bcfe01', 'rkf9vqx5');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'pz0f8jegd', 't1__bcfe01', '1vy9uxj4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, 'wb', 't1__bcfe01', 'v');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.baseSetSize, T2.setCode FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.block IN ('Masques', 'Mirage');

/*
Gold Result:
(1, 't2__9a25a3')
*/

-- Prediction Query
SELECT DISTINCT baseSetSize, code FROM sets WHERE block = 'Masques' OR block = 'Mirage';

/*
Prediction Result:
(1, 't2__9a25a3')
(1, 'code_1')
*/