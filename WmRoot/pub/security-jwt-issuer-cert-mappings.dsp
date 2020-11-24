<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js"></script>
  <script language="JavaScript">
    <!--add jscript here-->
	function populateForm(form , issuer, trustAlias, certAlias, oper)
    {
        if('delete' == oper)
        {
            if (!confirm ("OK to delete mapping for Issuer '"+issuer+"'")) {
                return false;
            }
            form.operation.value = 'mapping_del';    
        }
        form.issuer.value = issuer;
		form.truststoreAlias.value = trustAlias;
		form.certificateAlias.value = certAlias;
		  
        return true
    }
    function populateSkewForm(form , issuer, oper)
    {
        if('delete' == oper)
        {
            if (!confirm ("OK to delete mapping for Issuer '"+issuer+"'")) {
                return false;
            }
            form.operation.value = 'skew_mapping_del';    
        }
        form.issuer.value = issuer;
		  
        return true;
    }
	
  </script>
  
  <body onLoad="setNavigation('security-jwt-issuer-cert-mappings.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_JWT_IssuerConfigurationScrn');">
   
    <table width="100%">
        %ifvar hideBreadcrumbs%%else%
            <tr>
                <td class="breadcrumb" colspan="2"> Security &gt; JWT &gt; Issuer Configuration </td>
            </tr>
        %endif%
        %ifvar operation equals('mapping_add')%
            %invoke wm.server.jwt:addIssuerCertMapping%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%   

        %ifvar operation equals('mapping_del')%
            %invoke wm.server.jwt:removeCertMapping%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%     
        
        %ifvar operation equals('skew_mapping_add')%
            %invoke wm.server.jwt:addIssuerSkewMapping%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%
        
        
        %ifvar operation equals('skew_mapping_del')%
            %invoke wm.server.jwt:removeIssuerSkewMapping%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%
             
        <tr>
            <td colspan="2">
                <ul class="listitems">
					<script>createForm("htmlform_jwt_home_return", "security-jwt-settings.dsp", "POST", "BODY");</script>
                    <li class="listitem">
					<script>getURL("security-jwt-settings.dsp","javascript:document.htmlform_jwt_home_return.submit();","Return to JWT")</script>
					</li>
                    <li class="listitem">
					<script>getURL("security-jwt-issuer-cert-mapping-addedit.dsp","javascript:document.htmlform_issuer_cert_mapping_add.submit();","Add Issuer Certificate Mapping")</script>
					</li>
					
					<li class="listitem">
					<script>getURL("security-jwt-issuer-skew-mapping-addedit.dsp","javascript:document.htmlform_issuer_skew_mapping_add.submit();","Add/Update Issuer Skew Mapping")</script>
					</li>
                </ul>
            </td>
        </tr>
        <tr>
                        <td>    
                            <table class="tableView" width="50%">
                                <tr>
                                    <td class="heading" colspan="4">Issuer Certificate Mappings</td>
                                </tr>
                                <TR class="subheading2">
                                    <td>Issuer</td>
                                    <td>Truststore Alias</td>
                                    <td>Certificate Alias</td>
                                    <td>Delete</td>
                                </tr>
                                %invoke wm.server.jwt:listCertMapping%
                                    %loop issuerCertificateMappings%
                                        <tr>
                                            <script>writeTD("row-l");</script>
												%value issuer% 
                                            </td>
                                            <script>writeTD("rowdata");</script>
                                               %value truststoreAlias%
                                            </td>                       
                                            <script>writeTD("rowdata");</script>
                                                %value certificateAlias%
                                            </td>
                                            <script>writeTD("rowdata");</script>
												<a href="javascript:document.htmlform_issuer_cert_mapping_delete.submit();" onClick="return populateForm(document.htmlform_issuer_cert_mapping_delete,'%value issuer encode(javascript)%','%value truststoreAlias encode(javascript)%','%value certificateAlias encode(javascript)%','delete');">
                                                    <img src="icons/delete.png" border="no" alt="Delete Issuer Certificate Mappings %value issuer% ">
                                                </a>    
                                            </td>
                                        </tr>
                                        <script>swapRows();</script>
                                    %endloop%
                                %endinvoke% 
                            </table>
            </td>
        </tr>
        <tr>
                        <td>    
                            <table class="tableView" width="50%">
                                <tr>
                                    <td class="heading" colspan="4">Issuer Skew Mappings</td>
                                </tr>
                                <TR class="subheading2">
                                    <td>Issuer</td>
                                    <td>Skew</td>
                                    <td>Delete</td>
                                </tr>
                                %invoke wm.server.jwt:listIssuerSkewMappings%
                                    %loop issuerSkewMappings%
                                        <tr>
                                            <script>writeTD("row-l");</script>
												%value issuer% 
                                            </td>
                                            <script>writeTD("rowdata");</script>
                                                %value maxIssuerSkew%
                                            </td>
                                            <script>writeTD("rowdata");</script>
												<a href="javascript:document.htmlform_issuer_skew_mapping_delete.submit();" onClick="return populateSkewForm(document.htmlform_issuer_skew_mapping_delete,'%value issuer encode(javascript)%','delete');">
                                                    <img src="icons/delete.png" border="no" alt="Delete Issuer Skew Mappings %value issuer% ">
                                                </a>    
                                            </td>
                                        </tr>
                                        <script>swapRows();</script>
                                    %endloop%
                                %endinvoke% 
                            </table>
            </td>
        </tr>
    </table>
    <form name="htmlform_issuer_cert_mapping_add" action="security-jwt-issuer-cert-mapping-addedit.dsp" method="POST">
		<input type="hidden" name="type" id="type" value="trust">
    </form>
    <form name="htmlform_issuer_cert_mapping_delete" action="security-jwt-issuer-cert-mappings.dsp" method="POST">
        <input type="hidden" name="operation">
        <input type="hidden" name="issuer">
        <input type="hidden" name="truststoreAlias">
		<input type="hidden" name="certificateAlias">
    </form>
    
    <form name="htmlform_issuer_skew_mapping_add" action="security-jwt-issuer-skew-mapping-addedit.dsp" method="POST">
    </form>
    <form name="htmlform_issuer_skew_mapping_delete" action="security-jwt-issuer-cert-mappings.dsp" method="POST">
        <input type="hidden" name="operation">
        <input type="hidden" name="issuer">
        <input type="hidden" name="maxIssuerSkew">
    </form>
  </body>   
</head>
