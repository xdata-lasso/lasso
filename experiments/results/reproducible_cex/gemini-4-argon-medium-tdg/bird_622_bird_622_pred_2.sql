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
-- Tests:
-- 1. Incorrect join condition (e.g., T1.Id = T2.Id, T1.AccountId = T2.UserId)
-- 2. Duplicate elimination (SELECT DISTINCT T2.Name)
-- 3. Multi-row results (LIMIT 1 mutations)
-- 4. String matching mutations (ILIKE, LIKE '%Sharpie%', case sensitivity, NULL handling)
-- 5. Outer join mutations (LEFT/RIGHT JOIN where users have no badges or badges have NULL UserId)
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, AccountId) VALUES (1, 100, '2020-01-01 00:00:00', 'Sharpie', 10);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, AccountId) VALUES (2, 200, '2020-01-02 00:00:00', 'sharpie', 1);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, AccountId) VALUES (3, 300, '2020-01-03 00:00:00', 'Sharpie123', 30);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, AccountId) VALUES (4, 400, '2020-01-04 00:00:00', 'OtherUser', 40);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, AccountId) VALUES (5, 500, '2020-01-05 00:00:00', NULL, 50);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, AccountId) VALUES (6, 600, '2020-01-06 00:00:00', 'Sharpie', 60);
INSERT INTO badges (Id, UserId, Name, Date) VALUES (1, 4, 'WrongJoinOnBadgeId', '2020-02-01 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (10, 1, 'Student', '2020-02-02 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (11, 1, 'Student', '2020-02-03 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (12, 1, 'Teacher', '2020-02-04 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (13, 2, 'CaseBadge', '2020-02-05 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (14, 3, 'PrefixBadge', '2020-02-06 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (15, 5, 'NullUserBadge', '2020-02-07 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (16, NULL, 'OrphanBadge', '2020-02-08 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Name FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T1.DisplayName = 'Sharpie';

/*
Gold Result:
('Student',)
('Student',)
('Teacher',)
*/

-- Prediction Query
SELECT DISTINCT "badges"."name" FROM "badges" INNER JOIN "users" ON "badges"."userid" = "users"."id" WHERE "users"."displayname" = 'Sharpie';

/*
Prediction Result:
('Student',)
('Teacher',)
*/