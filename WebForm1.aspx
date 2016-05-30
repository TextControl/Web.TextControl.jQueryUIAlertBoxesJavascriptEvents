<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication9.WebForm1" %>

<%@ Register assembly="TXTextControl.Web, Version=22.0.200.500, Culture=neutral, PublicKeyToken=6b83fe9a75cfb638" namespace="TXTextControl.Web" tagprefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Web.TextControl Sample: Events and Alert Boxes</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       
        <cc1:TextControl ID="TextControl1" runat="server" Dock="Window" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js"></script>

        <script>

            // function to show a jQueryUI alert message box
            var jQueryAlert = function (caption, message) {
                caption = caption || "";
                message = message || "";
                message = message.replace(/\r?\n/g, "<br />");

                $("<div style=\"font-size: 10pt; min-width: 250px\">" + message + "</div>").dialog({
                    modal: true,
                    resizable: false,
                    title: caption,
                    width: "auto",
                    buttons: {
                        OK: function () {
                            $(this).dialog("destroy").remove();
                        },
                    },
                    close: function () {
                        $(this).dialog("destroy").remove();
                    }
                });
            };

            // this event is fired when the ribbon bar is completely loaded
            TXTextControl.addEventListener("ribbonTabsLoaded", function (e) {
                attachEvents();
            });

            // this function attaches events after the ribbon has been loaded completely
            function attachEvents() {

                // attach click event handler to 'load' button
                document.getElementById("fileMnuItemOpen").addEventListener("click", function (e) {
                    waitForFileOpenDialog();
                });

                // attach click event handler to 'save' button, show an alert message box and
                // stop the bubbling of the click event to Web.TextControl
                document.getElementById("fileMnuItemSave").addEventListener("click", function (e) {
                    jQueryAlert("TX Text Control", "Saving documents is not supported in this live demo.\r\n\Download the <a href='http://www.textcontrol.com/en_US/downloads/trials/index/default/dotnetserver/'>trial version</a> to learn more about the file management.");
                    e.cancelBubble = true;
                });
            }

            // wait until the file open dialog is opened
            function waitForFileOpenDialog() {
                var checkExist = setInterval(function () {
                    if (document.getElementById("txOFDSelFileType") != null) {
                        clearInterval(checkExist);
                        reorderListView()
                    }
                }, 100);
            }

            // select 'All Files' and fire the Change event to update the file list
            function reorderListView() {
                setTimeout(function () { document.getElementById("txOFDSelFileType").selectedIndex = 0; fireEvent(document.getElementById("txOFDSelFileType"), "change"); }, 300);
            }

            // this function fires an event of a specific element
            function fireEvent(element, event) {
                if (document.createEventObject) {
                    // dispatch for IE
                    var evt = document.createEventObject();
                    return element.fireEvent('on' + event, evt)
                }
                else {
                    // dispatch for firefox + others
                    var evt = document.createEvent("HTMLEvents");
                    evt.initEvent(event, true, true);
                    return !element.dispatchEvent(evt);
                }
            }

        </script>

        <style>
            #fileMnuItemSaveAs {
                display: none !important;
            }
        </style>
    
    </div>
    </form>
</body>
</html>
