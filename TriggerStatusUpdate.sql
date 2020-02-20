Use Slcm;
DROP TRIGGER IF EXISTS StatusUpdate;
DELIMITER //
CREATE TRIGGER StatusUpdate AFTER INSERT ON Selected
FOR EACH ROW
BEGIN
   Update PlacementStatus set Status=new.Status where Appid=new.Appid;
END; //
DELIMITER ;