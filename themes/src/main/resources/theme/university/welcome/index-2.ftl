<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chào mừng đến với UEF</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9fafb;
        }
        .header {
            background-color: #6b46c1;
            color: white;
            padding: 1rem;
            text-align: center;
        }
        .header a {
            color: white;
            margin: 0 1rem;
            text-decoration: none;
        }
        .header a:hover {
            text-decoration: underline;
        }
        .maintenance {
            background-color: #bee3f8;
            color: #2d3748;
            padding: 1rem;
            margin: 1rem 0;
            text-align: center;
        }
        .content {
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
        }
        .section {
            background-color: white;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .section h2 {
            color: #6b46c1;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        .section p {
            color: #4a5568;
            line-height: 1.6;
            margin-bottom: 1rem;
        }
        .btn {
            background-color: #6b46c1;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            text-decoration: none;
            margin-right: 1rem;
        }
        .btn:hover {
            background-color: #553c9a;
        }
        .links {
            display: flex;
            justify-content: space-around;
            margin-top: 2rem;
        }
        .links div {
            text-align: center;
        }
        .links a {
            color: #6b46c1;
            text-decoration: none;
        }
        .links a:hover {
            text-decoration: underline;
        }
        .footer {
            background-color: #2d3748;
            color: white;
            text-align: center;
            padding: 1rem;
            position: fixed;
            width: 100%;
            bottom: 0;
        }
        .footer a {
            color: #a0aec0;
            margin: 0 0.5rem;
            text-decoration: none;
        }
        .footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="#">Trang chủ</a>
        <a href="#">Hướng dẫn</a>
        <a href="#">Câu hỏi thường gặp</a>
        <a href="#" style="float: right;">Đăng nhập nhân viên</a>
        <h1>Chào mừng đến với UEF</h1>
    </div>
    <div class="maintenance">
        Cảnh báo bảo trì hệ thống<br>
        Hệ thống sẽ được bảo trì từ Thứ Năm, ngày 07/08/2025 15:00 đến Thứ Năm, ngày 14/08/2025 08:00 và sẽ không khả dụng trong thời gian này. Xin lỗi vì sự bất tiện này.
    </div>
    <div class="content">
        <p>Chào mừng đến với Trường Đại học Kinh tế - Tài chính! Đối với tất cả sinh viên mới, xin chúc mừng vì đã nhận được suất học tại đây. Đối với sinh viên tiếp tục, chào mừng trở lại! Bắt đầu đại học là một thời gian thú vị và bận rộn. Các trang này sẽ hướng dẫn bạn qua các bước quan trọng cần hoàn thành trước khi đến, và đảm bảo những tuần đầu tiên diễn ra suôn sẻ nhất có thể.</p>
        
        <div class="section">
            <h2>Sinh viên mới</h2>
            <p>Nếu bạn có lời mời nhập học không điều kiện từ trường chúng tôi, trước khi đăng nhập, bạn sẽ cần tạo một tài khoản Chào mừng.</p>
            <p>Nếu bạn đã học tại UEF trong quá khứ và bắt đầu lại trước ngày 01/09/2025, bạn sẽ cần tạo một tài khoản Chào mừng mới với mã số sinh viên được gửi qua email.</p>
            <a href="login/" class="btn">Đăng nhập</a>
            <a href="reset/" class="btn">Đặt lại mật khẩu</a>
        </div>

        <div class="section">
            <h2>Sinh viên tiếp tục</h2>
            <p>Là sinh viên tiếp tục, bạn không cần tạo tài khoản mới. Nhấn nút đăng nhập dưới đây để truy cập tài khoản Chào mừng hiện có của bạn bằng xác thực đa yếu tố (MFA).</p>
            <a href="login/" class="btn">Đăng nhập tài khoản UEF</a>
            <p>Nếu bạn gặp vấn đề khi sử dụng MFA, vui lòng truy cập trang Hỗ trợ Thư viện & Sinh viên để biết thêm chi tiết.</p>
            <a href="reset/" class="btn">Đặt lại mật khẩu UEF</a>
        </div>

        <div class="links">
            <div><a href="#">Hỗ trợ sinh viên</a></div>
            <div><a href="#">Học phí & Học bổng</a></div>
            <div><a href="#">Microsoft Office Online</a></div>
            <div><a href="#">Chuẩn bị học tập LBU</a></div>
            <div><a href="#">Ứng dụng UEF</a></div>
            <div><a href="#">Nhà ở</a></div>
            <div><a href="#">Hội sinh viên</a></div>
            <div><a href="#">Thư viện & Hỗ trợ CNTT</a></div>
        </div>

        <p>Nếu bạn gặp vấn đề, vui lòng gửi email cho Đội ngũ Chào mừng, ghi rõ mã số sinh viên của bạn.</p>
        <p>Trường đại học có trách nhiệm bảo vệ dữ liệu cá nhân của bạn. Thông báo Quyền riêng tư giải thích cách dữ liệu của bạn được sử dụng, chia sẻ và bảo vệ, cũng như các lựa chọn bạn có liên quan đến dữ liệu cá nhân và cách liên hệ với chúng tôi.</p>
    </div>
    <div class="footer">
        <img src="welcome-content/uef-logo.png" alt="UEF Logo" style="height: 20px; vertical-align: middle;">
        <span>UEF | +84 123 456 7890 | </span><a href="#">Tìm chúng tôi</a>
        <a href="#">Khả năng truy cập</a> | <a href="#">Tuyên bố từ chối</a> | <a href="#">Quyền riêng tư</a> | <a href="#">Liên hệ với chúng tôi</a>
        <p>&copy; 2025 Trường Đại học Kinh tế - Tài chính</p>
    </div>
</body>
</html>