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
-- DATASET 3
-- Tests date boundary conditions (2010, 2012, NULL) and date column confusion (users.CreationDate, Users.LastAccessDate, posts.LasActivityDate, posts.LastEditDate, posts.ClosedDate, posts.CommunityOwnedDate).
INSERT INTO users (Id, CreationDate, DisplayName, LastAccessDate) VALUES (1, '2011-05-05 12:00:00', 'Date2010Dec31', '2011-05-05 12:00:00');
INSERT INTO users (Id, CreationDate, DisplayName, LastAccessDate) VALUES (2, '2011-05-05 12:00:00', 'Date2012Jan01', '2011-05-05 12:00:00');
INSERT INTO users (Id, CreationDate, DisplayName, LastAccessDate) VALUES (3, '2011-05-05 12:00:00', 'DateNull', '2011-05-05 12:00:00');
INSERT INTO users (Id, CreationDate, DisplayName, LastAccessDate) VALUES (4, '2009-01-01 00:00:00', 'Valid2011', '2015-01-01 00:00:00');
INSERT INTO posts (Id, CreaionDate, ViewCount, OwnerUserId, LasActivityDate, LastEditDate, CommunityOwnedDate, ClosedDate) VALUES (201, '2010-12-31 23:59:59', 25000, 1, '2011-06-01 00:00:00', '2011-06-01 00:00:00', '2011-06-01 00:00:00', '2011-06-01 00:00:00');
INSERT INTO posts (Id, CreaionDate, ViewCount, OwnerUserId, LasActivityDate, LastEditDate, CommunityOwnedDate, ClosedDate) VALUES (202, '2012-01-01 00:00:00', 25000, 2, '2011-06-01 00:00:00', '2011-06-01 00:00:00', '2011-06-01 00:00:00', '2011-06-01 00:00:00');
INSERT INTO posts (Id, CreaionDate, ViewCount, OwnerUserId, LasActivityDate, LastEditDate, CommunityOwnedDate, ClosedDate) VALUES (203, NULL, 25000, 3, '2011-06-01 00:00:00', '2011-06-01 00:00:00', '2011-06-01 00:00:00', '2011-06-01 00:00:00');
INSERT INTO posts (Id, CreaionDate, ViewCount, OwnerUserId, LasActivityDate, LastEditDate, CommunityOwnedDate, ClosedDate) VALUES (204, '2011-01-01 00:00:00', 25000, 4, '2013-01-01 00:00:00', '2013-01-01 00:00:00', '2013-01-01 00:00:00', '2013-01-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE STRFTIME('%Y', T2.CreaionDate) = '2011' AND T2.ViewCount > 20000;

/*
Gold Result:
('Valid2011',)
*/

-- Prediction Query
SELECT users.displayname FROM users INNER JOIN posts ON users.id = posts.owneruserid WHERE posts.viewcount > 20000;

/*
Prediction Result:
('Date2010Dec31',)
('Date2012Jan01',)
('DateNull',)
('Valid2011',)
*/