package com.spring.wetre.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.spring.wetre.common.MyUtil;



   // ===== 공통관심사 클래스(Aspect 클래스)생성하기 =====
   @Aspect
   @Component
   public class LoginCheck {
      
      // 개인회원 전용 Pointcut 을 생성한다.
      @Pointcut("execution(public * com.spring.wetre..*Controller.requirePrivateLogin_*(..))")
      public void requirePrivateLogin() {}
      
      // == Before Advice 를 구현한다. ==
      @Before("requirePrivateLogin()")
      public void before1(JoinPoint joinPoint) {
         
         // 로그인 유무를 확인하기 위해서 request를 통해 session을 얻어온다.
         HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[0];
         HttpServletResponse response = (HttpServletResponse)joinPoint.getArgs()[1];
         
         HttpSession session = request.getSession(); // 세션값을 얻어온다.
         
         // 개인회원 로그인 보조업무 처리 시작
         if ( session.getAttribute("loginuser") == null ) {
        	 
        	 String msg = "먼저 로그인 하세요!";
       	     String loc = "";
       	            	     
       	     loc = request.getContextPath()+"/privateLogin.we";
       	     
	       	 request.setAttribute("msg", msg);
	         request.setAttribute("loc", loc);
	          
	         // >> 로그인 성공 후 로그인 하기전 페이지로 돌아가는 작업하기 << //
	         // == 현재페이지의 주소(URL) 알아내기 ==
	         String url = MyUtil.getCurrentURL(request);
	          
	         // System.out.println(">> 확인용 현재 페이지 URL :" + url);
	          
	         session.setAttribute("gobackURL", url);
	          
	         RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
	          
	         try {
	             dispatcher.forward(request, response);
	         } catch (ServletException | IOException e) {
	             e.printStackTrace();
	         }
       	     
         } // end of if --------------------------------------------------
         // 개인회원 로그인 보조업무 처리 끝
      }
      
      
      
      //////////////////////////////////////////////////////////////////////////////////////////
      
      // 기업회원 전용 Pointcut 을 생성한다.
      @Pointcut("execution(public * com.spring.wetre..*Controller.requireCompanyLogin_*(..))")
      public void requireCompanyLogin() {}
      
      // == Before Advice 를 구현한다. ==
      @Before("requireCompanyLogin()")
      public void before2(JoinPoint joinPoint) {
         
         // 로그인 유무를 확인하기 위해서 request를 통해 session을 얻어온다.
         HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[0];
         HttpServletResponse response = (HttpServletResponse)joinPoint.getArgs()[1];
         
         HttpSession session = request.getSession(); // 세션값을 얻어온다.
         
         // 기업회원 로그인 보조업무 처리 시작
         if ( session.getAttribute("companyuser") == null ) {
        	 
        	 String msg = "먼저 로그인 하세요!";
       	     String loc = "";
       	            	     
       	     loc = request.getContextPath()+"/companyLogin.we";
       	     
	       	 request.setAttribute("msg", msg);
	         request.setAttribute("loc", loc);
	          
	         // >> 로그인 성공 후 로그인 하기전 페이지로 돌아가는 작업하기 << //
	         // == 현재페이지의 주소(URL) 알아내기 ==
	         String url = MyUtil.getCurrentURL(request);
	          
	         // System.out.println(">> 확인용 현재 페이지 URL :" + url);
	          
	         session.setAttribute("gobackURL", url);
	          
	         RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
	          
	         try {
	             dispatcher.forward(request, response);
	         } catch (ServletException | IOException e) {
	             e.printStackTrace();
	         }
         } // end of if --------------------------------------------------
         // 기업회원 로그인 보조업무 처리 끝
      }
      
      
      //////////////////////////////////////////////////////////////////////////////////////////
      
      // 개인회원 및 기업회원 공용 Pointcut 을 생성한다.
      @Pointcut("execution(public * com.spring.wetre..*Controller.requireAssociationLogin_*(..))")
      public void requireAssociationLogin() {}
      
      // == Before Advice 를 구현한다. ==
      @Before("requireAssociationLogin()")
      public void before3(JoinPoint joinPoint) {
         
         // 로그인 유무를 확인하기 위해서 request를 통해 session을 얻어온다.
         HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[0];
         HttpServletResponse response = (HttpServletResponse)joinPoint.getArgs()[1];
         
         HttpSession session = request.getSession(); // 세션값을 얻어온다.
         
         // 개인회원 및 기업회원 공용 로그인 보조업무 처리 시작
         if ( session.getAttribute("loginuser") == null && session.getAttribute("companyuser") == null ) {
        	 
        	 String msg = "먼저 로그인 하세요!";
       	     String loc = "";
       	            	     
       	     loc = request.getContextPath()+"/index.we";
       	     
	       	 request.setAttribute("msg", msg);
	         request.setAttribute("loc", loc);
	          
	         // >> 로그인 성공 후 로그인 하기전 페이지로 돌아가는 작업하기 << //
	         // == 현재페이지의 주소(URL) 알아내기 ==
	         String url = MyUtil.getCurrentURL(request);
	         	          
	         session.setAttribute("gobackURL", url);
	          
	         RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
	          
	         try {
	             dispatcher.forward(request, response);
	         } catch (ServletException | IOException e) {
	             e.printStackTrace();
	         }         
         } // end of if --------------------------------------------------
         // 개인회원 및 기업회원 공용 로그인 보조업무 처리 끝
               
      }

      
}