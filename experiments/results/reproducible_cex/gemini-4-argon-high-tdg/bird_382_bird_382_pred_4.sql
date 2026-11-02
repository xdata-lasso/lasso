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
INSERT INTO cards (id, uuid, name, availability) VALUES (1, 'uuid-601', 'Capital Paper Card', 'Paper');
INSERT INTO cards (id, uuid, name, availability) VALUES (2, 'uuid-602', 'Lowercase Language Card', 'paper');
INSERT INTO cards (id, uuid, name, availability) VALUES (3, 'uuid-603', 'Null Availability Card', NULL);
INSERT INTO cards (id, uuid, name, availability) VALUES (4, 'uuid-604', 'Null Language Card', 'paper');
INSERT INTO cards (id, uuid, name, availability) VALUES (5, 'uuid-605', 'Samurai', 'paper');
INSERT INTO cards (id, uuid, name, availability) VALUES (6, 'uuid-606', 'Ninja', 'mtgo');
INSERT INTO cards (id, uuid, name, availability) VALUES (7, 'uuid-607', 'Valid Kamigawa Card', 'paper');
INSERT INTO foreign_data (id, uuid, name, language, multiverseid) VALUES (1, 'uuid-601', '大文字紙', 'Japanese', 6001);
INSERT INTO foreign_data (id, uuid, name, language, multiverseid) VALUES (2, 'uuid-602', '小文字言語', 'japanese', 6002);
INSERT INTO foreign_data (id, uuid, name, language, multiverseid) VALUES (3, 'uuid-603', 'ヌル紙', 'Japanese', 6003);
INSERT INTO foreign_data (id, uuid, name, language, multiverseid) VALUES (4, 'uuid-604', 'ヌル言語', NULL, 6004);
INSERT INTO foreign_data (id, uuid, name, language, multiverseid) VALUES (5, 'uuid-605', 'Samurai', 'English', 6005);
INSERT INTO foreign_data (id, uuid, name, language, multiverseid) VALUES (6, 'uuid-606', 'Samurai', 'Japanese', 6006);
INSERT INTO foreign_data (id, uuid, name, language, multiverseid) VALUES (7, NULL, '孤児データ', 'Japanese', 6007);
INSERT INTO foreign_data (id, uuid, name, language, multiverseid) VALUES (8, 'uuid-607', '有効な神河カード', 'Japanese', 6008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T1.availability = 'paper' AND T2.language = 'Japanese';

/*
Gold Result:
('Valid Kamigawa Card',)
*/

-- Prediction Query
SELECT T1.name FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T1.availability LIKE 'paper' AND T2.language LIKE 'Japanese';

/*
Prediction Result:
('Capital Paper Card',)
('Lowercase Language Card',)
('Valid Kamigawa Card',)
*/