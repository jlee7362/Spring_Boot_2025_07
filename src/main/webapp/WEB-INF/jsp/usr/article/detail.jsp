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
	const localStorageKey  = 'article__'+$id+'__alreadyViewed';
	console.log("localStorageKey : "+localStorageKey);
	if(localStorage.getItem(localStorageKey)){
		return;
	}
	localStorage.setItem(localStorageKey, true);
	
	$.get('../article/hitCount', {
		id : $id,
		ajaxMode : 'Y'
	}, function(data){

		$('.article-detail__hit-count').html(data.data1);
	}, 'json'); 
	
}

$(function(){
	//ArticleDetail__doIncreaseHitCount();
	  setTimeout(ArticleDetail__doIncreaseHitCount,500);
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
		
		if(${!isLogined}){
			alert('로그인하고 이용하세요.');
			location.replace('/usr/member/login');
			return;
		}
		
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
				
				//좋아요 개수 갱신
				$('.likeCount').text(data.data1);
				$('.disLikeCount').text(data.data2);
				
				//좋아요 취소
				if(data.resultCode == 'S-1'){
					$('#likeButton').toggleClass('btn-outline');
				}
				//좋아요
				else if(data.resultCode == 'S-2'){
					$('#likeButton').toggleClass('btn-outline');
				}else if(data.resultCode == 'S-3'){
					$('#likeButton').toggleClass('btn-outline');
					$('#disLikeButton').toggleClass('btn-outline');
				}else{
					alert(data.msg);
				}
				
			}, 
			error: function(jqXHR, textStatus, errorThrown){
				console.log('좋아요 오류 발생 : ' + textStatus)
			}
						
		})
	}
	function doBadReaction(articleId){
		$.ajax({
			url : '/usr/reactionPoint/doBadReaction',
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
				
				//좋아요 개수 갱신
				$('.likeCount').text(data.data1);
				$('.disLikeCount').text(data.data2);
				
				//좋아요 취소
				if(data.resultCode == 'S-1'){
					$('#disLikeButton').toggleClass('btn-outline');
				}
				//좋아요
				else if(data.resultCode == 'S-2'){
					$('#disLikeButton').toggleClass('btn-outline');
				}else if(data.resultCode == 'S-3'){
					$('#likeButton').toggleClass('btn-outline');
					$('#disLikeButton').toggleClass('btn-outline');
				}else{
					alert(data.msg);
				}
				
			}, 
			error: function(jqXHR, textStatus, errorThrown){
				console.log('좋아요 오류 발생 : ' + textStatus)
			}
						
		})
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
					<button id="likeButton" class="btn btn-sm btn-primary btn-outline" onclick="doGoodReaction(${param.id})">
						LIKE
						<span class="likeCount">${article.goodReactionPoint}</span>
					</button>
					<button id="disLikeButton" class="btn btn-sm btn-error btn-outline" onclick="doBadReaction(${param.id})">
						DISLIKE
						<span class="disLikeCount">${article.badReactionPoint}</span>
					</button>
				</td>
			</tr>
</table>

<script>
	function replyWrite__submit(form){
		console.log('form.body : ', form.body );
		console.log('form.body.value : ', form.body.value);
		
		if(form.body.value.length < 3){
			alert("3글자 이상 입력하세요.");
			form.body.focus();
			return;
		}
		form.submit();
	}
</script>


<div class="mt-6">

	<section>
	<c:if test="${rq.isLogined() }">
		<form action="../reply/doWrite" method="post" onsubmit="replyWrite__submit(this); return false;">
			<input type="hidden" name="relTypeCode" value="article" />
			<input type="hidden" name="relId" value="${article.id }" />
			<table class="table" border="1" style="width: 100%;">
				<tbody>
					<tr>
						<th>댓글 내용 입력</th>
						<td>
							<textarea class="textarea textarea-primary input input-bordered input-sm w-full max-w-xs" name="body" autocomplete="off" class="textarea"
								placeholder="댓글 입력란"></textarea>
						</td>
						<td>
							<button class="btn btn-outline btn-sm">작성</button>
						</td>
					</tr>

				</tbody>
			</table>

		</form>
</c:if>
<c:if test="${!rq.isLogined() }">
<div style="text-align: center; margin-top: 20px;"> 댓글 작성을 하려면 <a href="${rq.getLoginUri() }" class="btn btn-primary btn-xs">로그인</a>이 필요합니다.</div>
</c:if>
	</section>
<script>

function toggleModifybtn(replyId){
	$('#modify-btn-' + replyId).hide();
	$('#save-btn-' + replyId).show();
	$('#reply-body-'+ replyId).hide();
	$('#modify-form-'+ replyId).show();
	
	
}
function doModifyReply(replyId){
	
	//수정기능
	let form = $('#modify-form-'+replyId);
	console.log('form : '+ form);
	
	let text = form.find('input[name="reply-text-'+replyId +'"]').val();
	console.log('input val : '+ text);
	let action = form.attr('action');
	console.log('action: '+ action);
	
	$.post({
		url : action,
		type: 'GET',
		data: {
			id : replyId,
			body : text
		}, success: function(data){
			$('#modify-btn-'+ replyId).show();
			$('#save-btn-'+ replyId).hide();
			$('#reply-body-'+ replyId).text(data);
			$('#reply-body-'+ replyId).show();
			$('#modify-form-'+ replyId).hide();
			
		}, error: function(xhr, status, error){
			alert('댓글 수정 실패: ' + error );
		}
	})
}

</script>
	<div class="space-y-4">
		<c:forEach var="reply" items="${replies}">
			<div class="card bg-base-200 shadow-md">
				<div class="card-body p-4">
					<div class="flex justify-between items-center">
						<span class="font-semibold text-sm">${reply.extra__writer}</span>
						<span class="text-xs text-gray-400">${reply.regDate}</span>
					</div>
					<p class="mt-2 text-sm"id="reply-body-${reply.id }">${reply.body}</p>
					
					<form class="textarea textarea-primary input input-bordered input-sm w-full max-w-xs" action="#" style="display:none;" id="modify-form-${reply.id }" onsubmit="return false">
						<input name="reply-text-${reply.id }" type="text" value="${reply.body }"/>
					</form>
					
					<div class="mt-3 flex gap-3 text-xs">
						<span class="badge badge-outline badge-success">👍 ${reply.goodReactionPoint}</span>
						<span class="badge badge-outline badge-error">👎 ${reply.badReactionPoint}</span>
						<c:if test="${reply.userCanModify }">
							<button onclick="toggleModifybtn('${reply.id }')" id="modify-btn-${reply.id }">수정</button>
							<button onclick="doModifyReply('${reply.id }') "id="save-btn-${reply.id }" style="display:none;">저장</button>
						</c:if>
						<c:if test="${reply.userCanDelete }">
						<a onclick="if(confirm('정말 삭제?')==false) return false;" href="../reply/doDelete?id=${reply.id}&articleId=${article.id}">삭제</a>
						</c:if>
					</div>
				</div>
			</div>
		</c:forEach>
		<c:if test="${empty replies}">
			<div class="card bg-base-200 shadow-md">
				<div class="card-body p-6 text-center text-md text-gray-400">💬 아직 댓글이 없습니다.</div>
			</div>
		</c:if>
	</div>
</div>
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