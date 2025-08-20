<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="UEF I.D. - Đăng nhập một lần để truy cập tất cả dịch vụ của Trường Đại học Kinh tế - Tài chính TP.HCM">
    <title>Chào mừng đến với UEF SSO</title>
    <link rel="shortcut icon" href="welcome-content/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@3.4.10/dist/tailwind.min.css">
    <link rel="stylesheet" href="welcome-content/styles.css">
</head>
<body>
    <div class="wrapper" role="main">
        <div class="content">
            <div class="logo">
                <img src="welcome-content/uef-logo.png" alt="Logo UEF SSO" width="150" height="50" />
            </div>
            <h2 class="mt-4">Chào mừng đến với UEF I.D.</h2>
            <p class="my-4">Truy cập tất cả các dịch vụ của Trường Đại học Kinh tế - Tài chính TP.HCM - UEF với một lần đăng nhập duy nhất, an toàn.</p>
            <div id="auth-section" class="my-4">
                <a href="${(url.loginUrl)!'/realms/university/account'}" class="btn btn-primary">Đăng nhập với UEF I.D.</a>
            </div>
            <div class="row">
                <div class="col">
                    <h3>Truy cập nhanh</h3>
                    <ul>
                        <li><a href="https://daotao.uef.edu.vn" target="_blank" rel="noopener noreferrer">Cổng thông tin đào tạo</a></li>
                        <li><a href="https://student.uef.edu.vn" target="_blank" rel="noopener noreferrer">Cổng thông tin sinh viên</a></li>
                        <li><a href="https://lms.uef.edu.vn" target="_blank" rel="noopener noreferrer">Hệ thống quản lý học tập</a></li>
                        <li><a href="https://library.uef.edu.vn" target="_blank" rel="noopener noreferrer">Thư viện điện tử</a></li>
                        <li><a href="https://portal.uef.edu.vn" target="_blank" rel="noopener noreferrer">Cổng thông tin điện tử</a></li>
                        <li><a href="https://www.uef.edu.vn" target="_blank" rel="noopener noreferrer">Tin tức UEF</a></li>
                    </ul>
                    <h3 class="mt-8">Khác</h3>
                    <p>Các dịch vụ đám mây của UEF</p>
                    <ul>
                        <li><a href="https://workspace.google.com/a/uef.edu.vn" target="_blank" rel="noopener noreferrer">Google Workspace</a></li>
                        <li><a href="https://portal.office.com" target="_blank" rel="noopener noreferrer">Microsoft 365</a></li>
                    </ul>
                </div>
                <div class="col">
                    <h3>Cần hỗ trợ?</h3>
                    <p>Truy cập <a href="https://help.uef.edu.vn" target="_blank" rel="noopener noreferrer">Trung tâm trợ giúp</a></p>
                    <p class="mt-4">Hoặc liên hệ Trung tâm QL.CNTT bằng cách:</p>
                    <ul style="list-style-type: square; margin-left: 1rem;">
                        <li><p>Gửi email tới địa chỉ <a href="mailto:it@uef.edu.vn">it@uef.edu.vn</a></p></li>
                        <li><p>Gọi điện thoại đến số <a href="tel:02822363333">028 2236 3333</a> (ext. 2160)</p></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="footer">
            <p>&copy; 2025. Bản quyền thuộc về  Trường Đại học Kinh tế - Tài chính TP.HCM - UEF.</p>
        </div>
    </div>
</body>
</html>