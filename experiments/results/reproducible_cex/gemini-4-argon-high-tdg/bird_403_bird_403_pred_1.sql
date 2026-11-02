-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO cards (id, name, uuid) VALUES (1, 'Lightning Bolt', 'uuid-card-1');
INSERT INTO cards (id, name, uuid) VALUES (2, 'Counterspell', 'uuid-card-2');
INSERT INTO cards (id, name, uuid) VALUES (3, 'Dark Ritual', 'uuid-card-3');
INSERT INTO cards (id, name, uuid) VALUES (4, 'Giant Growth', 'uuid-card-4');
INSERT INTO foreign_data (id, language, multiverseid, name, text, type, uuid) VALUES (1, 'Spanish', 1001, 'Relámpago', 'Hace 3 puntos de daño.', 'Instantáneo', 'uuid-card-1');
INSERT INTO foreign_data (id, language, multiverseid, name, text, type, uuid) VALUES (2, 'Spanish', 1002, 'Contrarrestar', 'Contrarresta el hechizo objetivo.', 'Instantáneo', 'uuid-card-2');
INSERT INTO foreign_data (id, language, multiverseid, name, text, type, uuid) VALUES (3, 'French', 1003, 'Foudre', 'La Foudre inflige 3 blessures.', 'Éphémère', 'uuid-card-1');
INSERT INTO sets (id, code, name) VALUES (1, 'LEA', 'Limited Edition Alpha');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'Spanish', 'LEA', 'Edición Limitada Alfa');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (SELECT CAST(SUM(CASE WHEN language = 'Spanish' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM foreign_data), name FROM foreign_data WHERE language = 'Spanish';

/*
Gold Result:
(66.66666666666667, 'Relámpago')
(66.66666666666667, 'Contrarrestar')
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN fd.language = 'Spanish' THEN fd.uuid ELSE NULL END) AS REAL) * 100.0 / COUNT(fd.uuid) AS percentage, c.name FROM foreign_data AS fd JOIN cards AS c ON fd.uuid = c.uuid GROUP BY c.name ORDER BY c.name, percentage NULLS LAST;

/*
Prediction Result:
(100.0, 'Counterspell')
(50.0, 'Lightning Bolt')
*/