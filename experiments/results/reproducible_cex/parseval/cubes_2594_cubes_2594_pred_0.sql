-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu');

-- Inserting into table: volume --
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1, -2147483648, 'hsrwbbp', 'luhvdltti', 182.319045, 'nprmdposii');

-- Inserting into table: music_festival --
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483648, 1, '5u', 'w6kl', 'a9', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483647, 1, '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483646, 1, 'rofqyp5s5b', 'p', '02eutliqa11r', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483645, 1, 'ytoo3o9', 'l7', 'klex14ji', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483644, 1, '7zwau2dwyr', '13pyu', '8d99rljsl', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483643, 1, 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483642, 1, '1vy9uxj4', 'wb', 'v', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483641, 1, 'ph2', 'nd', 'wnqcx', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483640, 1, '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483639, 1, 'ozk3zbily', 'kn6vc', '6ah', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483638, 1, 'f8jswwl', '7xb72', 'xa', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483637, 1, '7ryfdrz16n', 'jja', '5dh', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483636, 1, 'grgj', '8', 'yzt1afgogrit', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483635, 1, '3ay', 'p1q430', 'jh3den8', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483634, 1, '68x8vacx7a', 'u5', '1of77p', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483633, 1, '72ct', 'c', 'mfg62', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483632, 1, 'v5q8qdj', 'e1io', '278507cv', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483631, 1, 'ptt', '6b', 'ou5z', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483630, 1, '36c', 'bfkfoacd', '7z2zezj', NULL);

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483629, 1, '7wgx', '5', 'sxcmr0o', NULL);

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483628, 1, 'ztdgj5i3lq5l', 'pim5', '58q', NULL);

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483627, 1, 's27p2r94gth2', 'najj', 'a3o', NULL);

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483626, 1, 'v8u', 'tmu2n', '57', NULL);

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483625, 1, 'lfvyz7zzb', '8y', 'kv42q7', NULL);

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483624, 1, 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483623, 1, 'o705', 'a9n0jxfofws', 'do2zobb', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483622, 1, 'q0k32od', 'cl5ams', 'orlwyngc1dj', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483621, 1, '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483620, 1, '521gwnlas6e', 'lboeowii1z5', 'xih6', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483619, 1, '2q2xlyoto', '9oaawg', '6aqb0tbin', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483618, 1, 'z', '9tajz9td', 'n5wcgumbc', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483617, 1, '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483616, 1, '55', '3dohvu0', 'dza35rmki', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483615, 1, '18ri', 'hy08ftp6', 'wt', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483614, 1, 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483613, 1, 'sh5knzys7', 'y', 'yd1jmgjach8', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483612, 1, 'qta8y3a17v4y', 'ma', 'q3qdpua', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483611, 1, '96rn', 'dqrhm', 'wlic7dn2', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483610, 1, 'p490', 'dmsqtg', 'lc', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483609, 1, 'qb9i9f', 'ccukjq1q', 'ik1yhb', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483608, 1, '8hlst1p', 'qomiztvb6m', 'iz78aqql', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483607, 1, 'd8ftb8', '9114q', 'r', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483606, 1, '6b', 'jeuuwsj8kj', '85', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483605, 1, 'pxlvri', 'surz0kaqtncg', 'c8s3b7v88k', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483604, 1, 'dmdbdh', '6j47n', 'ar50hs', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483603, 1, 'han', 'xdpunmw', 'wx', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483602, 1, 'rlawk', '14r5dqt', 'mg97a', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483601, 1, 'z2o20', 'pj6ddlysu6ip', 'dk', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483600, 1, 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483599, 1, 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483598, 1, 'mjwpp2', 'mb3aj0ju0', '3r', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483597, 1, '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483596, 1, '54o6qjektb1', '2', 'zg3r', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483595, 1, 'jkwns47j2j', '8', 'c', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483594, 1, 'y', 'vjwq49yr', 'nxs6dvdxdo2v', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483593, 1, '7t3gvplj9f', 'vuu', '7k10', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483592, 1, 'z2my1ogyv1r', 'ez', 'x', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483591, 1, '1', 'l', 'upgly78oit', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483590, 1, 'xeilpe019cy', 'od033dlhd', 'vnhed', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483589, 1, '9lqv26u3', '1spxpw30', 'g', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483588, 1, 'kxginl', '6id', 'p61l', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483587, 1, 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483586, 1, '4u', 'kh', 'llbwvdpu5v0e', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483585, 1, 'u', 'y9v2z12983', '5xoepacxdb2f', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483584, 1, 'c296xiy', 'et8xjhcf46c', 'pe', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483583, 1, 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483582, 1, '7vpc0xffwo', '1esks', '9q', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483581, 1, '2qg01huij', '7f8kqhiu5g', '8gxb', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483580, 1, 'qjlsawsp', 'kwi3hl7j', '3y795ybv', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483579, 1, '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483578, 1, '80terbf', 'kvee', 'sltut6lu2', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483577, 1, 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483576, 1, '88y1k253s', '5', 'ls1ehn1md', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483575, 1, 'aqqhyyzsnp64', 'mn', 'w4m0', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483574, 1, 'rwbjk', 'bph6gdw', '7', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483573, 1, 'jjplwtlzh42n', 'j5yrji5', 'qkna', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483572, 1, '38gfxswb2d0', 'mxwdb7o', 'p5qo1', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483571, 1, '4c6', 'gwnkd4kc3ii', 'axz', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483570, 1, '90nhs', '9gob', '6', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483569, 1, 'rn5u', 'phy', 'n', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483568, 1, 'a', 'vhvyx8s', 'r', 'mus_5ac41d');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483567, 1, 'fs3qn0b', 'm2rlxcrw', 'x0', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483566, 1, '3rzgz84lqm', '2w', 'b1b3vun66e0i', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483565, 1, 'olt0', '0zi90o50q', '33g865zm6', 'mus_3beeb9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (2, 1, 'ewew', '092p40u2vi', 'l21xsad6q5z', 'qoa');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (3, 1, '023lwh9', '4fqc1m9gr', 'xjqbloxd4', 'j5il9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT RESULT, volume, volume AS n, result_other FROM (SELECT LHS.result AS RESULT, LHS.volume AS volume, LHS.n AS n, RHS.result AS result_other FROM (SELECT RESULT, volume, COUNT(*) AS n FROM music_festival GROUP BY RESULT, volume) AS LHS INNER JOIN (SELECT RESULT, volume, COUNT(*) AS n FROM music_festival GROUP BY RESULT, volume) AS RHS ON (LHS.volume = RHS.n AND LHS.n = RHS.volume))) ORDER BY RESULT;

/*
Gold Result:
('j5il9',)
('j5il9',)
('qoa',)
('qoa',)
*/

-- Prediction Query
SELECT RESULT FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST LIMIT 1;

/*
Prediction Result:
('mus_3beeb9',)
*/