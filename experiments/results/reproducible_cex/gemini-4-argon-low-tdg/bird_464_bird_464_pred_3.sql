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
INSERT INTO sets (id, code, name) VALUES (1, '10E', 'Tenth Edition');
INSERT INTO sets (id, code, name) VALUES (2, '9ED', 'Ninth Edition');
INSERT INTO sets (id, code, name) VALUES (3, 'M10', 'Magic 2010');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (10, 'German', '10E', 'Hauptset Zehnte Edition');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (20, 'French', '10E', 'Dixième édition');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (30, 'German', '9ED', 'Neunte Edition');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, setCode, uuid) VALUES (100, 'Plains', 'Plains_ascii', 'Plains_face', 'Plains_flavor', '10E', 'uuid-1');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, setCode, uuid) VALUES (101, 'Plains', 'Plains_ascii2', 'Plains_face2', 'Plains_flavor2', '10E', 'uuid-2');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, setCode, uuid) VALUES (102, 'Island', 'Island_ascii', 'Island_face', 'Island_flavor', '10E', 'uuid-3');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, setCode, uuid) VALUES (103, 'Mountain', 'Mountain_ascii', 'Mountain_face', 'Mountain_flavor', '9ED', 'uuid-4');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, setCode, uuid) VALUES (104, 'Forest', 'Forest_ascii', 'Forest_face', 'Forest_flavor', 'M10', 'uuid-5');
INSERT INTO foreign_data (id, language, name, uuid) VALUES (1, 'German', 'Hauptset Zehnte Edition', 'uuid-4');
INSERT INTO foreign_data (id, language, name, uuid) VALUES (2, 'German', 'Ebene', 'uuid-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM cards AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.setCode WHERE T2.translation = 'Hauptset Zehnte Edition';

/*
Gold Result:
('Island',)
('Plains',)
*/

-- Prediction Query
SELECT T2.name FROM set_translations AS T1 INNER JOIN cards AS T2 ON T1.setCode = T2.setCode WHERE T1.translation = 'Hauptset Zehnte Edition';

/*
Prediction Result:
('Island',)
('Plains',)
('Plains',)
*/