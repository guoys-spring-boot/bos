ALTER TABLE wmb_fujian
  ADD COLUMN uploadTime VARCHAR(255)
  FIRST,
  DEFAULT CHARACTER SET utf8;


ALTER TABLE wmb_khxm
  ADD COLUMN year VARCHAR(10)
  FIRST,
  DEFAULT CHARACTER SET utf8;


ALTER TABLE wmb_sbnr
  ADD COLUMN year VARCHAR(10)
  FIRST,
  DEFAULT CHARACTER SET utf8;


ALTER TABLE wmb_score
  ADD COLUMN year VARCHAR(10)
  FIRST,
  DEFAULT CHARACTER SET utf8;


ALTER TABLE wmb_khxzb
  ADD COLUMN year VARCHAR(10)
  FIRST,
  DEFAULT CHARACTER SET utf8;

ALTER TABLE auth_function ADD COLUMN ICONCLS varchar(200) AFTER PID;

UPDATE wmb_khxm SET year = '2017';
UPDATE wmb_sbnr SET year = '2017';
UPDATE wmb_score SET year = '2017';
UPDATE wmb_khxzb SET year = '2017';

CREATE VIEW `view_base_unit` AS
  SELECT
    `unit`.`id`                      AS `id`,
    `unit`.`parentUnitCode`          AS `parentUnitCode`,
    `unit`.`ascriptionArea`          AS `ascriptionArea`,
    `unit`.`organizationCode`        AS `organizationCode`,
    `unit`.`unitFullName`            AS `unitFullName`,
    `unit`.`unitType`                AS `unitType`,
    `unit`.`unitProperty`            AS `unitProperty`,
    `unit`.`unitLevel`               AS `unitLevel`,
    `unit`.`unitPersonCount`         AS `unitPersonCount`,
    `unit`.`legalEntity`             AS `legalEntity`,
    `unit`.`legalEntityTelNum`       AS `legalEntityTelNum`,
    `unit`.`leader`                  AS `leader`,
    `unit`.`leaderTelNum`            AS `leaderTelNum`,
    `unit`.`unitContactPerson`       AS `unitContactPerson`,
    `unit`.`unitContactPersonTelNum` AS `unitContactPersonTelNum`,
    `unit`.`contactQQ`               AS `contactQQ`,
    `unit`.`contactEmail`            AS `contactEmail`,
    `unit`.`username`                AS `username`,
    `unit`.`password`                AS `password`,
    `unit`.`auditingStatus`          AS `auditingStatus`,
    `unit`.`isAdmin`                 AS `isAdmin`,
    `unit`.`unitAddress`             AS `unitAddress`,
    `unit`.`unitShortName`           AS `unitShortName`,
    `unit`.`openid`                  AS `openid`,
    `unit`.`sessionKey`              AS `sessionKey`,
    `unittype`.`EnumText`            AS `unitTypeText`,
    `unitproperty`.`EnumText`        AS `unitPropertyText`,
    `unitlevel`.`EnumText`           AS `unitLevelText`
  FROM (((`bos`.`base_unit` `unit` LEFT JOIN `bos`.`base_enum` `unittype`
      ON (((`unittype`.`EnumCode` = `unit`.`unitType`) AND (`unittype`.`EnumType` = 'unitType')))) LEFT JOIN
    `bos`.`base_enum` `unitproperty` ON (((`unitproperty`.`EnumCode` = `unit`.`unitProperty`) AND
                                          (`unitproperty`.`EnumType` = 'unitProperty')))) LEFT JOIN
    `bos`.`base_enum` `unitlevel`
      ON (((`unitlevel`.`EnumCode` = `unit`.`unitLevel`) AND (`unitlevel`.`EnumType` = 'unitLevel'))));



CREATE VIEW `view_content_score` AS
  SELECT
    sum(`sc`.`scroe`) AS `score`,
    `nr`.`year`       AS `year`,
    `nr`.`id`         AS `id`,
    `nr`.`khxmid`     AS `khxmid`,
    `nr`.`dwid`       AS `dwid`,
    `nr`.`content`    AS `content`
  FROM (`bos`.`wmb_sbnr` `nr` LEFT JOIN `bos`.`wmb_score` `sc` ON ((`nr`.`id` = `sc`.`sbnrid`)))
  GROUP BY `nr`.`id`;

CREATE VIEW `view_count_project` AS
  SELECT
    count(0)                AS `c`,
    `bos`.`wmb_khxm`.`year` AS `year`,
    '1'                     AS `unionLevel`
  FROM `bos`.`wmb_khxm`
  GROUP BY `bos`.`wmb_khxm`.`year`
  UNION ALL SELECT
              count(0)                AS `c`,
              `bos`.`wmb_khxm`.`year` AS `year`,
              '2'                     AS `unionLevel`
            FROM `bos`.`wmb_khxm`
            GROUP BY `bos`.`wmb_khxm`.`year`
  UNION ALL SELECT
              count(0)                AS `c`,
              `bos`.`wmb_khxm`.`year` AS `year`,
              '3'                     AS `unionLevel`
            FROM `bos`.`wmb_khxm`
            WHERE (`bos`.`wmb_khxm`.`xmlx` = '10')
            GROUP BY `bos`.`wmb_khxm`.`year`
  UNION ALL SELECT
              count(0)                AS `c`,
              `bos`.`wmb_khxm`.`year` AS `year`,
              '4'                     AS `unionLevel`
            FROM `bos`.`wmb_khxm`
            WHERE (`bos`.`wmb_khxm`.`xmlx` = '10')
            GROUP BY `bos`.`wmb_khxm`.`year`
  UNION ALL SELECT
              count(0)                AS `c`,
              `bos`.`wmb_khxm`.`year` AS `year`,
              '5'                     AS `unionLevel`
            FROM `bos`.`wmb_khxm`
            WHERE (`bos`.`wmb_khxm`.`xmlx` = '10')
            GROUP BY `bos`.`wmb_khxm`.`year`
  UNION ALL SELECT
              count(0)                AS `c`,
              `bos`.`wmb_khxm`.`year` AS `year`,
              '6'                     AS `unionLevel`
            FROM `bos`.`wmb_khxm`
            WHERE (`bos`.`wmb_khxm`.`xmlx` = '10')
            GROUP BY `bos`.`wmb_khxm`.`year`;

