// 테마 토글
$(function () {
  const $toggle = $("#themeToggle");
  const initial = localStorage.getItem("theme") || "light";
  setTheme(initial);
  $toggle.prop("checked", initial !== "light");

  $toggle.on("change", function () {
    setTheme(this.checked ? "dark" : "light");
  });

  function setTheme(theme) {
    document.documentElement.setAttribute("data-theme", theme);
    localStorage.setItem("theme", theme);
  }
});

//게시글 검색카테고리 유지
$('select[data-value]').each(function(index, el){
	const $el = $(el);
	
	defaultValue = $el.attr('data-value').trim();
	
	if(defaultValue.length > 0){
		$el.val(defaultValue);
	}
});


// Toast 헬퍼
window.showToast = function (message, type = "info", ms = 2500) {
  const $toast = $("#toast");
  const color = {
    info: "alert-info",
    success: "alert-success",
    warning: "alert-warning",
    error: "alert-error",
  }[type] || "alert-info";

  const html = `<div class="alert ${color} shadow">${message}</div>`;
  $toast.removeClass("hidden").append(html);
  setTimeout(() => $toast.addClass("hidden").empty(), ms);
};

// Confirm 모달 (Promise)
window.confirmAsync = function (message = "진행할까요?") {
  return new Promise((resolve) => {
    const modal = document.getElementById("confirmModal");
    $("#confirmMessage").text(message);
    modal.showModal();
    $("#confirmOkBtn").one("click", function () {
      resolve(true);
    });
    $(modal).one("close", function () {
      resolve(false);
    });
  });
};

// 폼 중복 전송 방지
$(document).on("submit", "form[data-safe-submit]", function () {
  const $btn = $(this).find("button[type=submit], input[type=submit]");
  $btn.prop("disabled", true).addClass("loading");
  setTimeout(() => $btn.prop("disabled", false).removeClass("loading"), 3000);
});