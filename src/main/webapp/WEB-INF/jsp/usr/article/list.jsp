<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Article List" />
<%@ include file="/WEB-INF/jsp/usr/common/head.jspf"%>

<div class="card bg-base-100 shadow mt-10">
	<div class="card-body gap-4">
		<div>
			<tr>게시판 : ${board!=null ? board.code :'전체 게시글'}
			</tr>
			<tr>| 게시물 수 : ${articlesCount }
			</tr>
		</div>
		<!-- <div class="flex flex-col md:flex-row md:items-center gap-3 justify-between">
			<div class="join">
				<input id="searchInput" type="text" class="input input-bordered join-item" placeholder="제목 검색…" />
				<button id="searchBtn" class="btn btn-primary join-item">검색</button>
			</div>
			<c:if test="${rq.isLogined() }">
				<a href="/usr/article/write" class="btn btn-secondary">새 글 작성</a>
			</c:if>
		</div> -->
		<div class="flex justify-end">
			<div class="flex">
				<form action="">
					<input type="hidden" name="boardId" value="${boardId }"/>
					<div class="flex">
					<select class="select select-sm select-boardered max-w-xs" name="searchKeywordTypeCode">
						<option value="title">제목</option>
						<option value="body">내용</option>
						<option value="title, body">제목 + 내용</option>
						<option value="nickname">작성자</option>
					</select>
					
					<label class="ml-3 input input-boardered input-sm flex items-center gap-2">
					<input type="text" placeholder="Search" name="searchKeyword" value="${param.searchKeyword }"/>
					<button type="submit"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="h-4 w-4 opacity-70">
    <path fill-rule="evenodd"
									d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z"
									clip-rule="evenodd" />
  </svg></button>
					
					</label>
					</div>
				</form>
			</div>
		</div>

		<div class="overflow-x-auto">
			<table class="table table-zebra">
				<thead>
					<tr>
						<th>ID</th>
						<th>Registration Date</th>
						<th>Title</th>
						<th>Writer</th>
					</tr>
				</thead>
				<tbody id="articleTbody">
					<c:forEach var="article" items="${articles}">
						<tr class="hover cursor-pointer" onclick="location.href='/usr/article/detail?id=${article.id}'">
							<td>${article.id}</td>
							<td>${article.regDate}</td>
							<td class="text-primary">${article.title}</td>
							<td>${article.extra__writer}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty articles }">
						<tr>
							<td colspan="4" style="text-align: center;">게시글이 없습니다.</td>
						</tr>

					</c:if>
				</tbody>
			</table>
		</div>

		<div class="join justify-center">
			<div class="btn-group">
				<c:set var="paginationLen" value="3" />
				<c:set var="startPage" value="${page - paginationLen >= 1 ? page - paginationLen : 1 }" />
				<c:set var="endPage" value="${page + paginationLen < pagesCount ? page + paginationLen : pagesCount }"></c:set>
				<c:set var="baseUri" value="?boardId=${boardId}&" />
				<c:set var="baseUri" value="${baseUri}searchKeywordTypeCode=${searchKeywordTypeCode}&" />
				<c:set var="baseUri" value="${baseUri}searchKeyword=${searchKeyword}&" />

				<c:if test="${startPage > 1 }">
					<a class="btn" href="${baseUri}&page=1">1</a>

				</c:if>
				<c:if test="${startPage > 2 }">
					<button>...</button>
				</c:if>


				<c:forEach begin="${startPage }" end="${endPage }" var="i">
					<a class="btn ${page==i ? 'text-red-500' :'' }" href="${baseUri}&page=${i}">${i}</a>
				</c:forEach>

				<c:if test="${endPage < pagesCount-1}">
					<button>...</button>
				</c:if>

				<c:if test="${endPage < pagesCount}">

					<a class="btn" href="${baseUri}&page=${pagesCount}">${pagesCount }</a>
				</c:if>


			</div>
		</div>

		<!-- 	<script>
			$("#searchBtn").on(
					"click",
					function() {
						const q = $("#searchInput").val().trim();
						if (!q)
							return showToast("검색어를 입력하세요", "warning");
						// 서버 검색으로 연결하려면 아래 URL 규칙을 컨트롤러에 맞춰 변경
						location.href = "/usr/article/list?searchKeyword="
								+ encodeURIComponent(q);
					});
		</script> -->

		<%@ include file="/WEB-INF/jsp/usr/common/foot.jspf"%>