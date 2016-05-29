var pay = (function(){
	var tabIdx;
	var tab = $('.pay_tab').find('li');
	var tabBox = $('.tab_box');
	var agent = navigator.userAgent;

	return {
		init : function(){

			tabIdx = 0;

			$(parent.window).resize(function(){
				frameResize();
			});

			if(agent.indexOf("MSIE 7.0") > 0 || agent.indexOf("MSIE 8.0") > 0){
				$('.pay_contents ,.b_line').addClass('ie');
			}


			$(document).ready(function(){
				/* gnb 메뉴 활성화 */

				tab.find('a').click(function(){
					tabIdx = $(this).parent().index();

					tab.removeClass('active');
					$(this).parent().addClass('active');

					tabBox.removeClass('active');
					tabBox.eq(tabIdx).addClass('active');
					setTimeout(function(){
						frameResize();
					},50)
				});
			});
		}
	}
})();

pay.init();



require([
	'feature/Menu'

], function (Menu) {
	Menu.activeMenu(1, 1);

});

