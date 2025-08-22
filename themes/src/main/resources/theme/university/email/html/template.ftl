<#macro emailLayout>
<html>
<body marginheight="0" topmargin="0" marginwidth="0" style="margin: 0px; background-color: #fff; font-family: Montserrat, Helvetica, Arial, sans-serif;" leftmargin="0">
    <table cellspacing="0" border="0" cellpadding="0" width="100%" bgcolor="#E4E4E4"
        style="@import url(https://fonts.googleapis.com/css?family=Montserrat:300,400,500,700|Montserrat:300,400,600,700); font-family: 'Montserrat', sans-serif;">
        <tr>
            <td>
                <table style="background-color: #fff; max-width:670px;margin:0 auto;border-top: 2px solid #b3261e;" width="100%" border="0"
                    align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="height:75px;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="text-align:center;">
                          <a href="https://sso.uef.edu.vn" title="UEF" target="_blank">
                            <img width="175" 
                                alt="" title=""
                                src="https://sso.uef.edu.vn/welcome-content/uef-logo.png" />
                          </a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="85%" border="0" align="center" cellpadding="0" cellspacing="0"
                                style="text-align:center">
                                <tr>
                                    <td style="height:40px;">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="font-size:18px; color:#505050;">
                                        <#nested>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height:40px;">&nbsp;</td>
                                </tr>
                            </table>
                        </td>
                    <tr>
                        <td style="height:20px;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="text-align:center; background-color: #f7f7f7;padding-top: 55px;padding-bottom: 55px;">
                            <h5 style="font-size:14px; color:#505050; line-height:28px; margin: 0 0 5px;">UEF ID</h5>
                            <p style="font-size:16px; color:#858585; line-height:28px; margin:0 0 0;">${kcSanitize(msg("emailFooterCopyright", 2025))}
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
</#macro>
