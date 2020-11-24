/*
 * Copyright © 1996 - 2017 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. 
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. 
*/
    function setQuiescePort(form, key)
    {
        var a = key.value.split(',');
        form.port.value=a[0];
        form.package.value=a[1];
        form.portAlias.value=a[2];
    }