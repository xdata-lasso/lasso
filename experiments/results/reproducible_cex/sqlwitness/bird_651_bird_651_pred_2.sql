-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, NULL, NULL, 'default2', '2023-01-01 01:00:00.000000', NULL, 'How to tell if something happened in a data set which monitors a value over time', 'How to tell if something happened in a data set which monitors a value over time', NULL, NULL, NULL, 0, NULL, 'default2'), (0, 1, '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', 'default2', NULL, 1, 1, NULL, NULL, 0, 'default1'), (2, NULL, '2023-01-01 01:00:00.000000', 'How to tell if something happened in a data set which monitors a value over time', '2023-01-01 00:00:00.000000', 'default2', 'default2', 'How to tell if something happened in a data set which monitors a value over time', 0, 0, 0, NULL, 1, NULL), (3, 1, NULL, NULL, '2023-01-01 01:00:00.000000', NULL, 'default1', 'default2', NULL, 0, NULL, 1, 1, 'default1'), (4, 1, NULL, NULL, '2023-01-01 01:00:00.000000', 'default1', 'default2', 'default2', 1, NULL, 0, 1, NULL, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1, 4, 4, 1, 0, NULL, 1, 1, 'How to tell if something happened in a data set which monitors a value over time', '2023-01-01 00:00:00.000000', 'How to tell if something happened in a data set which monitors a value over time', 'default2', 1, NULL, 1, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 0, NULL, NULL, 'default1'), (0, 1, NULL, 0, NULL, NULL, 1, 0, 'How to tell if something happened in a data set which monitors a value over time', '2023-01-01 01:00:00.000000', NULL, 'default1', NULL, 0, 1, '2023-01-01 00:00:00.000000', NULL, 1, '2023-01-01 01:00:00.000000', 'How to tell if something happened in a data set which monitors a value over time', 'default1'), (2, 4, NULL, NULL, 1, '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', NULL, 'How to tell if something happened in a data set which monitors a value over time', 'How to tell if something happened in a data set which monitors a value over time', 0, NULL, NULL, NULL, '2023-01-01 01:00:00.000000', 0, '2023-01-01 01:00:00.000000', 'How to tell if something happened in a data set which monitors a value over time', 'default1'), (3, 1, 4, 1, 0, '2023-01-01 01:00:00.000000', NULL, NULL, NULL, NULL, 'default2', 'default1', 1, NULL, 0, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, 'How to tell if something happened in a data set which monitors a value over time'), (4, 1, 1, 0, 1, NULL, 1, NULL, 'How to tell if something happened in a data set which monitors a value over time', '2023-01-01 00:00:00.000000', 'default1', NULL, 0, 0, NULL, '2023-01-01 01:00:00.000000', NULL, 0, '2023-01-01 01:00:00.000000', NULL, 'How to tell if something happened in a data set which monitors a value over time'), (5, 0, NULL, NULL, 0, '2023-01-01 00:00:00.000000', 1, 1, 'default1', NULL, 'default2', 'default1', NULL, 0, NULL, NULL, NULL, 1, '2023-01-01 00:00:00.000000', 'default1', NULL), (6, 1, 4, NULL, 0, '2023-01-01 01:00:00.000000', 0, 0, NULL, '2023-01-01 00:00:00.000000', NULL, 'default2', 0, 1, 1, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 0, '2023-01-01 00:00:00.000000', NULL, 'default2');
INSERT INTO postlinks (id, postid, relatedpostid, creationdate, linktypeid) VALUES (0, 0, NULL, '2023-01-01 01:00:00.000000', 0), (1, 4, 6, '2023-01-01 01:00:00.000000', 0), (2, 4, 3, '2023-01-01 00:00:00.000000', 0), (3, 2, 6, '2023-01-01 01:00:00.000000', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Title FROM postLinks AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id INNER JOIN posts AS T3 ON T1.RelatedPostId = T3.Id WHERE T2.Title = 'How to tell if something happened in a data set which monitors a value over time';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT "posts"."title" FROM "postlinks" INNER JOIN "posts" ON "postlinks"."relatedpostid" = "posts"."id" WHERE "postlinks"."postid" = (SELECT "id" FROM "posts" WHERE "title" = 'How to tell if something happened in a data set which monitors a value over time');

/*
Prediction Result:
*/