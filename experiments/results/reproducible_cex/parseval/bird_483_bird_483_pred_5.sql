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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 's_s_5636e6', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'c_s_8ded51', 'q8qdjpe1', 'o22');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483647, '3', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 191.1711, '705a', -1245584612, 903.226183, 'fofwsz', 'o', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', -323362455, 453340472, 211603887, -413043724, 761519897, 1504707292, 955267863, -1156828895, 1483450542, 513375398, 718167481, 1428194830, -1614619556, 1435223075, 1617348603, 'yxuzk', '5', '1gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 's_s_5636e6', 'ma', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 'c_s_39c69f', 'qb9i9f', 'ccukjq1q');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, '0ju0h3r133ir', 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 'vjwq49yrnx', 294.236852, '6dvdxdo2v7', 1805923837, 337.06993, 'j9f', 'vuu', '7k10', 'z2my1ogyv1r', 'ez', 'x', -316078323, -754769711, 1128553504, 1374917235, -563920971, 1484825817, 1009703228, 1163377746, 227939734, -1164657946, 693108667, -1882121644, 935816178, -1919535047, -690382359, 'ed', '9lqv26u3', '1spxpw30', 'g', 'kxginl', '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', '4u', 'kh', 'llbwvdpu5v0e', 'u', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', 'pe', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', '2qg01huij', '7f8kqhiu5g', 's_s_5636e6', '8gxb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'O', 'kvee', 'sltut6lu2');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 273.359912, 'wbjk0bph6gd', -616998913, 524.111747, 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', 'mxwdb7o', 'p5qo1', 749598659, 902707245, -1449454815, 514764200, 1993999044, 825979697, -1565247126, -419727501, -1220824615, -888694642, 1611539964, 700001068, -2045499093, 38014553, 1144243962, '5ujp', 'yb', 'aayv', 'hvyx8scr0fs3', 'qn0b5m2rlxcr', 'fx03rz', 'z8', 'lqme2wb1', '3', 'un66e0', 'mol', '070zi', '0o50q833g', '865zm6dpewew', '092p40u2vi', 'l21xsad6q5z', 'qoa', 'uy023lwh99', 'fqc1m9gr', 'xjqbloxd4', 'j5il9', 'nd6dvy', 'gwakmwgw73f', '3dkdipt', 'fbl10q', '6j6d4f', 'c75m4s2ajdu2', '6xuj90tefx', 'u5u7709q', '9l', '8qzabi', 'uumwu7', 'l', '0jw', '6hh', 'oe79350f', 'A', 'zrv1ll930xvk', 'viql6n0rlp');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, '760ugk2', 'jz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', 'dlb6i42', 'tew5c29d', 't1havc', 792.049687, '4', -429097391, 355.299179, '72fve0jf4', '5t9', '9kvnbhvi6t', '3tfn', 'dtw89qy6sru4', 'uf', -1588383617, 2062633134, 183049515, 1796323549, -1022360195, -1517836823, -2124619836, -1746125330, 765163181, 24627578, 2033421216, 794301748, 376872332, -23658516, -1799118529, 'f1ur8kz', '0g5', '0j597fznqc', 'ex41fa', 'c1je44', 'u5lvdbp3c', 'hy', '3o', 'lciif0l', '46upleo', 'h3m3q0pq97j', '534j5xbk11y', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'hn75b733', '58zb', 'yx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 's_s_5636e6', 'sp4j9fod', 't9kcq2iae6', 'j', 'ql1676lk8', 'azkjy', 'fxsove98b8', '0235v8ik', '3qu7', 'G', 'cxswgr124', 'u6v8hk');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (2, 'j', 'suy', '6h', 'zboodl', '60sijuf', 'c2vfghixbugx', 'slq', 'isdq44u2', 'kz', 30.619415, '3q5br3', -1007920797, 976.385144, 'v', 'j', '26kpxc567p', 'vp0h2flntlco', 'qtl1u', 'dbvf', -534387926, 949206609, 1790641668, -286729739, 322498251, -1841006453, 33100532, 56216130, 1385394884, 1792401890, -585058868, -96878107, 1620531975, -1048787950, -190180302, '4d', 'pb4l6rurl72q', 'ippxb659q', 'tkf5j4ce', 'y485ys1g', '7p3hvg0', 'ytzip2', 'a6d2hqs4zc1', '2282rnfvk', 'mfoqp', 'ucnn53i', '8owqwx0hv', 'v0oh59ivnipn', 'drokt16hq', '9', 'jae9ps4don', 'e0b6piqkuizi', '2308npqdb', 'wew42zl4ptf8', 'l0lw90', '2klya', 'cw1g', 'o6r9', '3', 'dayv5uh', 'rvcc', 'wraqxeddnko4', 'c_s_137b79', 'dq70691b7', 's1i0k8thqz3', 's94x3', 'yxg3ufg', 'efrzw0qgiqh4', 'o', 'k79v0940', '7swb3349kf', 'I', '5l6rnd3rhb', 'nmbp96v512');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483642, 'r1', 'luvk4s7', 'ggg30z', 'h', 'dq8orxze42', 'wen', '4ilc', 'kspw6gvo', 'c9l5zmrsv64', 428.710511, '6b', 1820491976, 711.4587, 't8', 'gqofzr1', 'v7z6i', 'r1w', 'x1', 'l', -418713192, -2050843803, -468630612, -795681473, -470061601, -630712619, 1533864667, -1614519539, 2028167237, 1313061607, -1860262488, -192376676, 996081640, -1871398938, -1251117933, 'cn', 't2v4lraxg0g', 'xot6v', '1lrh', 'qsxyubeyhmlr', 'ycz8', '5', 'kabtcpo', '1ke8euy0kcx', '8e4', 'bkfphyyxnm', 'cmn8usy', 'c1vk27ki', 'uvof5ndg', '80z', 'qe9rs1z82tw', '4o1sqir', 'hj1', 'xi', 'o9km29vphx5v', '7jo', 'y', '1skvh4q', 'y4gp', '0kr5bk0d0gkg', 'qavutce54k', 'dvf12j4ljl', 's_s_5636e6', 'hxdpnhebny', 'a', 'xtpyee2zt2', 'gy7qnk', 'j2dsjla91nq', '7dxug9rta6w', 'n', 'l7a', 'fd__78ccc3', 'q6gahjc', '84vxo5');

