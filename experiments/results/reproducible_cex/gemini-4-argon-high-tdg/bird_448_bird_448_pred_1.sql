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
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, type, originalType, types, subtypes, supertypes, watermark) VALUES (1, 'uuid-abzan-1', 'Anafenza, the Foremost', 'Anafenza the Foremost', 'Anafenza Face', 'Anafenza Flavor', 'Legendary Creature — Human Soldier', 'Summon Soldier', 'Creature', 'Human Soldier', 'Legendary', 'abzan');
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, type, originalType, types, subtypes, supertypes, watermark) VALUES (2, 'uuid-abzan-no-foreign', 'Ivorytusk Fortress', 'Ivorytusk Fortress', 'Ivorytusk Face', 'Ivorytusk Flavor', 'Creature — Elephant', 'Creature', 'Creature', 'Elephant', NULL, 'abzan');
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, type, originalType, types, subtypes, supertypes, watermark) VALUES (3, 'uuid-jeskai-1', 'Mantis Rider', 'Mantis Rider', 'Mantis Face', 'Mantis Flavor', 'Creature — Human Monk', 'Creature', 'Creature', 'Human Monk', NULL, 'jeskai');
INSERT INTO foreign_data (id, uuid, name, type, language, flavorText, text, multiverseid) VALUES (1, 'uuid-jeskai-1', 'Cavalier mante', 'Créature : humain et moine', 'French', 'Jeskai flavor', 'Flying, vigilance, haste', 386589);
INSERT INTO foreign_data (id, uuid, name, type, language, flavorText, text, multiverseid) VALUES (10, 'uuid-abzan-1', 'Anafenza, la toute première', 'Créature légendaire : humain et soldat', 'French', 'Abzan flavor FR', 'Whenever Anafenza attacks...', 386476);
INSERT INTO foreign_data (id, uuid, name, type, language, flavorText, text, multiverseid) VALUES (11, 'uuid-abzan-1', 'Anafenza, die Erste', 'Legendäre Kreatur — Mensch, Soldat', 'German', 'Abzan flavor DE', 'Immer wenn Anafenza angreift...', 386477);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name, T1.type FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T2.uuid = T1.uuid WHERE T1.watermark = 'abzan';

/*
Gold Result:
('Anafenza, the Foremost', 'Legendary Creature — Human Soldier')
*/

-- Prediction Query
SELECT foreign_data.name AS foreign_name, foreign_data.type AS card_type FROM cards INNER JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE cards.watermark = 'abzan';

/*
Prediction Result:
('Anafenza, la toute première', 'Créature légendaire : humain et soldat')
('Anafenza, die Erste', 'Legendäre Kreatur — Mensch, Soldat')
*/