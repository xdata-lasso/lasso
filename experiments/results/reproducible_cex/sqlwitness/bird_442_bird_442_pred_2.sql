-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (1, 0, NULL, 'Masques', 'Masques', 1, 1, 1, 0, 0, 'Masques', 0, 0, 'default1', NULL, 'Masques', NULL, '2023-01-01', 0, 1, 'default1'), (0, NULL, 'Masques', NULL, 'default2', 1, 0, 0, 1, 0, 'Mirage', 1, NULL, 'default2', NULL, 'default1', 'default1', '2023-01-01', 1, NULL, 'default1'), (2, 1, NULL, 'default1', 'Mirage', 0, 1, 1, 0, 0, NULL, 0, 1, 'Mirage', 'Mirage', NULL, 'Masques', '2023-01-02', 0, 1, 'Masques'), (3, 1, 'Masques', 'default2', 'default1', 1, 1, 0, 0, 1, 'default1', 1, NULL, 'Mirage', NULL, NULL, NULL, '2023-01-02', 0, 1, 'Mirage'), (4, 0, 'Mirage', 'Mirage', 'unique_4', 1, 1, 0, 1, 1, 'default2', 0, 0, 'default1', 'default2', 'default1', 'default1', '2023-01-02', 0, 0, 'Masques'), (5, NULL, 'Masques', NULL, 'unique_5', 1, 1, 1, 0, 1, NULL, 0, NULL, 'Masques', 'Mirage', 'default1', 'default1', NULL, 0, 0, 'Masques'), (6, NULL, 'default1', 'Masques', 'unique_6', 1, 0, 1, 0, 1, NULL, NULL, NULL, 'default2', 'Masques', 'Masques', 'default1', '2023-01-01', 1, 0, 'Mirage');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (1, 'default2', 'default1', 'Masques'), (0, 'unique_4', NULL, 'default1'), (2, 'unique_4', 'Mirage', 'default1'), (3, 'Mirage', NULL, 'Masques'), (4, 'default1', 'default1', 'Masques'), (5, 'default1', 'Mirage', 'Mirage');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.baseSetSize, T2.setCode FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.block IN ('Masques', 'Mirage');

/*
Gold Result:
(0, 'unique_4')
(None, 'default2')
(1, 'default1')
*/

-- Prediction Query
SELECT baseSetSize, code FROM sets WHERE block IN ('Mirage', 'Masques');

/*
Prediction Result:
(None, 'default2')
(1, 'default1')
(0, 'unique_4')
(None, 'unique_5')
*/