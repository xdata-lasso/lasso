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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (-1, 1, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'Mark Meckes', NULL, 'default1', 0, 0, NULL, -1, 0, NULL), (1, NULL, '2023-01-01 01:00:00.000000', 'Mark Meckes', '2023-01-01 00:00:00.000000', NULL, 'default2', 'default2', 0, 1, -1, 0, -1, 'Mark Meckes');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 1, 1, NULL, 0, '2023-01-01 00:00:00.000000', -1, 0, 'Mark Meckes', NULL, 'Mark Meckes', 'default2', NULL, 0, -1, NULL, '2023-01-01 00:00:00.000000', -1, '2023-01-01 00:00:00.000000', 'default2', 'default2');
INSERT INTO tags (id, excerptpostid, tagname, count, wikipostid) VALUES (-1, 0, 'Mark Meckes', 0, 0), (0, NULL, 'Mark Meckes', -1, 1), (1, NULL, 'Mark Meckes', 0, -1), (2, NULL, 'Mark Meckes', -1, 1), (3, 0, NULL, 0, 0), (4, 0, 'default2', NULL, NULL), (5, 0, 'default2', 0, NULL), (6, NULL, 'default2', 0, 1), (7, 0, 'default2', 1, 0), (8, NULL, 'default2', NULL, 0);
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (-1, 0, 1, 1, NULL, NULL, 'default2', NULL, 'default1'), (0, 0, NULL, 0, 'Mark Meckes', NULL, 'Mark Meckes', NULL, NULL), (1, 0, NULL, NULL, NULL, '2023-01-01 00:00:00.000000', NULL, 'default1', NULL), (2, NULL, -1, 1, 'Mark Meckes', '2023-01-01 01:00:00.000000', 'default1', 'Mark Meckes', 'Mark Meckes'), (3, NULL, NULL, 1, 'Mark Meckes', '2023-01-01 00:00:00.000000', 'Mark Meckes', NULL, 'default1'), (4, 0, NULL, 1, 'Mark Meckes', NULL, NULL, NULL, 'default2'), (5, 0, 1, 0, NULL, NULL, NULL, 'default2', 'Mark Meckes'), (6, 0, -1, -1, 'Mark Meckes', '2023-01-01 00:00:00.000000', 'Mark Meckes', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Tags FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T3.Id = T2.PostId WHERE T1.DisplayName = 'Mark Meckes' AND T3.CommentCount = 0;

/*
Gold Result:
('default2',)
('default2',)
*/

-- Prediction Query
SELECT T2.TagName FROM posts AS T1 INNER JOIN tags AS T2 ON T1.Id = T2.ExcerptPostId INNER JOIN users AS T3 ON T1.OwnerUserId = T3.Id WHERE T3.DisplayName = 'Mark Meckes' AND T1.CommentCount = 0;

/*
Prediction Result:
('Mark Meckes',)
(None,)
('default2',)
('default2',)
('default2',)
*/