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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 20000, '2023-01-01 01:00:00.000000', '%Y', NULL, 'default2', 'default2', 'default1', 20000, 20000, NULL, 1, 19999, NULL), (0, 20001, NULL, '2011', '2011-10-27 00:00:00.000000', '2011', '2011', 'default2', 20001, 20000, NULL, NULL, 20001, 'default1'), (19999, 1, NULL, 'default2', '2023-01-01 01:00:00.000000', '2011', 'default1', '2011', 20000, 0, 20001, NULL, 20000, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (20000, 19999, 0, NULL, 19999, NULL, NULL, 20001, 'default1', NULL, '%Y', NULL, 0, 0, NULL, NULL, '2011-10-27 00:00:00.000000', 19999, '2023-01-01 00:00:00.000000', '2011', 'default1'), (19999, 19999, 1, 0, 20001, '2023-01-01 00:00:00.000000', 0, NULL, '%Y', '2023-01-01 00:00:00.000000', '%Y', 'default2', 0, 20000, 20000, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 19999, NULL, '%Y', 'default2'), (20001, 0, 19999, 20001, 1, '2011-10-27 00:00:00.000000', 0, 20001, 'default2', '2023-01-01 01:00:00.000000', 'default1', 'default1', 1, 0, 1, NULL, '2011-10-27 00:00:00.000000', 0, '2011-10-27 00:00:00.000000', 'default2', 'default2'), (0, NULL, 1, 1, 19999, '2011-10-27 00:00:00.000000', 0, 20000, '2011', '2011-10-27 00:00:00.000000', 'default1', '%Y', NULL, 20001, 20000, '2011-10-27 00:00:00.000000', '2023-01-01 01:00:00.000000', 1, '2023-01-01 01:00:00.000000', NULL, '%Y'), (1, 19999, 0, 20000, NULL, '2011-10-27 00:00:00.000000', 20000, 20000, 'default1', '2023-01-01 01:00:00.000000', 'default1', '2011', 19999, 20001, 20001, '2011-10-27 00:00:00.000000', '2023-01-01 00:00:00.000000', 19999, '2023-01-01 01:00:00.000000', '2011', '2011'), (2, 19999, 1, 1, 1, '2023-01-01 00:00:00.000000', 20000, 20001, '2011', '2023-01-01 00:00:00.000000', 'default2', 'default1', NULL, 20000, 0, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', NULL, '2011-10-27 00:00:00.000000', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE STRFTIME('%Y', T2.CreaionDate) = '2011' AND T2.ViewCount > 20000;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT users.displayname FROM users INNER JOIN posts ON users.id = posts.owneruserid WHERE posts.viewcount > 20000;

/*
Prediction Result:
('%Y',)
('2011',)
('default2',)
*/