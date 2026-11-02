-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO sets (id, code, name, block, mcmName, mtgoCode, parentCode, keyruneCode) VALUES (1, 'Coldsnap', 'WrongSetName', 'Coldsnap', 'Coldsnap', 'CSP_REAL', 'CSP_REAL', 'CSP_REAL');
INSERT INTO sets (id, code, name, block, mcmName, mtgoCode, parentCode, keyruneCode) VALUES (2, 'CSP_REAL', 'Coldsnap', 'Ice Age', 'OtherName', 'WRONG', 'WRONG', 'WRONG');
INSERT INTO cards (id, uuid, artist, setCode, name, asciiName, faceName) VALUES (1, 'u1', 'Chippy', 'Coldsnap', 'CardA', 'CardA', 'CardA');
INSERT INTO cards (id, uuid, artist, setCode, name, asciiName, faceName) VALUES (2, 'u2', 'WrongArtist', 'CSP_REAL', 'Chippy', 'Chippy', 'Chippy');
INSERT INTO cards (id, uuid, artist, setCode, name, asciiName, faceName) VALUES (3, 'u3', 'Aaron Miller', 'CSP_REAL', 'CardB', 'CardB', 'CardB');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.artist FROM cards AS T1 INNER JOIN sets AS T2 ON T2.code = T1.setCode WHERE (T2.name = 'Coldsnap' AND T1.artist = 'Chippy') OR (T2.name = 'Coldsnap' AND T1.artist = 'Aaron Miller') OR (T2.name = 'Coldsnap' AND T1.artist = 'Jeremy Jarvis') GROUP BY T1.artist;

/*
Gold Result:
('Aaron Miller',)
*/

-- Prediction Query
SELECT DISTINCT artist FROM cards WHERE setcode = 'CSP' AND artist IN ('Jeremy Jarvis', 'Aaron Miller', 'Chippy');

/*
Prediction Result:
*/