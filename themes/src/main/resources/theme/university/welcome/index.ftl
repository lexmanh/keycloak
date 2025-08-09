<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chào mừng đến với UEF SSO</title>
    <link rel="shortcut icon" href="welcome-content/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(to bottom, #f3f4f6, #e5e7eb);
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .wrapper {
            max-width: 900px;
            margin: 1.5rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .content {
            padding: 2.5rem;
        }
        .logo img {
            max-width: 150px;
            height: auto;
            margin-bottom: 1.5rem;
        }
        h1 {
            color: #111827;
            font-size: 1.875rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        p {
            color: #4b5563;
            line-height: 1.6;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }
        .btn-primary {
            background: #bfdbfe;
            color: #1e40af;
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
            font-weight: 500;
            transition: background 0.2s ease;
        }
        .btn-primary:hover {
            background: #93c5fd;
        }
        h3 {
            color: #1f2937;
            font-size: 1.25rem;
            font-weight: 600;
            margin: 1.5rem 0 1rem;
        }
        a {
            color: #3b82f6;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
        ul li {
            margin-bottom: 0.5rem;
        }
        .footer {
            background: #f9fafb;
            color: #4b5563;
            text-align: center;
            padding: 1.5rem;
            font-size: 0.875rem;
        }
        .footer a {
            color: #3b82f6;
        }
        .row{
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
        }
        .col {
            flex: 1;
            min-width: 250px;
        }   
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="content">
            <div class="logo">
                <img src="welcome-content/uef-logo.png" alt="Logo UEF SSO" />
            </div>
            <h1 class="mt-4">Chào mừng đến với UEF I.D.</h1>
            <p class="my-4">Truy cập tất cả các dịch vụ của Trường Đại học Kinh tế - Tài chính TP.HCM - UEF với một lần đăng nhập duy nhất, an toàn.</p>
            
            <div class="row">
                <div class="col">
                    <h3>Liên kết nhanh</h3>
                    <ul>
                        <li><a href="https://daotao.uef.edu.vn" target="_blank">Cổng thông tin đào tạo</a></li>
                        <li><a href="https://student.uef.edu.vn" target="_blank">Cổng thông tin sinh viên</a></li>
                        <li><a href="https://lms.uef.edu.vn" target="_blank">Hệ thống quản lý học tập</a></li>
                        <li><a href="https://library.uef.edu.vn" target="_blank">Thư viện điện tử</a></li>
                        <li><a href="https://portal.uef.edu.vn" target="_blank">Cổng thông tin điện tử</a></li>
                        <li><a href="https://www.uef.edu.vn" target="_blank">Tin tức UEF</a></li>
                    </ul>
                    <h3>Dịch vụ đám mây</h3>
                    <p>Truy cập các dịch vụ đám mây của UEF:</p>
                    <ul>
                        <li><a href="https://workspace.google.com/a/uef.edu.vn" target="_blank">Google Workspace</a></li>
                        <li><a href="https://portal.office.com" target="_blank">Microsoft 365</a></li>
                    </ul>
                </div>
                <div class="col">
                    <h3>Cần hỗ trợ?</h3>
                     <p>Liên hệ đội ngũ hỗ trợ CNTT tại <a href="mailto:it@uef.edu.vn">it@uef.edu.vn</a> hoặc truy cập:</p>
                     <ul>
                         <li><a href="#https://help.uef.edu.vn" target="_blank">Trung tâm trợ giúp UEF</a></li>
                         <li><a href="#https://support.uef.edu.vn" target="_blank">Cổng hỗ trợ UEF</a></li>
                         <li><a href="#https://docs.uef.edu.vn" target="_blank">Tài liệu UEF</a></li>
                     </ul>

                </div>
            </div>
            <!-- 
            <h3>Quản trị</h3>
            <p>Quản lý người dùng, vai trò và cấu hình trong bảng điều khiển quản trị (yêu cầu quyền truy cập phù hợp).</p>
            <a href="admin/" class="btn-primary">Bảng điều khiển quản trị</a>
            -->
        </div>
        <div class="footer">
            <p>&copy; 2025 UEF. Bản quyền thuộc về nhà trường. | <a href="mailto:it@uef.edu.vn">Liên hệ hỗ trợ CNTT</a></p>
        </div>
    </div>
</body>
</html>