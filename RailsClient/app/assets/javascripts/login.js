/**
 * Created by 宋福祯 on 15/8/13.
 */
function Login() {
    var UserName = document.getElementById("user_email").value;
    var PassWord = document.getElementById("user_password").value;
    var FailLogin = document.getElementById("FailLogin");
    var CheckPassword = document.getElementById("CheckPassword");
    var CheckUserName = document.getElementById("CheckUsername");
    var Fail = document.getElementById("Fail");

    if (UserName == "") {
        CheckUserName.innerHTML = "请输入用户名";
    } else if (PassWord == "") {
        CheckPassword.innerHTML = "请输入密码";
        setTimeout("CheckPassword.style.display='none' ", 2000);
    } else if (UserName == "admin" && PassWord == "1") {
        //阻塞掉
        document.login_form.submit();
        FailLogin.style.display = "block";
        Fail.innerHTML = "登录成功";
        //延时1秒进入
        setTimeout("window.location.href = 'Main.html'", 2000);
    } else {
        FailLogin.style.display = "block";
        Fail.innerHTML = "用户名或密码错误";
        setTimeout("FailLogin.style.display='none'", 2000);
    }
}