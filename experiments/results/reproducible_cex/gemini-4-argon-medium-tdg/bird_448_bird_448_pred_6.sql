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
INSERT INTO "cards" (id, uuid, name, type, asciiName, faceName, flavorName, originalType, types, subtypes, supertypes, watermark) VALUES (1, 'uuid-1', 'Abzan Ascendancy', 'Enchantment', 'Abzan Ascendancy_ascii', 'Abzan_face', 'Abzan_flavor', 'Enchantment_orig', 'Enchantment_types', 'Sub_1', 'Super_1', 'abzan');
INSERT INTO "cards" (id, uuid, name, type, asciiName, faceName, flavorName, originalType, types, subtypes, supertypes, watermark) VALUES (2, 'uuid-2', 'Abzan Ascendancy', 'Enchantment', 'Abzan Ascendancy_ascii_2', 'Abzan_face_2', 'Abzan_flavor_2', 'Enchantment_orig_2', 'Enchantment_types_2', 'Sub_2', 'Super_2', 'abzan');
INSERT INTO "cards" (id, uuid, name, type, watermark) VALUES (3, 'uuid-3', 'Abzan Ascendancy', 'Creature — Human Soldier', 'abzan');
INSERT INTO "cards" (id, uuid, name, type, watermark) VALUES (4, 'uuid-4', 'Anafenza, the Foremost', 'Creature — Human Soldier', 'abzan');
INSERT INTO "foreign_data" (id, uuid, name, type, language) VALUES (1, 'uuid-1', 'Aszendenz der Abzan', 'Verzauberung', 'German');
INSERT INTO "foreign_data" (id, uuid, name, type, language) VALUES (2, 'uuid-1', 'Ascendance abzan', 'Enchantement', 'French');
INSERT INTO "foreign_data" (id, uuid, name, type, language) VALUES (3, 'uuid-2', 'Ascendencia abzana', 'Encantamiento', 'Spanish');
INSERT INTO "foreign_data" (id, uuid, name, type, language) VALUES (4, 'uuid-3', 'Abzan Creature FD', 'Creature FD', 'Italian');
INSERT INTO "foreign_data" (id, uuid, name, type, language) VALUES (5, 'uuid-4', 'Anafenza FD', 'Legendary Creature FD', 'Japanese');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name, T1.type FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T2.uuid = T1.uuid WHERE T1.watermark = 'abzan';

/*
Gold Result:
('Abzan Ascendancy', 'Enchantment')
('Abzan Ascendancy', 'Creature — Human Soldier')
('Anafenza, the Foremost', 'Creature — Human Soldier')
*/

-- Prediction Query
SELECT T1.name, T2.type FROM foreign_data AS T1 INNER JOIN cards AS T2 ON T1.uuid = T2.uuid WHERE T2.watermark = 'abzan';

/*
Prediction Result:
('Aszendenz der Abzan', 'Enchantment')
('Ascendance abzan', 'Enchantment')
('Ascendencia abzana', 'Enchantment')
('Abzan Creature FD', 'Creature — Human Soldier')
('Anafenza FD', 'Creature — Human Soldier')
*/