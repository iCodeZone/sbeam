package sbeam.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FileFilter implements Filter {

    public void doFilter(ServletRequest arg0, ServletResponse arg1,
                         FilterChain filterChain) throws IOException, ServletException {

        //获取request
        HttpServletRequest request = (HttpServletRequest)arg0;
        //获取response
        HttpServletResponse response = (HttpServletResponse)arg1;
        //获取session
        HttpSession session = request.getSession();

        //获取访问的路径
        String path = request.getRequestURI();

        System.out.println("path:"+path);

        //地址栏直接访问action的话重定向
        if(request.getHeader("Referer")==null && !path.contains(".jsp")){
            System.out.println("阻止");
            response.sendRedirect("http://localhost:8000/sbeam/index.jsp");
            return;
        }

        //不能直接访问安装包
        if(path.indexOf("/package/")!=-1){
            response.sendRedirect("http://localhost:8000/sbeam/index.jsp");
            return;
        }

        //登录界面不过滤
        if(path.contains("/login.jsp") || path.contains("Login.jsp")){
            filterChain.doFilter(arg0, arg1);
            return;
        }
        //登录失败界面不过滤
        if(path.contains("/loginfail.jsp") || path.contains("LoginFail.jsp")){
            filterChain.doFilter(arg0, arg1);
            return;
        }
        //注册界面不过滤
        if(path.indexOf("egister.jsp")>-1){
            filterChain.doFilter(arg0, arg1);
            return;
        }
        //注册成功界面不过滤
        if(path.contains("RegisterSuccess.jsp")){
            filterChain.doFilter(arg0, arg1);
            return;
        }
        //注册失败界面不过滤
        if(path.contains("RegisterFail.jsp") || path.contains("registerfail.jsp")){
            filterChain.doFilter(arg0, arg1);
            return;
        }
        //index界面不过滤
        if(path.indexOf("index.jsp")>-1){
            filterChain.doFilter(arg0, arg1);
            return;
        }
        //登录action不过滤
        if(path.contains("Login") || path.contains("login")){
            filterChain.doFilter(arg0, arg1);
            return;
        }
        //注册action不过滤
        if(path.contains("Register") || path.contains("register")){
            filterChain.doFilter(arg0, arg1);
            return;
        }
        //使用css与js不拦截
        if(path.contains(".css") || path.contains("bootstrap.js")  || path.contains("cosmos_canvas.js")  || path.contains("jquery-3.3.1.js") || path.contains(".css.map")){
            filterChain.doFilter(arg0, arg1);
            return;
        }
        //git与png不拦截
        if(path.contains(".git") || path.contains(".png")){
            filterChain.doFilter(arg0, arg1);
            return;
        }


        //获取登录情况
        Integer type = (Integer) session.getAttribute("type");
        if(type==null){
            System.out.println("拦截");
            response.sendRedirect("http://localhost:8000/sbeam/index.jsp");
            return;
        }

        filterChain.doFilter(arg0, arg1);
    }
}
