use SLCMandPLACEMENTF;
DELIMITER //
CREATE PROCEDURE P (IN Regno1 varchar(20), IN Semester1 int) 
BEGIN
      DECLARE done INT DEFAULT FALSE;
      DECLARE MarksSum int;
      DECLARE credits int;
      DECLARE grade INT;
	    DECLARE SumG  INT DEFAULT 0;
	    DECLARE TotalCredit INT DEFAULT 0;
      DECLARE GPA FLOAT; 
      DECLARE Cur1 CURSOR FOR Select sum(MarksObtained),credit from Marks,CourseDetails Where CourseDetails.subjectcode=Marks.subjectcode and Regno=Regno1 and Semester=Semester1 group by Marks.subjectcode;
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	    
	     
	     OPEN Cur1;
       ino_loop: LOOP
	       FETCH Cur1 INTO MarksSum,credits;
		   IF done THEN
                LEAVE ino_loop;
				
           END IF;
     IF(MarksSum>90) THEN
	         SET grade = 10*credits;
	  ELSEIF(MarksSum>80 && MarksSum<=90) THEN
	         SET grade=9*credits;
	  ELSEIF(MarksSum>70 && MarksSum<=80) THEN
	        SET grade=8*credits;
	  ELSEIF(MarksSum>60 && MarksSum<=70) THEN
	         SET grade=7*credits;
	  ELSEIF(MarksSum>50 && MarksSum<=60) THEN
	         SET grade=6*credits;
	  ELSEIF(MarksSum>40 && MarksSum<=50) THEN
	         SET grade=5*credits;
	  ELSE
	  SET grade=0;
	  END IF;
	  SET SumG=SumG+grade;
	  SET TotalCredit=TotalCredit+credits;
      END LOOP;
	  CLOSE Cur1;
	  SET GPA =SumG/TotalCredit;
      insert into Grades values(Regno1,Semester1,GPA);
 END;//
DELIMITER ;