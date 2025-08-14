<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/usr/common/head.jspf"%>
<c:set var="pageTitle" value="Login" />

<div class="hero min-h-[60vh]">
  <div class="hero-content w-full max-w-md">
    <div class="card bg-base-100 w-full shadow">
      <div class="card-body">
        <form action="/usr/member/doLogin" method="post" data-safe-submit>
          <div class="form-control">
            <label class="label"><span class="label-text">아이디</span></label>
            <input name="loginId" class="input input-bordered" required />
          </div>
          <div class="form-control mt-3">
            <label class="label"><span class="label-text">비밀번호</span></label>
            <input name="loginPw" type="password" class="input input-bordered" required />
          </div>
          <div class="form-control mt-6">
            <button class="btn btn-primary" type="submit">로그인</button>
          </div>
          <div class="text-sm text-right mt-2">
            <a href="/usr/member/join" class="link">회원가입</a>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/jsp/usr/common/foot.jspf"%>