-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (1, NULL, 'Italian', 'Italian', 'default2', 1, 1, 1, 1, 1, 'Ice Age', NULL, NULL, 'Ice Age', NULL, 'Italian', 'default2', NULL, NULL, 0, NULL), (0, 1, 'Ice Age', 'default2', 'Ice Age', 0, 0, 0, 1, 0, 'default2', 0, 0, 'Italian', 'default2', 'default1', NULL, '2023-01-02', 0, NULL, 'default2'), (2, NULL, 'Ice Age', 'default2', 'Italian', 1, 0, 0, 1, 1, 'Ice Age', NULL, 0, 'default1', 'Italian', 'Ice Age', 'Ice Age', '2023-01-02', 1, 0, 'default2'), (3, NULL, 'Italian', 'default1', 'default1', 1, 1, 0, 0, 0, 'default2', 0, NULL, 'default1', 'default2', NULL, 'default1', NULL, 0, 1, NULL), (4, 0, 'default1', 'Ice Age', 'unique_4', 1, 0, 0, 0, 0, NULL, 1, 0, 'Ice Age', 'Italian', NULL, 'Italian', '2023-01-02', NULL, 1, 'Ice Age'), (5, 1, NULL, 'default1', 'unique_5', 0, 1, 1, 0, 1, 'default1', 1, 1, 'default2', 'Ice Age', NULL, 'Ice Age', '2023-01-02', 1, 0, 'Ice Age'), (6, NULL, 'default1', 'default1', 'unique_6', 0, 1, 0, 1, 0, 'Italian', 0, 1, 'default1', NULL, NULL, 'default2', '2023-01-02', 0, NULL, 'default2'), (7, 1, 'Ice Age', 'Italian', 'unique_7', 1, 0, 1, 1, 0, 'Italian', 1, 1, 'default1', 'Ice Age', 'Italian', 'Italian', NULL, 0, 1, 'Ice Age'), (8, NULL, 'Ice Age', NULL, 'unique_8', 1, 0, 1, 1, 1, NULL, 0, 0, 'Ice Age', 'Ice Age', 'Ice Age', 'default2', '2023-01-01', 0, 1, 'default1'), (9, 0, 'Italian', 'Italian', 'unique_9', 0, 1, 1, 1, 0, 'Ice Age', 0, 0, 'Italian', 'Ice Age', 'default1', 'default2', NULL, 0, 1, 'Ice Age'), (10, NULL, 'Ice Age', 'default1', 'unique_10', 1, 1, 0, 1, 0, 'Ice Age', NULL, 0, NULL, 'default2', 'Ice Age', 'Italian', '2023-01-01', 1, NULL, 'Ice Age'), (11, 0, 'Ice Age', 'Italian', 'unique_11', 0, 0, 0, 1, 0, 'Italian', 1, 0, 'Ice Age', 'default1', NULL, 'Italian', '2023-01-01', 0, 1, 'Italian'), (12, NULL, 'default2', 'default1', 'unique_12', 1, 1, 1, 0, 0, 'Ice Age', 0, NULL, 'Ice Age', NULL, NULL, 'Ice Age', '2023-01-01', 0, 1, NULL), (13, NULL, 'default2', 'Italian', 'unique_13', 0, 1, 0, 1, 1, NULL, 1, NULL, 'default2', 'Ice Age', NULL, 'default2', '2023-01-02', NULL, 1, 'default1'), (14, NULL, 'default1', NULL, 'unique_14', 0, 1, 1, 1, 0, 'Italian', 0, 1, NULL, NULL, 'Italian', 'default1', '2023-01-02', 0, 0, NULL);
INSERT INTO set_translations (id, setcode, language, translation) VALUES (1, 'unique_12', NULL, 'default1'), (0, 'unique_12', 'Ice Age', 'Italian'), (2, 'unique_5', 'Ice Age', NULL), (3, 'default2', 'default1', 'default1'), (4, 'default1', 'default1', NULL), (5, 'unique_6', 'default1', 'Italian'), (6, 'Italian', 'default2', 'Italian'), (7, 'unique_5', 'Ice Age', 'Ice Age'), (8, 'Ice Age', 'Italian', 'Italian'), (9, 'unique_9', 'default1', NULL), (10, 'Italian', 'default2', 'Ice Age'), (11, 'unique_8', 'default2', 'default1'), (12, 'Ice Age', 'Italian', 'default2'), (13, 'unique_7', 'Italian', 'Ice Age'), (14, 'unique_9', 'Ice Age', 'default2'), (15, 'unique_13', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.id) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.block = 'Ice Age' AND T2.language = 'Italian' AND NOT T2.translation IS NULL;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) AS set_count FROM sets INNER JOIN set_translations ON sets.code = set_translations.setCode WHERE sets.block = 'Ice Age' AND set_translations.language = 'Italian' AND NOT set_translations.translation IS NULL;

/*
Prediction Result:
(3,)
*/