<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/usr/common/head.jspf"%>

<c:set var="pageTitle" value="Write Article" />
<div class="card bg-base-100 shadow">
	<div class="card-body">
		<form action="/usr/article/doWrite" method="post" data-safe-submit>
			<tr>
				<th>게시판</th>
				<td>
					<select name="boardId">
						<option value="" selected disabled>게시판을 선택하세요.</option>
						<option value="1">공지사항</option>
						<option value="2">자유게시판</option>
						<option value="3">질의응답</option>
					</select>
				</td>
			</tr>
			<div class="form-control mb-4">
				<label class="label">
					<span class="label-text">제목</span>
				</label>
				<input name="title" type="text" class="input input-bordered" placeholder="제목을 입력하세요" required />
			</div>

			<div class="form-control mb-6">
				<label class="label">
					<span class="label-text">내용</span>
				</label>
				<textarea name="body" class="textarea textarea-bordered h-40" placeholder="내용을 입력하세요" required></textarea>
			</div>

			<div class="flex gap-2 justify-end">
				<a href="/usr/article/list" class="btn">취소</a>
				<button type="submit" class="btn btn-primary">등록</button>
			</div>
		</form>
	</div>
</div>

<%@ include file="/WEB-INF/jsp/usr/common/foot.jspf"%>