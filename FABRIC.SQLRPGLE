000001231030**FREE
000002231030// ********************************************************************
000003231030// *                                                                  *
000004231030// *                     T O M J A M E S                              *
000005231030// *                                                                  *
000006231030// ********************************************************************
000007231030// *                                                                  *
000008231120// * Program name:  fabric                                          *
000009231030// *                                                                  *
000010231030// * Date written:  11/09/23      Author:  Diego Sanhueza             *
000011231030// *                                                                  *
000012231030// *--------------  p r o g r a m   d e f i n i t i o n  -------------*
000013231030// *                                                                  *
000014231030// * FABRIC                                                           *
000015231030// *                                                                  *
000016231030// *                                                                  *
000017231030// *-------------  m o d i f i c a t i o n  h i s t o r y  -----------*
000018231030// *                                                                  *
000019231030// * change#    date    programmer    reason for change               *
000020231030// * ........ ........  ............. .............................   *
000021231030// * ........ ........  ............. .............................   *
000022231030// *                                                                  *
000023231030// *------------------  i n d i c a t o r  u s a g e  ----------------*
000024231030// *                                                                  *
000025231030// * nary                                                             *
000026231030// *                                                                  *
000027231030// *-------  s p e c i a l  f u n c t i o n s  o r  n o t e s  -------*
000028231030// *                                                                  *
000029231030// *                                                                  *
000030231030// ********************************************************************
000031231030
000032231030// Start Programer:
000033231023// Variables
000034231030dcl-s sku varchar(50);
000035231030dcl-s count int(10);
000036231023
000037231120// SQL to select records from ISFILE.FABRIC
000038231023exec sql
000039231023  DECLARE C1 CURSOR FOR
000040231023    SELECT fafabn
000041231023    FROM ISFILE.FABRIC
000042231023    WHERE TRIM(UPPER(facsst)) NOT IN ('N', 'W')
000043231023    AND TRIM(UPPER(faopn1)) IN ('B', 'D');
000044231023
000045231120// Open cursor
000046231023exec sql OPEN C1;
000047231023
000048231120// Loop to iterate through the records
000049231023dow (1=1);
000050231023    exec sql FETCH C1 INTO :sku;
000051231120    if SQLCOD = 100; // End of file
000052231023        leave;
000053231023    endif;
000054231023
000055231120     // Check if the SKU already exists in ALTFAB
000056231023    exec sql
000057231023      SELECT COUNT(*)
000058231023      INTO :count
000059231023      FROM ISFILE.ALTFAB
000060231023      WHERE SKU = :sku;
000061231023
000062231023    if count = 0;
000063231120        // The SKU doesn't exist in ALTFAB, it can be inserted
000064231023        exec sql INSERT INTO ISFILE.ALTFAB (SKU) VALUES (:sku);
000065231023    endif;
000066231023enddo;
000067231023
000068231120// Closed cursor
000069231023exec sql CLOSE C1;
000070231023
000071231120// End of program
000072231023*inlr = *on;
000073231023return;
000074231023
000075231023
