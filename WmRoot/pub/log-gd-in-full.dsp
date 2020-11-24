<HTML>
  <HEAD>
    <TITLE>Integration Server Guaranteed Delivery Log</TITLE>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js"></SCRIPT>
    <script language="JavaScript1.3">
    
    function checkEverything()
    {
        if (!verifyRequiredNonNegNumber('logform', 'numlines'))
        {
          alert("Number of lines to display must be a non negative number.");
          return false;
        }
        var numEntered = document.getElementById("numlines").value;
		if(numEntered <=0 || numEntered > 65535)
		{
			alert("Number of lines to display must be between 1 to 65535.");
			return false;
		}
        if ( document.logform.qfromdate != null &&
                  document.logform.qtodate != null ) {

             var fromDate = document.logform.qfromdate.value;

             var invalidItems = /\;|\,|\_|\<|\>|\@|\?|\#|\*|\&|\^|\~|\%|\!|\"|\$|\/|[a-zA-Z]/ig;

                 if (fromDate.match(invalidItems))
                 {
          alert("From Date can only contain valid date values in YYYY-MM-DD HH:MM:SS format.");
          return false;
          }

           var toDate = document.logform.qtodate.value;
           if (toDate.match(invalidItems))
               {
               alert("To Date can only contain valid date values in YYYY-MM-DD HH:MM:SS format.");
               return false;
          }
          }
        
        var alertMaxEntries = document.getElementById("alertMaxEntries").value;
        var numEntries = document.getElementById("numlines").value;
            
            if( isEmpty(alertMaxEntries) || isNaN(alertMaxEntries) || parseInt(alertMaxEntries) < 1 || !isInteger(alertMaxEntries))
            {
                return true;
            }
            alertMaxEntries = parseInt(alertMaxEntries);
            numEntries = parseInt(numEntries);
            if(numEntries > alertMaxEntries)
            {
                var choice=confirm("Number of entries to display exceed the value specified for the watt.server.log.alertMaxEntries property.\n\nIncreasing the number of entries displayed can slow system performance.\n\nDo you wish to continue?" );
                if (choice==false)
                {
                    document.getElementById("numlines").value = document.getElementById("oldNumLines").value;
                    return false;
                }
            }
    }
        function refreshSearch() {
            document.queryform.action = "svc_queryframe.dsp"
               document.queryform.target = "query"
               document.queryform.submit();                  // Submit the page
            }

            var today = new Date();
            var thisMonth = today.getMonth();
            var thisYear = today.getFullYear();
            var thisDate = today.getDate();
            var headerExist = false;
            function openCalendar( which )
            {
               window.open( "calendar.dsp?month="+thisMonth+"&year="+thisYear+"&date="+thisDate
                   +"&which="+escape(which), "calendar", "width=600,height=350,top=50,left=50,resizable=yes" );
            }
            function getTodayDate() {
               return thisYear + "-" + thisMonth + "-" + thisDate;
            }

            </script>

        %scope param(property='watt.server.log.refreshInterval')%
            %invoke wm.server.query:getSetting%
                %ifvar property -notempty%
                %ifvar property matches('-*')%
              %else%
                  <script> window.setInterval("checkEverything()","%value property encode(javascript)%"*1000);</script>
            %endif%
              %else%
                  <script> window.setInterval("checkEverything()",90*1000);</script>
              %endif%
            %endinvoke%
        %endscope%
    
    <SCRIPT>
    
    </SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('log-gd-in-full.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Logs_GDInboundLogScrn');">
    %scope param(property='watt.server.log.alertMaxEntries')%
        %invoke wm.server.query:getSetting%   
			<input type="hidden" name="alertMaxEntries" id="alertMaxEntries" value="%value property encode(htmlattr)%">
        %endinvoke%    
    %endscope%
  %ifvar numlines -notempty%
         %scope param(watt.server.log.maxEntries=numlines)%
                  %rename numlines watt.server.log.maxEntries -copy%
                  %invoke wm.server.admin:setSettings%
                  %onerror%
                  %ifvar errorMessage%
              	<TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
                  %endif%
                %endinvoke%
              %endscope%
        %endif%

    %scope param(property='watt.server.log.maxEntries')%
    %invoke wm.server.query:getSetting%

     %scope param(log='txin') param(checked='CHECKED') param(35lines=property)%
      <FORM NAME="logform" method="post">

     %rename ../../order order -copy%
     %ifvar order -notempty%
       %switch order%
         %case 'Ascending'%
           %rename checked ascendchecked -copy%
           %rename descendchecked%
         %case%
           %rename checked descendchecked -copy%
           %rename ascendchecked%
       %endswitch%
     %else%
       %rename checked descendchecked -copy%
       %rename ascendchecked%
      %endif%
     %ifvar numlines -notempty%
     %else%
       %rename 35lines numlines -copy%
      %endif%
          <TABLE width=100%>
            %rename ../../hideBreadcrumbs hideBreadcrumbs -copy%
            %ifvar hideBreadcrumbs%%else%
              <TR>
                <TD class="breadcrumb" colspan="2">
                  Logs &gt; Guaranteed Delivery &gt; Inbound
                </TD>
              </TR>
            %endif%
            <TR>
              <TD colspan="2">
                <UL>
				
				<script>
						    createForm("htmlform_http_log_gd_out_full", "log-gd-out-full.dsp", "POST", "BODY");
                </script>
				
                  <LI class="listitem">
				  <script>getURL("log-gd-out-full.dsp","javascript:document.htmlform_http_log_gd_out_full.submit();","View Guaranteed Delivery Outbound Log");</script>
				  </li>
                </UL>
              </TD>
            </TR>
            <TR>
           <TR>
               <TD>
                  <TABLE class="tableView">
                    <TR>
                      <TD colspan=4 class="heading">Log display controls</TD>
                    </TR>
                    <TR>
                      <TD class="oddrow" nowrap>
                        <TABLE class="noborders">
                          <TR>
                            <TD>
                              <INPUT TYPE="radio" name="order" id="order1" VALUE="Ascending" %value ascendchecked encode(htmlattr)%>
                            </TD>
                            <TD>
                              <label for="order1">DisplayLog Entries oldest to newest starting from the beginning</label></TD>
                            </TD>
                          </TR>
                          <TR>
                            <TD>
                              <INPUT TYPE="radio" name="order" id="order2" VALUE="Descending" %value descendchecked encode(htmlattr)%>
                            </TD>
                            <TD>
                              <label for="order2">DisplayLog Entries newest to oldest starting from the end</label></TD>
                            </TD>
                          </TR>
                        </TABLE>
                      </TD>

                      <TD class="oddrow" nowrap>
                        <label for="numlines">Number of entries to display</label>
                        <INPUT name="numlines" id="numlines" size="5" value="%value property encode(htmlattr)%">
						<input name="oldNumlines" id="oldNumLines" type="hidden" value="%value property encode(htmlattr)%"/>
                      </TD>
                      <TD class="oddrow">  <INPUT type="SUBMIT" VALUE="Refresh" onClick="return checkEverything();"></TD>
                    </TR>
                  %scope param(property='watt.server.auditStore')%
            %invoke wm.server.auditing:getDestination%

            %ifvar property equals('database')%

              <TR class="oddrow">
              <TD  nowrap></TD>

               <TD style="text-align: right">
               <br>

            <a href="javascript:openCalendar('From Creation Date');"> From:</a>
            <input name="qfromdate">

            <br><a href="javascript:openCalendar('To Creation Date');">To:</a>
            <input name="qtodate">

            <br>
            YYYY-MM-DD HH:MM:SS
               </TD>

               <TD nowrap align="right"></TD>

               </TR>
                </TABLE>
                </TD>
                </TR>
            %endif%
            %endinvoke%
            %endscope%

            </TABLE>
         </TD>
           <TD class="padding">&nbsp;</TD>
          </TR>
          <TR>
           <TD colspan=2 class="padding">&nbsp;</TD>
          </TR>
      %rename property numlines -copy%
      %rename ../../qfromdate qfromdate -copy%
          %rename ../../qtodate qtodate -copy%

          %invoke wm.server.query:getPartialLog%
            <TR>
          <TD colspan=2>
            <TABLE class="tableView">
                  <TR>
                  %ifvar logdate%
                    <TD colspan=7 class="heading">Guaranteed Delivery Log Entries as of %value logdate encode(html)%</TD>
                  %else%
                    <TD colspan=7 class="heading">Guaranteed Delivery Log Entries</TD>
                  %endif%
                  </TR>
                  <TR class="subheading2">
                    <TD>Time Stamp</TD>
                    <TD>Status</TD>
                    <TD>Message</TD>
                    <TD>Error Message</TD>
                    <TD>Root Context</TD>
                    <TD>Parent Context</TD>
                    <TD>Current Context</TD>
                  </TR>
                  %ifvar message%
                    <TR><TD colspan="7">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan=7>%value message encode(html)%</TD></TR>
                  %endif%
                  %ifvar ascendchecked equals('CHECKED')%
                    <TD colspan=7 class="oddrowdata-l">---------------------------------- Beginning of Current Log ----------------------------------</TD>
                  %else%
                    <TD colspan=7 class="oddrowdata-l">---------------------------------- End of Current Log ----------------------------------</TD>
                  %endif%

                  %loop logEntries%
                  <TR>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value AuditTimestamp encode(html)% </TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value TxStatus encode(html)% </TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value TxMsg encode(html)% </TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value TxErrMsg encode(html)% </TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value RootContextID encode(html)% </TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value ParentContextID encode(html)% </TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value ContextID encode(html)% </TD>
                     <SCRIPT>swapRows();</SCRIPT>
                  </TR>
                  %endloop%
                </TABLE>
              </TD>
            </TR>
          </TABLE>
      %endinvoke%
   </FORM>
   %endscope%
   %endinvoke%
 %endscope%
  </BODY>
</HTML>

<script>
if ( document.logform.qfromdate != null && document.logform.qtodate != null )
{
logform.qfromdate.value="%value qfromdate encode(javascript)%";
logform.qtodate.value="%value qtodate encode(javascript)%";
}
</script>
