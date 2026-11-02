-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (1, 0, 'default1', 'default1', 'Korean', 1, 1, 0, 0, 1, NULL, 1, 1, 'Korean', '%Japanese%', 'default2', '%Japanese%', '2023-01-02', NULL, NULL, NULL), (0, 0, 'default1', 'Korean', '%Japanese%', 0, 0, 0, 0, 0, 'default1', 0, NULL, 'Korean', 'default1', 'default2', NULL, '2023-01-01', 1, 0, 'default1'), (2, 1, 'default1', '%Japanese%', 'default1', 0, 1, 1, 0, 0, 'default2', NULL, 1, NULL, 'default1', '%Japanese%', 'default2', NULL, NULL, NULL, NULL), (3, 0, 'default1', 'Korean', 'default2', 0, 0, 0, 0, 1, NULL, 0, 1, 'Korean', '%Japanese%', '%Japanese%', NULL, '2023-01-01', 0, NULL, NULL), (4, 0, 'default1', 'default1', 'unique_4', 0, 0, 1, 0, 0, 'default1', 0, 1, NULL, 'Korean', 'default1', 'default1', '2023-01-02', 0, 0, NULL), (5, NULL, '%Japanese%', 'default1', 'unique_5', 1, 0, 1, 1, 1, NULL, 0, 1, NULL, 'default2', 'default2', 'default1', '2023-01-02', NULL, NULL, 'Korean'), (6, 1, NULL, NULL, 'unique_6', 0, 1, 0, 1, 1, '%Japanese%', NULL, 1, 'Korean', 'Korean', '%Japanese%', NULL, '2023-01-02', 0, NULL, 'default2');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (0, NULL, '%Japanese%', 'default2'), (1, 'unique_5', 'default1', 'default1'), (2, NULL, 'default1', 'default2'), (3, 'default2', 'Korean', 'Korean'), (4, 'unique_6', 'default1', '%Japanese%'), (5, 'default2', NULL, 'default2'), (6, '%Japanese%', 'default2', 'Korean'), (7, 'default2', 'Korean', NULL), (8, 'default1', 'default1', 'default2'), (9, 'unique_6', 'Korean', 'Korean');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM sets WHERE code IN (SELECT setCode FROM set_translations WHERE language = 'Korean' AND language NOT LIKE '%Japanese%');

/*
Gold Result:
('%Japanese%',)
('%Japanese%',)
*/

-- Prediction Query
SELECT sets.name FROM sets INNER JOIN set_translations ON sets.code = set_translations.setCode WHERE set_translations.language = 'Korean' AND set_translations.language NOT LIKE '%Japanese%';

/*
Prediction Result:
('%Japanese%',)
('%Japanese%',)
('%Japanese%',)
*/