Use SLCMandPLACEMENTF;
DROP TRIGGER IF EXISTS takesTrig;
DELIMITER //
CREATE TRIGGER takesTrig AFTER INSERT ON Studentinfo
FOR EACH ROW
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE ids VARCHAR(10);
    DECLARE cur CURSOR FOR Select subjectcode from Studentinfo ,CourseDetails where Regno=New.Regno and Studentinfo.branch=CourseDetails.branch and Studentinfo.Semester=CourseDetails.Semester;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
        ins_loop: LOOP
            FETCH cur INTO ids;
            IF done THEN
                LEAVE ins_loop;
            END IF;
            INSERT INTO Takes(Regno,subjectcode) VALUES (New.Regno,ids);
        END LOOP;
    CLOSE cur;
END; //
DELIMITER ;