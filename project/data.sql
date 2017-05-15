
INSERT INTO Employee VALUES (0,'Rui','Li','Boss',50);
INSERT INTO Employee VALUES (1,'Hong','Li','Accountant',15);
INSERT INTO Employee VALUES (2,'Will','Smith','Delivery',10);
INSERT INTO Employee VALUES (3,'Najin','Smith','Delivery',8);
INSERT INTO Employee VALUES (4,'Andre','Drummond','Packager',10);
INSERT INTO Employee VALUES (5,'Marco','Polo','Vegetable Washer',10);
INSERT INTO Employee VALUES (6,'Chuck','Li','Vegetable Washer',10);
INSERT INTO Employee VALUES (7,'Donald','Trump','Tweeter-In-Chief',1000000);
INSERT INTO Employee VALUES (8,'Du','Bak','Packager',10);
INSERT INTO Employee VALUES (9,'Marco','Polo','Vegetable Washer',10);
INSERT INTO Employee VALUES (10,'Chris','Li','Database Manager',15);
INSERT INTO Employee VALUES (11,'Keith','Vanderlinden','Botany Professor',20);
INSERT INTO Employee VALUES (12,'Mike','Pence','Electrician',20);

INSERT INTO Loans VALUES (0,50,'12/DEC/16','1/JAN/17','Y',2);
INSERT INTO Loans VALUES (1,30,'28/FEB/17','5/MAR/17','N',4);
INSERT INTO Loans VALUES (2,1,'21/JAN/02','5/JUN/11','N',3);
INSERT INTO Loans VALUES (3,80,'28/MAR/17','5/MAY/17','N',5);
INSERT INTO Loans VALUES (4,100,'20/MAR/17','15/MAY/17','Y',6);
INSERT INTO Loans VALUES (5,1000000,'20/MAR/17','15/MAY/17','Y',7);

INSERT INTO Customer VALUES (0,'Golden Dragon','1201 Detroit Street.','Detroit',48226);
INSERT INTO Customer VALUES (1,'Flaming Wok','1312 Circle Dr.','Sterling Heights',48482);
INSERT INTO Customer VALUES (2,'Sala Thai','1521 Customer Rd.','Madison Heights',48721);
INSERT INTO Customer VALUES (3,'Nino Salvaggio','1824 Rochester Rd.','Troy',48085);
INSERT INTO Customer VALUES (4,'Calvin College Dining','3201 Burton St. SE','Grand Rapids',49546);
INSERT INTO Customer VALUES (5,'McDonalds','750 Rochester Rd.','Troy',48085);
INSERT INTO Customer VALUES (6,'Wendys','760 Rochester Rd.','Troy',48085);
INSERT INTO Customer VALUES (7,'Burger King','770 Rochester Rd.','Troy',48085);
INSERT INTO Customer VALUES (8,'Steak and Shake','180 Hall Rd.','Sterling Heights',49535);
INSERT INTO Customer VALUES (9,'Red Lobster','120 Hall Rd.','Sterling Heights',49535);
INSERT INTO Customer VALUES (10,'Texas Roadhouse','1102 Willow Rd.','Madison Heights',49265);
INSERT INTO Customer VALUES (11,'Sushi Restaurant','1090 Shinjuku District','Tokyo',12345);

INSERT INTO Vehicle VALUES (0,'Ford Delivery Truck','Working');
INSERT INTO Vehicle VALUES (1,'Honda Delivery Truck','Working');
INSERT INTO Vehicle VALUES (2,'Dodge Semi-Truck','Out of Gas');
INSERT INTO Vehicle VALUES (3,'Evade Semi-Truck','Damaged Tires');


INSERT INTO Order1 VALUES (0,'17/NOV/16','18/NOV/16','18/NOV/16','Complete',8,2,0,0);
INSERT INTO Order1 VALUES (1,'17/NOV/16','18/NOV/16','18/NOV/16','Complete',24,2,1,0);
INSERT INTO Order1 VALUES (2,'20/JAN/17','21/JAN/17','22/JAN/17','Complete',35,3,2,1);
INSERT INTO Order1 VALUES (3,'29/MAR/17',NULL,SYSDATE,'Incomplete',8,3,0,0);
INSERT INTO Order1 VALUES (4,'14/APR/17',NULL,'15/APR/17','Incomplete',20,3,4,1);
INSERT INTO Order1 VALUES (5,'26/APR/17',NULL,'27/APR/17','Incomplete',15,3,5,1);
INSERT INTO Order1 VALUES (6,'01/MAY/17',NULL,'02/MAY/17','Incomplete',47,3,6,1);
INSERT INTO Order1 VALUES (7,'09/MAY/17',NULL,'10/MAY/17','Incomplete',16,2,7,0);
INSERT INTO Order1 VALUES (8,'09/MAY/17','10/MAY/17','10/MAY/17','Complete',45,2,8,0);
INSERT INTO Order1 VALUES (9,'15/MAY/17','16/MAY/17','16/MAY/17','Complete',10,2,9,0);
INSERT INTO Order1 VALUES (10,'15/MAY/17','16/MAY/17','16/MAY/17','Complete',10,3,10,1);

INSERT INTO Item VALUES (0,'Bean Sprout',8,20);
INSERT INTO Item VALUES (1,'Brocoli',11,10);
INSERT INTO Item VALUES (2,'Eggplant',15,5);
INSERT INTO Item VALUES (3,'Nappa',10,20);
INSERT INTO Item VALUES (4,'Vegan Food',15,10);
INSERT INTO Item VALUES (5,'Noodles',7,15);
INSERT INTO Item VALUES (6,'Onions',20,10);
INSERT INTO Item VALUES (7,'Eggs',8,20);
INSERT INTO Item VALUES (8,'Rice',15,20);
INSERT INTO Item VALUES (9,'Green Onions',10,10);
INSERT INTO Item VALUES (10,'Mushroom',10,20);

INSERT INTO OrderItem VALUES (0,1,1);
INSERT INTO OrderItem VALUES (1,1,3);
INSERT INTO OrderItem VALUES (2,0,3);
INSERT INTO OrderItem VALUES (2,1,1);
INSERT INTO OrderItem VALUES (3,0,1);
INSERT INTO OrderItem VALUES (4,3,2);
INSERT INTO OrderItem VALUES (5,4,1);
INSERT INTO OrderItem VALUES (6,5,1);
INSERT INTO OrderItem VALUES (6,6,2);
INSERT INTO OrderItem VALUES (7,7,2);
INSERT INTO OrderItem VALUES (8,8,3);
INSERT INTO OrderItem VALUES (9,9,1);
INSERT INTO OrderItem VALUES (10,10,1);
