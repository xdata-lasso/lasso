-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cards --
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (2, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 't1__44bdf9', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 't1__24aaa9', 'mfg62', 't1__878cf8', '0v', 'boros');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (3, 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 297.258735, 'j5', -1609653472, 172.799686, '5lnpim5k58qs', '7p2r94gt', '2m', 'ajjl', '3', 'okv8uttmu2', -1252009958, 1908593332, 697257217, -451030047, -2052653308, -489120589, -72442907, -2060082151, -1122409769, 1849819405, -929383517, -2090240067, -699574669, 274891948, 609771851, 'j', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 't1__44bdf9', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 't1__24aaa9', 'y', 't1__3c407a', 'yd1jmgjach8', 'boros');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, 'ik1yhb', '8hlst1p', 'qomiztvb6m', 'iz78aqql', 'd8ftb8', '9114q', 'r', '6b', 'jeuuwsj8kj', 114.099596, 'wpxlvris', 2042428747, 852.317741, 'z0kaq', 'ncgc8', '3b7v8', 'kwdmdbdht', 'j47nxar50', 'sj', -1652411404, -553121210, 1720208360, -1243923337, 1231129324, -1782325492, -544173163, -958321297, 2015039199, -641927001, 558684943, -120625031, 572453185, 1348973408, -911953404, '97', 'aqz2o20pj6d', 'dlysu6iphd', 'u2g', 'r31', 'wq51oa', 'sb3uoi1p', 'avcvwnyqroui', 'lrpou', 't63', 'xyfvmjwpp26', 'b3aj', '0ju0h3r133ir', 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 'vjwq49yrnx', '6dvdx', 'o', 'v7t3gvpl', '9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', '1spxpw30', 'g', '?', 'kxginl', '6id');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', 'pe', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', 271.763231, 'sk', 1749319777, 541.094406, 'qg01huij', '7f8kqhiu5g', '8gxb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', -197208169, 2089151689, -561387633, -1496507520, 2062713020, -1725535379, 1709325128, -29488259, -1767802623, 143843552, 1085074663, -1819463450, -2055620484, 1176294340, -1429883874, 'e6', 'ltut6', 'lu2cel8mhfc', 'mn5', 'ni', '0fm', 'bgz5oqxs27', 'h888y1', '253', 'b59ls', '1ehn1mdaqq', 'yy', 'snp64hm', 'nw4m', 'rrwbjk0', 'p', '6g', 'w', '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz', '90nhs', '9gob', '6', 'rn5u', 'phy', 'n', 'a', 'vhvyx8s', 'Q', 'r', 'fs3qn0b');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, 'sad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', 'wnd6dvygw', 'akmwgw73fy3d', 'dip', 'txfbl10qx6j', 509.714753, 'fc75m4s2', 1417859515, 56.296753, '6xuj90te', 'x3', '5u7709', 'qf9lx8qzabi', 'uumwu7', 'l', 618880480, 1930844936, -1674574732, 1874367397, 1342717090, 1100953564, 1125313981, 1124849943, 1147847511, -313392629, -345924605, -693758664, 2045017461, 513178845, -974198226, 'saxe', 'in', 'bciv', 'ojsmeqv3', '3uxdo', 'a0ol1z', 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'dyxk', '0a0cql1c8c', 'wvadbp0760', 'gk2hjz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', 'dlb6i42', 'tew5c29d', 't1havc', 'c4zpw867', 'fve0jf4i', 't99kvnbh', 'i6tp3t', 'nd', 'w89qy', 'sru4eufio', '8o', '6b', 'p9qgjradfhj', '8zr6k53p8e5o', 'f0y', '1u', 'r8kzi0g50j5', '7fznqcuex', 'O', '1faxc1je', '48u5lvdb');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483643, '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'hn75b733', '58zb', 'yx', '0twou', '4', 'yi4h5c4f1q', 582.947646, '43ial8', 196097271, 287.570218, 'j9fodt9k', 'cq2iae6aj6ql', '676lk8q', 'azkjyfxsov', '98', '8', 1633213040, -56395913, 2039485050, -1474782745, 584533120, -1052123830, -1947520594, 970728092, 575216233, 1469886207, -991357557, -263728848, 1905992027, 1646694792, 1349767879, 'y93zu8y', 'b4qpog5smdhc', 'tnj8y6whwhl', '5i', 'dtdjm8r', 'y9lhw6lv7j45', 'k1qzqt5u', '42p20g', 'tfhk1l', 'bjksuye6', 'hvzboodlz60', 'sijufc2vfgh', 'xbu', 'xi', 'lq2is', 'q', '4u2fkzbw', '3q5br3', 'qobvbj26k', 'xc56', 'pvp0h2fln', 'lcorq', 'l1uod', 'v', 'f3ya6l431gf', 'g6', '6gifj', 'vxt41', 'jf1qj3s', '4d', 'pb4l6rurl72q', 'ippxb659q', 'tkf5j4ce', 'y485ys1g', '7p3hvg0', 'ytzip2', 't2__9d930e', 'a6d2hqs4zc1', '2282rnfvk');