-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -1950324754, '7z2zezj', '7wgx', 's_s_5636e6', -57705450, -915385605, -2005628382, 1721638020, 983324983, 'ztdg', -20116244, -176606723, '5lnpi', '5k58', 'Coldsnap', 's27p2', '2023-01-31', -95808609, -244633520, 'ajjl');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, -55270062, 'xlvr', 'sur', 's_s_27c642', -459075802, -1472584267, 1384307628, 1388796595, -881085433, '7', 438933248, 180947503, 'dmdbdh', '6j47n', 'Coldsnap', 'ar50hs', '2021-08-25', -1652411404, -553121210, 'punmwfwxqrl');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 1928920679, 'ysu', 'iphdku2gi', 'O', 1113005977, -176968915, -717865822, 2061102304, -1204806277, 'sb3uoi1p', -1971610898, 2095277250, 'qrouirl', 'rpouit63xyf', 'Coldsnap', 'mjwpp2', '2025-09-01', 1913338832, -2061050846, 'j');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, 133794777, '404qpp3303a1', 'gqut', 'G', 898805626, -77974859, -619092341, -1908406235, 2142421496, 'zpd', 842122481, 1791555361, '0a0', 'q', 'Coldsnap', '1c8', '2020-06-06', -656017519, -2126129717, 'p');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -992513509, '71kpjnnbs', 'y75w5', 'c_s_137b79', 910724149, -1204936978, 86045378, -2108769643, 98755104, 'iuj9f', -113579338, -1983237870, 'r8dq', '5gbzjmeuvjv', 'Coldsnap', 'cr9l03f515y', '2020-01-16', -378968125, 1092973308, 't2f316');

