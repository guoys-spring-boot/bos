DELIMITER $$

DROP PROCEDURE showChildLst $$
CREATE PROCEDURE showChildLst (IN rootId VARCHAR (255))
BEGIN

  CREATE TEMPORARY TABLE IF NOT EXISTS tmpLst (
    sno INT (10) PRIMARY KEY AUTO_INCREMENT,
    id VARCHAR (255),
    depth INT (10)
  ) ;
  DELETE
  FROM
    tmpLst ;
  CALL createChildLst (rootId, 0) ;

  SELECT
    SUM(score.`scroe`),
    dw.`id`,
    COUNT(DISTINCT nr.`khxmid`),
    t.c,
    dw.`unitFullName` ,
    dw.`parentUnitCode`
  FROM
    (SELECT
      tmpLst.sno, tmpLst.depth,
      BASE_UNIT.*
    FROM
      tmpLst,
      BASE_UNIT
    WHERE tmpLst.id = BASE_UNIT.id
    ) dw
    LEFT JOIN `wmb_sbnr` nr
      ON nr.`dwid` = dw.id
    LEFT JOIN (select s1.`sbnrid`, sum(s1.`scroe`) as scroe from `wmb_score` s1 group by s1.`sbnrid` ) score
      ON score.`sbnrid` = nr.`id`

    LEFT JOIN
      (SELECT
        COUNT(*) c
      FROM
        wmb_khxm) t
      ON 1 = 1
    WHERE nr.`khxmid` is not null and nr.`khxmid` <> ''
  GROUP BY dw.`id`,
    t.c,
    dw.`unitFullName` ORDER  BY dw.sno;
END $$
DROP PROCEDURE createChildLst $$
CREATE
    PROCEDURE createChildLst(IN rootId VARCHAR(266), IN nDepth INT(10))

    BEGIN
        DECLARE done INT(10) DEFAULT 0;
        DECLARE b VARCHAR(255);
        DECLARE cur1 CURSOR FOR SELECT id FROM BASE_UNIT t WHERE t.parentUnitCode = rootId;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

        INSERT INTO tmpLst VALUES (NULL, rootId, nDepth);

        OPEN cur1;

        FETCH cur1 INTO b;
        WHILE done = 0 DO
            CALL createChildLst(b, nDepth + 1);
            FETCH cur1 INTO b;
        END WHILE;

        CLOSE cur1;
    END$$

DELIMITER ;