<HTML>
  <HEAD>

    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <script src="webMethods.js"></script>

    <script language ="javascript">

      /**
       *
       */
      function loadDocument() {
        setNavigation('settings-mqtt.dsp', 'doc/OnlineHelp/index.html#context/is-onlinehelp/IS_Settings_Messaging_MQTTCreateAliasScrn');
      }

      /**
       * Validation logic
       */
      function validateForm(obj) {

        if (obj.name.value == "") {
          alert("Connection Alias Name must be specified.");
          return false;
        }
        
        if (obj.description.value == "") {
          alert("Description must be specified.");
          return false;
        }

        if (obj.package.value == "") {
          alert("Package must be specified.");
          return false;
        }

        if (obj.host.value == "") {
          alert("Host must be specified.");
          return false;
        }
    
        if (obj.clientId.value == "") {
            alert("Connection Client ID must be specified.");
            return false;
        }else {
            var str = obj.clientId.value;
            var result = /^([A-Za-z][_A-Za-z0-9$]*)$/.test(str);
            if (!result) {
                alert("Connection Client ID must contain only letters, digits, underscores and dollar characters; and it must start with a letter.");
                return false;
            }
        }
    
        if (obj.will_enabled.checked) {
          if (obj.will_qos.value == "") {
            alert("Last-Will QoS must be specified.");
            return false;
          }
      
          if (obj.will_topic.value == "") {
            alert("Last-Will Topic must be specified.");
            return false;
          }
        }

        return true;
      }
    </script>
  </head>

  <body onLoad="loadDocument()">

  <table width="100%">
    %ifvar hideBreadcrumbs%%else%
      <tr>
        <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; MQTT Settings &gt; MQTT Connection Alias &gt; Create</td>
      </tr>
    %endif%
    <tr>
      <td colspan="2">
        <ul class="listitems">
		      <script>createForm("htmlform_settings_mqtt", "mqtt.dsp", "POST", "BODY");</script>
          <li class="listitem"><script>getURL("mqtt.dsp","javascript:document.htmlform_settings_mqtt.submit();","Return to MQTT Settings")</script></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><form name='createform' action="mqtt.dsp" method="post">
        <table class="tableView" width="100%">

          <!--                  -->
          <!-- General Settings -->
          <!--                  -->
          
          <script>swapRows();</script>
          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>
          
          <!-- Connection Alias Name -->
          <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="name">Connection Alias Name</label></td>
            <td class="oddrow-l"><INPUT NAME="name" ID="name" size="50"></td>
          </tr>

          <!-- Description -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="description">Description</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="description" ID="description"size="50"></td>
          </tr>
          
          <!-- Package -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="package">Package</label></td>
            %invoke wm.server.packages:packageList%
            <script>writeTD("row-l");</script><select name="package" ID="package">
                %loop packages%
                  %ifvar enabled equals('true')%
                    %ifvar ../package -notempty%
                      <option %ifvar ../package vequals(name)%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                    %else%
                      <option %ifvar name equals('WmRoot')%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                    %endif%
                  %endif%
                %endloop%
                </select></td>
                %endinvoke%         
          </tr> 
          
          <!--                              -->
          <!-- Connection Protocol Settings -->
          <!--                              -->
          
          <tr>
            <td class="heading" colspan=2>Connection Protocol Settings</td>
          </tr>
          
          <!-- Host -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="host">Host</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="host" ID="host"size="50" value="tcp://localhost:1883"></td>
          </tr> 
          
          <!-- Connection Client ID -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="clientId">Connection Client ID</label></td>
            %invoke wm.server.mqtt:generateClientId%
              <script>writeTD("row-l");</script><INPUT NAME="clientId" ID="clientId"size="50" value="%value generatedClientId%"></td>
            %endinvoke%
          </tr>
          
          <!-- Clean Session -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="cleanSessionEnabled">Use Clean Session for Subscriptions</label></td>
            <script>writeTD("row-l");</script><INPUT TYPE="checkbox" NAME="cleanSessionEnabled" id="cleanSessionEnabled" size="50" checked></td>            
          </tr>
          
          <!-- Timeout -->
          <script>swapRows();</script>           
          <tr>
            <script>writeTD("row-l");</script><label for="timeout">Connection Timeout (seconds)</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="timeout" ID="timeout"size="50" value="30"></td>
          </tr>
          
          <!-- Keep Alive -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="keepAlive">Keep Alive (seconds)</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="keepAlive" ID="keepAlive"size="50" value="60"></td>
          </tr>
          
          <!--                        -->
          <!-- Last-Will Settings          -->
          <!--                        -->
          
          <tr>
            <td class="heading" colspan=2>Last-Will Settings</td>
          </tr>
          
          <!-- Last-Will Enable -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_enabled">Enable Last-Will</label></td>
            <script>writeTD("row-l");</script><INPUT TYPE="checkbox" NAME="will_enable" id="will_enabled" size="50"></td>
          </tr>
          
          <!-- Last-Will Qos -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_qos">Last-Will QoS</label></td>
            <script>writeTD("row-l");</script>
              <select name="will_qos" ID="will_qos">
                <option value="-1" length="50"></option>
                <option value="0">At most once (0)</option>
                <option value="1">At least once (1)</option>
                <option value="2">Exactly once (2)</option>
              </select>
            </td>
          </tr>
          
          <!-- Last-Will Retained -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_retain">Last-Will Retained</label></td>
            <script>writeTD("row-l");</script><INPUT TYPE="checkbox" NAME="will_retain" id="will_retain" size="50"></td>
          </tr>
          
          <!-- Last-Will Topic -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_topic">Last-Will Topic</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="will_topic" ID="will_topic"size="50"></td>
          </tr>
          
          <!-- Last-Will Message Payload -->        
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_payload">Last-Will Message Payload</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="will_payload" ID="will_payload"size="50"></td>
          </tr>
          
          <!-- On Connect Message Payload -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_onConnectPayload">On Connect Message Payload</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="will_onConnectPayload" ID="will_onConnectPayload"size="50"></td>
          </tr>
          
          <!-- On Disconnect Message Payload -->
          <tr>
            <script>writeTD("row-l");</script><label for="will_onDisconnectPayload">On Disconnect Message Payload</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="will_onDisconnectPayload" ID="will_onDisconnectPayload"size="50"></td>
          </tr>
         
         <!--                        -->
         <!-- Security Settings      -->
         <!--                        -->
         
         <tr>
           <td class="heading" colspan=2>Security Settings</td>    
         </tr>
          
         <!-- User Name -->
         <tr>
           <script>writeTD("row-l");</script><label for="user">User Name</label></td>
           <script>writeTD("row-l");</script><INPUT NAME="user" ID="user"size="50"></td>
         </tr>
          
         <!-- Password -->
         <script>swapRows();</script>
         <tr>
           <script>writeTD("row-l");</script><label for="password">Password</label></td>
           <script>writeTD("row-l");</script><input type="password" name="password" ID="password" autocomplete="off" size="50" /></td>
         </tr>
        </table>
               
        <table class="tableView" width="100%">
          <tr>
              <td class="action" colspan=2>

                <input name="action" type="hidden" value="create">
                <input type="submit" value="Save Changes" onClick="javascript:return validateForm(this.form)">
              </td>
            </tr>
        </table>

       </form>

      </td>
    </tr>
  </table>
</body>
</html>