-- Inserting into table: foreign_data --
INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483648, 'qta8y3a17v4y', 'ma', -499203870, 'qdpuap96', 'ntdqr', 'm5', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483647, 'wlic7dn2np', '90xdmsqt', -1685482179, 'cuq', '9', 'i9f2ccukjq1q', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483646, 'p61l', 'o3ak162o', -1954048590, 'je', 'vx', 'xlu49ku', '?');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483645, 'o', '8c', -1943810603, 'uekhllbw', 'dpu5v0', 'du', '?');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483644, 'm2rlxcrw', 'x0', 1950697910, 'rzgz84lqme2', 'wb1b3vun66e0', 'mol', 'Q');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483643, '070zi', '0o50q833g', -43429869, '6dpe', 'ew092p', '0u2vil21', 'Q');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483642, '3ceh', 'e3oylci', 1757094915, '0l', '46upleo', 'h3m3q0pq97j', 'O');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483641, '534j5xbk11y', 'pzc7x', -111324604, 'pjjv', 'c2', 'rn6j7', 'O');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (2, 'mfoqp', 'ucnn53i', 178068376, 'qwx0hv', 'v0oh59ivnipn', 'drokt16hq', 't2__9d930e');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (3, '9', 'jae9ps4don', 1940909855, 'b6piqku', 'izi62308npqd', 'bwew42zl4ptf', 't2__9d930e');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483638, 'ul0lw90t2', 'klyapcw1gn', 2032090551, 'r9d3zdayv', 'uhorvccw', 'raqxeddnko4', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483637, 'dq70691b7', 's1i0k8thqz3', 1277292188, '94x3y', 'xg3ufge', 'rz', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483636, 'w0qgiqh4ao3k', '9v09407sw', -158691005, '49kf5l6rnd3r', 'bn', 'bp96', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483635, 'v5122bvxjnuw', '4jm31nfs4', -1152645284, 'u85br297', 'kpjnnbs', 'y75w5', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483634, 'nagrj6o317ka', 'tw7', -1017874103, 'j9f945', 'cwnr8dq', '5gbzjmeuvjv', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483633, 'cr9l03f515y', '8am0qjut2f31', -317767232, 'vk4s7w', 'gg', '0zchdq8o', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (4, '5k5swwqcgs', '9n8', 1610062532, 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (5, 'tti', 'bnp', 1236688122, 'dpos', 'ie5', 'nw6klf', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (6, 'a9000t5c4eci', 'gce376nium52', -443340271, 'uo4nrqrofqy', '5s5b', 'p', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (7, '02eutliqa11r', 'ytoo3o9', -1666765085, '72klex14ji7z', 'au2dwy', 'q13py', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (8, '78d99r', 'jsl', -346339240, 'yp5qi2rk', '9v', 'x58pz', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (9, 'f8jegd2', 'vy9uxj4', -1612443122, 'd', 'lph2gn', 'q', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (10, 'nqcx5h', 'cprj', -841004020, 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', 't1__878cf8');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (11, 'zbilyrkn', '6vck6ah0f8js', -658391922, 'q7x', '7', '2fxa7ryfdrz', 't1__878cf8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name, T1.type FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T2.uuid = T1.uuid WHERE T1.watermark = 'boros';

/*
Gold Result:
('t1__44bdf9', 't1__24aaa9')
*/

-- Prediction Query
SELECT fd.name, fd.type FROM foreign_data AS fd JOIN cards AS c ON fd.uuid = c.uuid WHERE c.watermark = 'boros';

/*
Prediction Result:
('qdpuap96', 'm5')
('cuq', 'i9f2ccukjq1q')
('r9d3zdayv', 'raqxeddnko4')
('94x3y', 'rz')
('49kf5l6rnd3r', 'bp96')
('u85br297', 'y75w5')
('j9f945', '5gbzjmeuvjv')
('vk4s7w', '0zchdq8o')
('pgu7vfe4', 'rwbbp6luhvd')
('dpos', 'nw6klf')
('uo4nrqrofqy', 'p')
('72klex14ji7z', 'q13py')
('yp5qi2rk', 'x58pz')
('d', 'q')
('dz79fjg', 'dqv0gcb98ozk')
('q7x', '2fxa7ryfdrz')
*/