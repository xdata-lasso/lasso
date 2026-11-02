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
-- DATASET 1
INSERT INTO users (Id, Reputation, DisplayName, AccountId) VALUES (1, 100, 'Sharpie', 99);
INSERT INTO users (Id, Reputation, DisplayName, AccountId) VALUES (2, 200, 'NotSharpie', 1);
INSERT INTO users (Id, Reputation, DisplayName, AccountId) VALUES (3, 300, 'Sharpie', 30);
INSERT INTO users (Id, Reputation, DisplayName, AccountId) VALUES (4, 400, 'sharpie', 40);
INSERT INTO users (Id, Reputation, DisplayName, AccountId) VALUES (5, 500, 'Sharpie Jr', 50);
INSERT INTO badges (Id, UserId, Name, Date) VALUES (10, 1, 'Teacher', '2020-01-01 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (11, 1, 'Student', '2020-01-02 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (12, 1, 'Teacher', '2020-01-03 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (13, 2, 'Editor', '2020-01-04 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (1, 2, 'WrongJoinOnBadgeId', '2020-01-05 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (14, NULL, 'OrphanBadge', '2020-01-06 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (15, 4, 'CaseSensitiveBadge', '2020-01-07 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (16, 5, 'LikePrefixBadge', '2020-01-08 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Name FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T1.DisplayName = 'Sharpie';

/*
Gold Result:
('Teacher',)
('Student',)
('Teacher',)
*/

-- Prediction Query
SELECT DISTINCT "badges"."name" FROM "badges" INNER JOIN "users" ON "badges"."userid" = "users"."id" WHERE "users"."displayname" = 'Sharpie';

/*
Prediction Result:
('Teacher',)
('Student',)
*/