<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Article Detail" />
<%@ include file="/WEB-INF/jsp/usr/common/head.jspf"%>

<script>
	let $id = parseInt('${param.id}');
	//console.log('$id : '+$id);
	let isAlreadyAddGoodRp =${isAlreadyAddGoodRp};
	let isAlreadyAddBadRp =${isAlreadyAddBadRp};
</script>

<script>
function ArticleDetail__doIncreaseHitCount(){
	$.get('../article/hitCount', {
		id : $id,
		ajaxMode : 'Y'
	}, function(data){

		$('.article-detail__hit-count').html(data.data1);
	}, 'json'); 
	
}

$(function(){
	<!-- ArticleDetail__doIncreaseHitCount(); -->
	  setTimeout(ArticleDetail__doIncreaseHitCount,2000);
})

</script>

<script>
	function checkRP(){
		if(isAlreadyAddGoodRp==true){
			$('#likeButton').toggleClass('btn-outline');
		}
		else if(isAlreadyAddBadRp==true){
			$('#disLikeButton').toggleClass('btn-outline');
		} else{
			return;
		}
		
	}
	function doGoodReaction(articleId){
		$.ajax({
			url : '/usr/reactionPoint/doGoodReaction',
			type : 'post',
			data : {
				relTypeCode:'article', relId: articleId 
			},
			dataType: 'json', 
			success: function(data){
				console.log(data);
				console.log("data.data1 : "+data.data1);
				console.log("data.data1Name : "+data.data1Name);
				console.log("data.data2 : "+data.data2);
				console.log("data.data2Name : "+data.data2Name);
			}, 
			error: function(jqXHR, textStatus, errorThrown){
				console.log('좋아요 오류 발생 : ' + textStatus)
			}
						
		})
	}
	function doBadReaction(articleId){
		
	}
	
	
	
	$(function(){
		checkRP();
	})
</script>


<table>
	<div class="bg-base-100 shadow">
		<div class="space-y-4">
			<div class="flex items-center justify-between">
				<h2 class="card-title text-2xl">${article.title}</h2>
				<div class="badge badge-outline">#${article.id}</div>
			</div>
			<p class="text-sm text-base-content/70"></p>
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
				<th>조회수(Ajax) :</th>
				<td class="article-detail__hit-count">${article.hitCount}</td>
			</tr>
			<tr>
				<th>SUM :</th>
				<td>${userCanReaction}</td>
			</tr>
			<tr>
				<th>LIKE / DISLIKE</th>
				<td class="flex gap-2">
					<!-- <a href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${article.id }&replaceUri=${rq.getCurrentUri()}" class="article-detail__doGoodReaction btn btn-sm btn-primary">LIKE: ${article.goodReactionPoint}</a> -->
					<button id="likeButton" class="btn btn-sm btn-primary btn-outline" onclick="doGoodReaction(${param.id})">LIKE
						${article.goodReactionPoint}</button>
					<!-- <a href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${article.id }&replaceUri=${rq.getCurrentUri()}" class="btn btn-sm btn-error">DISLIKE:${article.badReactionPoint}</a> -->
					<button id="disLikeButton" class="btn btn-sm btn-error btn-outline" onclick="doBadReaction(${param.id})">DISLIKE
						${article.badReactionPoint}</button>
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