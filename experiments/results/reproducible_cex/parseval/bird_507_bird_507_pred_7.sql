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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'st__273dc5', -1865039888, 1160656988, -992890117, 1, 1914020640, 'ypuzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'a9000t5c4eci');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 373262291, 'p5s5bbp', '02eutliqa11r', 'O', 2137741668, -525979501, 1898504886, 1, 624571013, 'o9hl72kl', -305670381, -1525670226, '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', '2025-01-05', -975213201, -705985602, 'x58pz0f8je');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 1196308825, 'd21vy9uxj4hw', 'd', 'A', -736979194, 2103044118, -1642259219, 1298861365, 1968874827, 'nqcx5h', -1245312912, 1575412235, 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', '2023-02-18', 1038566008, 32204797, 'k');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1388029300, 'xb72fxa7r', 'fdrz16n', 'G', -1496556994, -2115841792, 1746373317, 1, 1360271423, 'ogrgjd8y', 1129658414, 1250290042, 'og', 'itsj3', 'y', 'p1q430', '2024-10-12', 518609210, 1948383687, 'e');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -683007527, 'x', 'afu5w1of7', 'I', 76996700, -435350511, 1992637800, 1, -820614248, 't', -1284905200, 7929158, '0v', 'q8qdjpe1', 'o22', '8507cvtjp', '2023-06-01', 453836040, 1467355421, 'ou5z');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -526612570, 'cmr0oz', 'dgj5i', 's_s_c2b45a', -176606723, -15162884, 1339733032, 1, -1556979799, 'k58qs27p', 988954859, -1719383707, '2m', 'ajjl', '3', 'okv8uttmu2', '2022-05-03', -1817527403, -1402164108, 'yz7zzb');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (2, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'st__57c861', -1865039888, 1160656988, -992890117, 1, 1914020640, 'ypuzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'a9000t5c4eci');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'Portuguese (Brazil)', 'st__273dc5', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Portuguese (Brazil)', 'st__273dc5', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'Portuguese (Brazil)', 'A', 'ah0f8jsww');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'Portuguese (Brazil)', 'A', '8c68');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Portuguese (Brazil)', 'A', '36c');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'Portuguese (Brazil)', 'A', 'bfkfoacd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Portuguese (Brazil)', 'st__273dc5', '7z2zezj');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Portuguese (Brazil)', 'st__273dc5', '7wgx');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 'st__f7730d', 'st__273dc5', '5');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'Portuguese (Brazil)', 'st__273dc5', '8y');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483638, 'Portuguese (Brazil)', 'st__273dc5', 'kv42q7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'Portuguese (Brazil)', 'st__57c861', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, NULL, 'st__57c861', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'Portuguese (Brazil)', 'st__57c861', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'Portuguese (Brazil)', 'st__57c861', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'Portuguese (Brazil)', 'st__57c861', '4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'Portuguese (Brazil)', 'st__57c861', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'Portuguese (Brazil)', 'st__57c861', 'e4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN isOnlineOnly = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(id) FROM sets WHERE code IN (SELECT setCode FROM set_translations WHERE language = 'Portuguese (Brazil)');

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN s.isOnlineOnly = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) AS percentage_online_only FROM set_translations AS st JOIN sets AS s ON st.setCode = s.code WHERE st.language = 'Portuguese (Brazil)';

/*
Prediction Result:
(75.0,)
*/