-- Inserting into table: foreign_data --
INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483648, '8507cvtjp', 'Italian', 1582582341, 'tg6bnou5zi', 'fd__075dcb', '6c4bfkfo', 'c_s_8ded51');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (2, 'ik1yhb', 'Italian', 1862728578, 't1pqomiztvb6', 'fd__075dcb', '4iz7', 'c_s_8ded51');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (3, 'aqqlud8ft', 'Italian', 1183069552, '4qbre6b', 'fd__075dcb', 'jeuuwsj8kj', 'c_s_8ded51');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483645, 'w', 'Italian', -1439417265, '14r5dqtsmg97', 'fd__075dcb', 'aqz2o20pj6d', 'c_s_8ded51');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483644, 'saxeeinmbc', 'Italian', -1598084888, 'ojsmeqv3', 'fd__075dcb', '3uxdo', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483643, 'a0ol1z', 'Italian', 1006498753, 'rss', 'fd__075dcb', 'h', 'c_s_8ded51');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483642, 'lzy93zu8yb', 'Italian', 956649820, 'qpog5smdhc', 'fd__075dcb', 'tnj8y6whwhl', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483641, '5i', 'Italian', -270264442, 'djm8r', 'fd__075dcb', 'y9lhw6lv7j45', 'c_s_8ded51');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483640, 'k1qzqt5u', 'Italian', -665597852, 'p20gwtfh', 'fd__075dcb', '1l3', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483639, 'bvxjnuw8', 'Italian', -84497692, '31nf', 'fd__075dcb', 's4niom2u85b', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483638, 'ddfra', 'Italian', 946754934, '0lwc', 'fd__075dcb', 'duqt0ig', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483637, '197gelrrul', 'Italian', -616668672, 'htk', 'fd__075dcb', 't', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483636, 'og8ol79cnlv', 'Italian', 851083562, 'pkcpw0q', 'fd__075dcb', 'z43yul6g2', 'c_s_8ded51');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483635, 'jlkkggqx', 'fd__3c8b59', 646367725, 'wfnbop1', 'fd__075dcb', '64a9g9nw1', 'c_s_8ded51');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483634, 'bb6teckai', 'Italian', -1152773938, 'mpzf5tuls', NULL, 'ok6vhgc3b0v', 'c_s_8ded51');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (4, '5k5swwqcgs', NULL, 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 'c_s_39c69f');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (5, 'luhvdltti', 'Italian', -1364429300, 'nprmdposii', '5u', 'w6kl', 'c_s_39c69f');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (6, 'a9', 'Italian', 1620389964, '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'c_s_39c69f');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (7, 'qyp5s5bbp0', 'Italian', 743312762, 'eutliqa11r', 'ytoo3o9', 'l7', 'c_s_39c69f');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (8, 'klex14ji', 'Italian', -453362185, 'au2dwyrq13', 'yu78', '9', 'c_s_39c69f');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (9, 'rljsl0b4y', 'Italian', -1116181514, 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', 'c_s_39c69f');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (10, 'j4hwbdvlph', 'Italian', -261132974, 'dqwn', 'cx5hn', 'p', 'c_s_39c69f');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (11, 'jtu0d', 'Italian', 401805964, 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'c_s_39c69f');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (12, 'kn6vc', 'Italian', 1784916884, 'ah0f8jsww', 'q7x', '7', 'c_s_39c69f');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.text FROM foreign_data AS T1 INNER JOIN cards AS T2 ON T2.uuid = T1.uuid INNER JOIN sets AS T3 ON T3.code = T2.setCode WHERE T3.name = 'Coldsnap' AND T1.language = 'Italian';

/*
Gold Result:
('fd__075dcb',)
(None,)
('5u',)
('e376nium52',)
('ytoo3o9',)
('yu78',)
('vqx58pz0f',)
('cx5hn',)
('n2f3dqv0gcb9',)
('q7x',)
*/

-- Prediction Query
SELECT fd.text FROM sets AS s INNER JOIN cards AS c ON c.setcode = s.code INNER JOIN foreign_data AS fd ON fd.uuid = c.uuid WHERE s.name = 'Coldsnap' AND fd.language = 'Italian';

/*
Prediction Result:
('fd__075dcb',)
('fd__075dcb',)
('fd__075dcb',)
('fd__075dcb',)
('fd__075dcb',)
(None,)
('fd__075dcb',)
('fd__075dcb',)
('5u',)
('e376nium52',)
('ytoo3o9',)
('yu78',)
('vqx58pz0f',)
('cx5hn',)
('n2f3dqv0gcb9',)
('q7x',)
*/