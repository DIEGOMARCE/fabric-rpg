000100231120**FREE
000101231120
000102231120ctl-opt dftactgrp(*no) actgrp(*new);
000103231120
000104231120dcl-s ServerName char(10);
000105231120dcl-s startTime timestamp;
000106231120dcl-s endTime timestamp;
000107231120dcl-s duration int(10);
000108231120dcl-s minutesElapsed int(10);
000109231120
000110231120
000111231120// Get the name of the current server
000112231120exec sql SELECT CURRENT_SERVER INTO :ServerName FROM SYSIBM.SYSDUMMY1;
000113231120
000114231120// Check if the server is correct
000115231120if ServerName = 'CRS';
000116231120   // Show message if server is correct
000117231120   dsPLY 'The server is correct.';
000118231120
000119231120   // Get the start timestamp
000120231120   startTime = %timestamp();
000121231120   dsply ('Start time: ' + %char(startTime));
000122231120
000123231120   // Call RPG programs
000124231120   callp CallProgram('CRSTEST/FABRIC');
000125231120   dsply ('End proc: ' + %char(%timestamp()));
000126231120
000127231120   // Get and display the completion timestamp
000128231120   endTime = %timestamp();
000129231120   dsply ('Ending time: ' + %char(endTime));
000130231120
000131231120 // Calculate the duration in minutes
000132231120duration = %diff(endTime: startTime: *seconds);
000133231120minutesElapsed = duration / 60;
000134231120dsply ('The program took: ' + %char(minutesElapsed) + ' minutes');
000135231120
000136231120else;
000137231120   // Show message if the server is not correct
000138231120   dsply 'The server is not correct.';
000139231120endif;
000140231120
000141231120*inlr = *on;
000142231120
000143231120// Subroutine to call a program
000144231120dcl-proc CallProgram;
000145231120   dcl-pi *n;
000146231120      ProgramName char(21) const;
000147231120   end-pi;
000148231120
000149231120   exec sql CALL :ProgramName;
000150231120
000151231120end-proc;