DROP PROCEDURE `showChildLst`;
CREATE PROCEDURE `showChildLst`(IN `rootId` VARCHAR(255), IN `_year` VARCHAR(10))
  BEGIN

    CREATE TEMPORARY TABLE IF NOT EXISTS tmpLst (
      sno   INT(10) PRIMARY KEY AUTO_INCREMENT,
      id    VARCHAR(255),
      depth INT(10)
    );
    DELETE
    FROM
      tmpLst;
    CALL createChildLst(rootId, 0);

    SELECT
      sum(totalScore)                  AS totalScore,
      sum(completedCount)              AS completedCount,
      id                               AS id,
      totalCount                       AS totalCount,
      totalCount - sum(completedCount) AS unCompleteCount,
      unitName,
      _parentId,
      unitType
    FROM (
           SELECT
             CASE WHEN nr.xmlx = 10 AND SUM(score.`scroe`) > 30
               THEN 30
             ELSE
               SUM(score.`scroe`) END    AS totalScore,
             dw.`id`                     AS id,
             COUNT(DISTINCT nr.`khxmid`) AS completedCount,
             CASE WHEN dw.unitLevel IN ('1', '2')
               THEN t.c
             ELSE t1.c1 END              AS totalCount,
             dw.`unitFullName`           AS unitName,
             dw.`parentUnitCode`         AS _parentId,
             BASE_ENUM.EnumText          AS unitType,
             nr.xmlx,
             dw.sno
           FROM
             (SELECT
                tmpLst.sno,
                tmpLst.depth,
                BASE_UNIT.*
              FROM
                tmpLst,
                BASE_UNIT
              WHERE tmpLst.id = BASE_UNIT.id
             ) dw
             LEFT JOIN (SELECT
                          wmb_sbnr.*,
                          khxm.xmlx
                        FROM (SELECT *
                              FROM wmb_sbnr
                              WHERE year = _year) AS wmb_sbnr
                          LEFT JOIN wmb_khxm khxm ON khxm.id = wmb_sbnr.khxmid AND wmb_sbnr.year = _year
                        WHERE wmb_sbnr.`khxmid` IS NOT NULL AND `wmb_sbnr`.`khxmid` <> '') nr
               ON nr.`dwid` = dw.id
             LEFT JOIN (SELECT
                          s1.`sbnrid`,
                          sum(s1.`scroe`) AS scroe
                        FROM `wmb_score` s1
                        GROUP BY s1.`sbnrid`) score
               ON score.`sbnrid` = nr.`id`

             LEFT JOIN
             (SELECT COUNT(*) c
              FROM
                wmb_khxm
              WHERE wmb_khxm.year = _year) t
               ON 1 = 1
             LEFT JOIN (
                         SELECT count(*) c1
                         FROM wmb_khxm
                         WHERE xmlx = 10 AND wmb_khxm.year = _year
                       ) t1 ON 1 = 1
             LEFT JOIN BASE_ENUM
               ON dw.unitLevel = BASE_ENUM.EnumCode AND BASE_ENUM.EnumType = 'unitLevel'
           #WHERE nr.`khxmid` is not null and nr.`khxmid` <> ''
           GROUP BY dw.`id`,
             t.c,
             t1.c1,
             dw.`unitFullName`,
             dw.unitType,
             nr.xmlx,
             dw.sno
         ) t
    GROUP BY totalCount, id, unitName, _parentId, unitType
    ORDER BY sno;
  END;

DROP PROCEDURE  `createChildLst`;
CREATE PROCEDURE `createChildLst`(IN `rootId` VARCHAR(266), IN `nDepth` INT(10))
  BEGIN
    DECLARE done INT(10) DEFAULT 0;
    DECLARE b VARCHAR(255);
    DECLARE cur1 CURSOR FOR SELECT id
                            FROM BASE_UNIT t
                            WHERE t.parentUnitCode = rootId;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    INSERT INTO tmpLst VALUES (NULL, rootId, nDepth);

    OPEN cur1;

    FETCH cur1
    INTO b;
    WHILE done = 0 DO
      CALL createChildLst(b, nDepth + 1);
      FETCH cur1
      INTO b;
    END WHILE;

    CLOSE cur1;
  END;


CREATE TABLE wmb_notice
(
  id VARCHAR(40) PRIMARY KEY ,
  name VARCHAR(255),
  create_time VARCHAR(255)
);
