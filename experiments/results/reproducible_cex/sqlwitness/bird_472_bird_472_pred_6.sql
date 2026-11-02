-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (1, 1, 'Italian', 'default2', 'default2', 0, 1, 0, 1, 1, 'default1', 0, 1, 'Italian', 'Ice Age', 'default1', 'default1', '2023-01-01', NULL, 1, 'Ice Age'), (0, NULL, 'default1', 'Italian', 'Italian', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, 'default1', NULL, NULL, '2023-01-02', NULL, 1, NULL), (2, 1, 'Italian', NULL, 'default1', 0, 1, 1, 0, 0, NULL, 1, 1, 'Italian', 'default1', NULL, 'default2', NULL, NULL, 0, NULL), (3, 1, 'Italian', 'default2', 'Ice Age', 1, 1, 1, 1, 0, 'default2', 1, 0, NULL, 'default1', 'default2', 'Ice Age', NULL, NULL, NULL, NULL), (4, NULL, NULL, 'Italian', 'unique_4', 0, 0, 1, 1, 0, 'default2', NULL, 0, 'default2', NULL, 'default2', 'Italian', '2023-01-01', 0, 1, 'default1'), (5, 0, 'default1', NULL, 'unique_5', 0, 1, 1, 1, 0, NULL, 1, 1, NULL, 'default1', NULL, 'Italian', NULL, 1, NULL, 'Ice Age'), (6, 0, 'Italian', 'Ice Age', 'unique_6', 0, 1, 1, 1, 0, NULL, NULL, 1, 'Ice Age', 'default2', 'default1', NULL, NULL, 1, 1, NULL), (7, 1, 'Italian', NULL, 'unique_7', 0, 0, 1, 0, 1, 'Ice Age', 1, NULL, 'Italian', NULL, 'default1', 'Italian', '2023-01-02', 1, 1, 'default2'), (8, 0, NULL, 'default2', 'unique_8', 0, 1, 0, 1, 1, 'default2', NULL, 1, 'Italian', NULL, NULL, NULL, '2023-01-01', 0, 0, NULL), (9, 1, 'Ice Age', NULL, 'unique_9', 1, 0, 1, 0, 1, 'Italian', NULL, NULL, 'Italian', NULL, NULL, 'Ice Age', '2023-01-02', NULL, 0, 'Italian'), (10, NULL, 'Italian', 'Ice Age', 'unique_10', 0, 0, 0, 0, 1, 'Italian', 0, NULL, 'Ice Age', 'default1', 'Ice Age', 'Ice Age', '2023-01-02', 0, 1, 'default1'), (11, 1, 'Ice Age', 'Italian', 'unique_11', 0, 0, 0, 1, 0, 'default1', 0, 0, NULL, 'Ice Age', 'default2', 'default1', '2023-01-01', 1, 0, 'Ice Age'), (12, 1, 'default2', 'Italian', 'unique_12', 1, 0, 0, 1, 1, 'Italian', 1, NULL, 'default2', NULL, NULL, 'Ice Age', '2023-01-02', NULL, 1, 'default2'), (13, NULL, 'Italian', 'default1', 'unique_13', 0, 1, 0, 0, 1, 'Ice Age', NULL, 1, 'default1', 'default2', 'default2', NULL, NULL, 0, NULL, 'default2'), (14, NULL, 'Italian', NULL, 'unique_14', 1, 0, 0, 0, 1, 'default2', 0, NULL, 'default1', NULL, 'Italian', NULL, '2023-01-01', NULL, NULL, 'Ice Age'), (15, NULL, 'default1', 'Italian', 'unique_15', 0, 0, 0, 1, 0, 'default1', NULL, 0, 'Ice Age', NULL, 'default1', 'default2', '2023-01-02', 1, 1, 'Italian');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (1, 'unique_14', NULL, 'Italian'), (0, 'Italian', 'default2', 'Ice Age'), (2, 'unique_9', 'Italian', 'Italian'), (3, 'unique_6', 'default1', 'Italian'), (4, 'unique_9', 'default1', NULL), (5, 'unique_5', 'Ice Age', NULL), (6, NULL, 'Ice Age', NULL), (7, 'Ice Age', 'Ice Age', 'default2'), (8, 'unique_9', 'Italian', 'default2'), (9, 'unique_13', NULL, 'default2'), (10, 'unique_15', 'default2', 'default2'), (11, 'Ice Age', 'Ice Age', 'default2'), (12, 'Ice Age', 'default2', 'Italian');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.id) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.block = 'Ice Age' AND T2.language = 'Italian' AND NOT T2.translation IS NULL;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) AS count FROM sets AS s INNER JOIN set_translations AS st ON s.code = st.setCode WHERE s.block = 'Ice Age' AND st.language = 'Italian' AND NOT st.translation IS NULL;

/*
Prediction Result:
(2,)
*/