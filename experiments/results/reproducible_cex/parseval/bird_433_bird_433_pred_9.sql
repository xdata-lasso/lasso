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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__a947e4', -1865039888, 1160656988, -992890117, 1, 1914020640, 'ypuzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'a9000t5c4eci');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 743312762, 'eutliqa11r', 'ytoo3o9', 'C', -1666765085, 1178636309, -1390245819, 1, 1055976837, '4ji7zwa', 2123196517, 364869063, 'q13py', '78d99r', 'jsl', 'b4yp5qi', '2025-01-05', -975213201, -705985602, 'x58pz0f8je');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 1196308825, 'd21vy9uxj4hw', 'd', 'A', -736979194, 2103044118, -1642259219, 1298861365, 1968874827, 'nqcx5h', -1245312912, 1575412235, 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', '2023-02-18', 1038566008, 32204797, 'k');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -541746689, '7ryfdrz16n', 'jja', 'G', -7597509, -1625552518, -1738458256, 1, -1714354341, '8', -458359144, 600440952, 'f', 'og', 'itsj3', 'y', '2024-01-17', -106471771, 1235416111, 'jh3den8');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -47052816, '1of77pzo72c', 'dctmf', 'I', 7929158, -1744557630, 1870300798, 1, 820970595, 'qdjpe1io2', 199672698, 2119806856, '7cvtjpttg6b', 'ou5z', '36c', 'bfkfoacd', '2024-08-20', 76987628, -253138337, 'zj');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -526612570, 'cmr0oz', 'dgj5i', 't2__0e8ac7', -176606723, -15162884, 1339733032, 1, -1556979799, 'k58qs27p', 988954859, -1719383707, '2m', 'ajjl', '3', 'okv8uttmu2', '2022-05-03', -1817527403, -1402164108, 'yz7zzb');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'gce376nium52', 't1__a947e4', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Chinese Simplified', 't1__a947e4', 'qyp5s5bbp0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'ah0f8jsww', 'A', 'q7x');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'c68x8vacx7', 'A', 'f');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, '7wgx', 'A', '5');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, '8y', 't2__0e8ac7', 'kv42q7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'x58b4', 't2__0e8ac7', 'pmaus3auvmkr');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 'pdjwzw5chn9', 't1__a947e4', 'o705');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, NULL, 't1__a947e4', 'a9n0jxfofws');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'Chinese Simplified', 't1__a947e4', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'Chinese Simplified', 't1__a947e4', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'Chinese Simplified', 't1__a947e4', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'Chinese Simplified', 't1__a947e4', '4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'Chinese Simplified', 't1__a947e4', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'Chinese Simplified', 't1__a947e4', 'e4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'Chinese Simplified', 't1__a947e4', 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.language = 'Chinese Simplified' AND T1.isOnlineOnly = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.language = 'Chinese Simplified' AND T1.isOnlineOnly = 1 THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(DISTINCT T1.uuid) FROM cards AS T1 JOIN foreign_data AS T2 ON T1.uuid = T2.uuid;

/*
Prediction Result:
(None,)
*/