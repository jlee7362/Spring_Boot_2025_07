<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/usr/common/head.jspf"%>
<c:set var="pageTitle" value="Join" />

<div class="card bg-base-100 shadow max-w-2xl mx-auto">
  <div class="card-body">
    <form action="/usr/member/doJoin" method="post" id="joinForm" data-safe-submit class="grid md:grid-cols-2 gap-4">
      <div class="form-control">
        <label class="label"><span class="label-text">아이디</span></label>
        <input name="loginId" class="input input-bordered" required />
      </div>
      <div class="form-control">
        <label class="label"><span class="label-text">비밀번호</span></label>
        <input name="loginPw" type="text" class="input input-bordered" required/>
      </div>
      <div class="form-control">
        <label class="label"><span class="label-text">이름</span></label>
        <input name="name" class="input input-bordered" required />
      </div>
      <div class="form-control">
        <label class="label"><span class="label-text">닉네임</span></label>
        <input name="nickname" class="input input-bordered" required />
      </div>
      <div class="form-control">
        <label class="label"><span class="label-text">휴대폰</span></label>
        <input name="cellphoneNum" type="text" class="input input-bordered"/>
      </div>
      <div class="form-control">
        <label class="label"><span class="label-text">이메일</span></label>
        <input name="email" type="text" class="input input-bordered"/>
      </div>

      <div class="md:col-span-2 flex justify-end gap-2 mt-4">
        <a href="/usr/home/main" class="btn">취소</a>
        <button class="btn btn-primary" type="submit">회원가입</button>
      </div>
    </form>
  </div>
</div>

<script>
  $("#joinForm").on("submit", function(e){
    const email = $("input[name=email]").val().trim();
    if(!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)){
      e.preventDefault();
      showToast("이메일 형식을 확인해주세요.", "warning");
    }
  });
</script>

<%@ include file="/WEB-INF/jsp/usr/common/foot.jspf"%>