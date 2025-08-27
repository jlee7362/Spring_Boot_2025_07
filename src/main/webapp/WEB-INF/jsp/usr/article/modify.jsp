<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Modify Article" />

<%@ include file="/WEB-INF/jsp/usr/common/head.jspf"%>


<script>
 async function onDelete(id){
   const ok = await confirmAsync("정말 삭제하시겠어요?");
   if(!ok) return;
   location.href = "/usr/article/doDelete?id=" + id;
 }
</script>

<div class="card bg-base-100 shadow">
  <div class="card-body">
    <form action="/usr/article/doModify" method="post" data-safe-submit>
      <input type="hidden" name="id" value="${article.id}" />
      <div class="form-control mb-4">
        <label class="label"><span class="label-text">제목</span></label>
        <input name="title" type="text" class="input input-bordered" value="${article.title}" required />
      </div>

      <div class="form-control mb-6">
        <label class="label"><span class="label-text">내용</span></label>
        <textarea name="body" class="textarea textarea-bordered h-40" required>${article.body}</textarea>
      </div>

      <div class="flex gap-2 justify-end">
        <a href="/usr/article/detail?id=${article.id}" class="btn">취소</a>
        <button type="submit" class="btn btn-primary btn-outline">수정</button>
        <button class="btn btn-error btn-outline" onclick="onDelete(${article.id})">삭제</button>
      </div>
    </form>
  </div>
</div>


<%@ include file="/WEB-INF/jsp/usr/common/foot.jspf"%>