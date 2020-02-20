use SLCMandPLACEMENTF;
DELIMITER //
CREATE FUNCTION F (Regno1 varchar(20)) 
RETURNS float
BEGIN
      DECLARE CGPA float;
      DECLARE Gpasum float;
      DECLARE Counts int;
	    Select sum(GPA),count(*) INTO Gpasum,counts from Grades Where Regno=Regno1;
        SET CGPA=Gpasum/counts;
        Return CGPA;
        
	     
 END;//
DELIMITER ;