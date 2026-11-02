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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'Shadowmoor', 'swwqcgsk', 't1__b2b037', 1610062532, -106629402, 1871297066, 809183447, 89267185, 'e4', 1160656988, -992890117, 'a2ypuzhsrwbb', 'p6luhvdlttil', 't1__3cc367', 'n', '2022-09-14', 1236688122, 2087640001, 'dposiie5unw');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-1, 1408123494, 'Shadowmoor', '4', 'A', 374105386, 1274489983, -1683203397, 528680845, -1585009206, '52zb', 757448742, -1179823637, 'rqro', 'fqyp5s5bbp0', 't1__3cc367', '2eutliqa11r', '2024-03-30', -525979501, 1898504886, 'o3o9hl72klex');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (0, 1775126557, 'Shadowmoor', 'ji7zwau2', '_', 364869063, -953437896, -1097120355, 244829661, -1362461264, 'l0b4y', -1116181514, 1255852738, '2rk', '9v', 't1__2a98f7', 'x58pz', '2024-08-06', 836513442, 176555546, 'gd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -283454505, '9uxj4hw', 'd', '@', -736979194, 2103044118, -1642259219, 1298861365, 1968874827, 'nqcx5h', -1245312912, 1575412235, 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', '2023-02-18', 1038566008, 32204797, 'k');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 61479715, 'jja', '5dh', 't2__6acb62', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 't1afgog', -946046410, -902895762, 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', '2025-10-22', -1099855564, 87529806, 'ctdctmfg62g0');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (1, 'Italian', 't1__b2b037', 'klfa9000t');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Italian', '@', 'ah0f8jsww');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'Italian', '@', 'q7x');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'Italian', 'A', '7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Italian', '@', '2fxa7ryfdrz');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'Italian', 't2__6acb62', '5q8qdj');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 'Italian', 't2__6acb62', 'e1io');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 'Italian', 't2__6acb62', '278507cv');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 'Italian', 't2__6acb62', 'jpttg');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 't2__64504a', 't1__b2b037', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, NULL, 't1__b2b037', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 't2__64504a', 't1__b2b037', '4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 't2__64504a', 't1__b2b037', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 't2__64504a', 't1__b2b037', 'e4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 't2__64504a', 't1__b2b037', 'hria2ypuzhs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 't2__64504a', 't1__b2b037', 'rwbbp6luhvd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 't2__64504a', 't1__b2b037', 'tti');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.id FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.block = 'Shadowmoor' AND T2.language = 'Italian' ORDER BY T1.id, T2.id NULLS LAST LIMIT 2;

/*
Gold Result:
('t1__3cc367', -1)
('t1__3cc367', 1)
*/

-- Prediction Query
SELECT sets.id, sets.name FROM sets INNER JOIN set_translations ON sets.code = set_translations.setCode INNER JOIN foreign_data ON set_translations.id = foreign_data.id WHERE foreign_data.language = 'Italian' AND sets.block = 'Shadowmoor' ORDER BY sets.name, sets.id NULLS LAST, set_translations.id NULLS LAST, foreign_data.id NULLS LAST LIMIT 2;

/*
Prediction Result:
*/