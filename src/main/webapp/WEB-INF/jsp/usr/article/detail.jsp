<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Article Detail" />
<%@ include file="/WEB-INF/jsp/usr/common/head.jspf"%>

<script>
let $id = parseInt('${param.id}');
console.log('$id : '+$id);
</script>

<script>
function ArticleDetail__doIncreaseHitCount(){
	$.get('../article/hitCount', {
		id : $id,
		ajaxMode : 'Y'
	}, function(data){
		console.log('data : ' + data);
		console.log('data.data1 : ' + data.data1);
		console.log('data.msg : ' + data.msg);
		$('.article-detail__hit-count').html(data.data1);
	}, 'json'); 
	
}

$(function(){
	ArticleDetail__doIncreaseHitCount();
})

</script>

<table>
<div class="bg-base-100 shadow">
	<div class="space-y-4">
		<div class="flex items-center justify-between">
			<h2 class="card-title text-2xl">${article.title}</h2>
			<div class="badge badge-outline">#${article.id}</div>
		</div>
		<p class="text-sm text-base-content/70"> </p>
			<tr>
				<th>등록:</th>
				<td>${article.regDate}</td>
			</tr>
			<c:if test="${article.regDate != article.updateDate }">
			<tr>
				<th>수정:</th>
				<td>${article.updateDate}</td>
			</tr>
			</c:if>
			<tr>
				<th>조회수:</th>
				<td>${article.hitCount}</td>
			</tr>
			<tr>
				<th>조회수(Ajax) : </th>
				<td class="article-detail__hit-count">${article.hitCount}</td>
			</tr>
			<tr>
				<th>SUM : </th>
				<td>${userCanReaction}</td>
			</tr>	
			<tr>
			<th>LIKE / DISLIKE </th>
			<td class="flex gap-2">
				<a href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${article.id }&replaceUri=${rq.currentUri}" class="btn btn-sm btn-primary">LIKE: ${article.goodReactionPoint}</a>
				<a class="btn btn-sm btn-error">DISLIKE:${article.badReactionPoint}</a>
			</td>
			
		</tr>
			
</table>
		

		<div class="prose max-w-none whitespace-pre-wrap">${article.body}</div>


		<div class="divider"></div>
		<div class="flex gap-2 justify-end">
			<c:if test="${article.userCanModify}">
				<a href="/usr/article/modify?id=${article.id}" class="btn btn-warning">수정</a>
				<button class="btn btn-error" onclick="onDelete(${article.id})">삭제</button>
			</c:if>
			<a href="/usr/article/list" class="btn">목록</a>
		</div>
	</div>
</div>

<script>
 async function onDelete(id){
   const ok = await confirmAsync("정말 삭제하시겠어요?");
   if(!ok) return;
   location.href = "/usr/article/doDelete?id=" + id;
 }
</script>

<%@ include file="/WEB-INF/jsp/usr/common/foot.jspf"%>